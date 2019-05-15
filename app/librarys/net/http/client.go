package http

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"io"
	"net"
	xhttp "net/http"
	"net/url"
	"strconv"
	"strings"
	"sync"
	"time"

	pkgerr "github.com/pkg/errors"
)

const (
	_minRead = 16 * 1024 // 16kb
)

// ClientConfig is http client conf.
type ClientConfig struct {
	*App
	Dial      time.Duration
	Timeout   time.Duration
	KeepAlive time.Duration
	URL       map[string]*ClientConfig
	Host      map[string]*ClientConfig
}

// Client is http client.
type Client struct {
	conf      *ClientConfig
	client    *xhttp.Client
	dialer    *net.Dialer
	transport xhttp.RoundTripper

	urlConf  map[string]*ClientConfig
	hostConf map[string]*ClientConfig
	mutex    sync.RWMutex
}

// NewClient new a http client.
func NewClient(c *ClientConfig) *Client {
	client := new(Client)
	client.conf = c
	client.dialer = &net.Dialer{
		Timeout:   time.Duration(c.Dial),
		KeepAlive: time.Duration(c.KeepAlive),
	}

	originTransport := &xhttp.Transport{
		DialContext:     client.dialer.DialContext,
		TLSClientConfig: &tls.Config{InsecureSkipVerify: true},
	}

	// wraps RoundTripper for tracer
	client.transport = &TraceTransport{RoundTripper: originTransport}
	client.client = &xhttp.Client{
		Transport: client.transport,
	}
	client.urlConf = make(map[string]*ClientConfig)
	client.hostConf = make(map[string]*ClientConfig)
	if c.Timeout <= 0 {
		panic("must config http timeout!!!")
	}
	for uri, cfg := range c.URL {
		client.urlConf[uri] = cfg
	}
	for host, cfg := range c.Host {
		client.hostConf[host] = cfg
	}
	return client
}

// SetTransport set client transport
func (client *Client) SetTransport(t xhttp.RoundTripper) {
	client.transport = t
	client.client.Transport = t
}

// SetConfig set client config.
func (client *Client) SetConfig(c *ClientConfig) {
	client.mutex.Lock()
	if c.App != nil {
		client.conf.App.Key = c.App.Key
		client.conf.App.Secret = c.App.Secret
	}
	if c.Timeout > 0 {
		client.conf.Timeout = c.Timeout
	}
	if c.KeepAlive > 0 {
		client.dialer.KeepAlive = time.Duration(c.KeepAlive)
		client.conf.KeepAlive = c.KeepAlive
	}
	if c.Dial > 0 {
		client.dialer.Timeout = time.Duration(c.Dial)
		client.conf.Timeout = c.Dial
	}
	for uri, cfg := range c.URL {
		client.urlConf[uri] = cfg
	}
	for host, cfg := range c.Host {
		client.hostConf[host] = cfg
	}
	client.mutex.Unlock()
}

// NewRequest new http request with method, uri, ip, values and headers.
func (client *Client) NewRequest(method, uri string, params url.Values, headers xhttp.Header) (req *xhttp.Request, err error) {
	if method == xhttp.MethodGet {
		req, err = xhttp.NewRequest(xhttp.MethodGet, ru, nil)
	} else {
		bodyStr := strings.TrimSpace(values.Encode())
		req, err = xhttp.NewRequest(xhttp.MethodPost, uri, strings.NewReader(bodyStr))
	}
	if err != nil {
		err = pkgerr.Wrapf(err, "method:%s,uri:%s", method, ru)
		return
	}
	const (
		_contentType      = "Content-Type"
		_urlencoded       = "application/x-www-form-urlencoded"
		_userAgent        = "User-Agent"
		_userAgentMozilla = "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1541.0 Safari/537.36"
	)
	if method == xhttp.MethodPost {
		req.Header.Set(_contentType, _urlencoded)
	}
	req.Header.Set(_userAgent, _userAgentMozilla)

	for k, vs := range header {
		req.Header.Set(k, vs)
	}

	return
}

// Get issues a GET to the specified URL.
func (client *Client) Get(c context.Context, uri string, headers xhttp.Header, res interface{}) (err error) {
	req, err := client.NewRequest(xhttp.MethodGet, uri, nil, headers)
	if err != nil {
		return
	}
	return client.Do(c, req, res)
}

// Post issues a Post to the specified URL.
func (client *Client) Post(c context.Context, uri string, params url.Values, headers xhttp.Header, res interface{}) (err error) {
	req, err := client.NewRequest(xhttp.MethodPost, uri, params, headers)
	if err != nil {
		return
	}
	return client.Do(c, req, res)
}

// Raw sends an HTTP request and returns bytes response
func (client *Client) Raw(c context.Context, req *xhttp.Request, v ...string) (bs []byte, err error) {
	var (
		ok      bool
		code    string
		cancel  func()
		resp    *xhttp.Response
		config  *ClientConfig
		timeout time.Duration
		uri     = fmt.Sprintf("%s://%s%s", req.URL.Scheme, req.Host, req.URL.Path)
	)
	// NOTE fix prom & config uri key.
	if len(v) == 1 {
		uri = v[0]
	}
	// stat
	now := time.Now()
	defer func() {
		clientStats.Timing(uri, int64(time.Since(now)/time.Millisecond))
		if code != "" {
			clientStats.Incr(uri, code)
		}
	}()
	// get config
	// 1.url config 2.host config 3.default
	client.mutex.RLock()
	if config, ok = client.urlConf[uri]; !ok {
		if config, ok = client.hostConf[req.Host]; !ok {
			config = client.conf
		}
	}
	client.mutex.RUnlock()
	// timeout
	deliver := true
	timeout = time.Duration(config.Timeout)
	if deadline, ok := c.Deadline(); ok {
		if ctimeout := time.Until(deadline); ctimeout < timeout {
			// deliver small timeout
			timeout = ctimeout
			deliver = false
		}
	}
	if deliver {
		c, cancel = context.WithTimeout(c, timeout)
		defer cancel()
	}
	setTimeout(req, timeout)
	req = req.WithContext(c)
	setCaller(req)
	if color := metadata.String(c, metadata.Color); color != "" {
		setColor(req, color)
	}
	if resp, err = client.client.Do(req); err != nil {
		err = pkgerr.Wrapf(err, "host:%s, url:%s", req.URL.Host, realURL(req))
		code = "failed"
		return
	}
	defer resp.Body.Close()
	if resp.StatusCode >= xhttp.StatusBadRequest {
		err = pkgerr.Errorf("incorrect http status:%d host:%s, url:%s", resp.StatusCode, req.URL.Host, realURL(req))
		code = strconv.Itoa(resp.StatusCode)
		return
	}
	if bs, err = readAll(resp.Body, _minRead); err != nil {
		err = pkgerr.Wrapf(err, "host:%s, url:%s", req.URL.Host, realURL(req))
		return
	}
	return
}

// Do sends an HTTP request and returns an HTTP json response.
func (client *Client) Do(c context.Context, req *xhttp.Request, res interface{}, v ...string) (err error) {
	var bs []byte
	if bs, err = client.Raw(c, req, v...); err != nil {
		return
	}
	if res != nil {
		if err = json.Unmarshal(bs, res); err != nil {
			err = pkgerr.Wrapf(err, "host:%s, url:%s", req.URL.Host, realURL(req))
		}
	}
	return
}

// JSON sends an HTTP request and returns an HTTP json response.
func (client *Client) JSON(c context.Context, req *xhttp.Request, res interface{}, v ...string) (err error) {
	var bs []byte
	if bs, err = client.Raw(c, req, v...); err != nil {
		return
	}
	if res != nil {
		if err = json.Unmarshal(bs, res); err != nil {
			err = pkgerr.Wrapf(err, "host:%s, url:%s", req.URL.Host, realURL(req))
		}
	}
	return
}

// realUrl return url with http://host/params.
func realURL(req *xhttp.Request) string {
	if req.Method == xhttp.MethodGet {
		return req.URL.String()
	} else if req.Method == xhttp.MethodPost {
		ru := req.URL.Path
		if req.Body != nil {
			rd, ok := req.Body.(io.Reader)
			if ok {
				buf := bytes.NewBuffer([]byte{})
				buf.ReadFrom(rd)
				ru = ru + "?" + buf.String()
			}
		}
		return ru
	}
	return req.URL.Path
}

// readAll reads from r until an error or EOF and returns the data it read
// from the internal buffer allocated with a specified capacity.
func readAll(r io.Reader, capacity int64) (b []byte, err error) {
	buf := bytes.NewBuffer(make([]byte, 0, capacity))
	// If the buffer overflows, we will get bytes.ErrTooLarge.
	// Return that as an error. Any other panic remains.
	defer func() {
		e := recover()
		if e == nil {
			return
		}
		if panicErr, ok := e.(error); ok && panicErr == bytes.ErrTooLarge {
			err = panicErr
		} else {
			panic(e)
		}
	}()
	_, err = buf.ReadFrom(r)
	return buf.Bytes(), err
}
