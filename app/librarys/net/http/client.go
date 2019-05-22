package http

import (
	"bytes"
	"context"
	"crypto/tls"
	"encoding/json"
	"io"
	"net"
	xhttp "net/http"
	"net/url"
	"strings"
	"time"

	pkgerr "github.com/pkg/errors"
)

const (
	_minRead = 16 * 1024 // 16kb
)

// ClientConfig is http client conf.
type ClientConfig struct {
	Dial          time.Duration
	Timeout       time.Duration
	KeepAlive     time.Duration
	ProxyURL      string
	CheckRedirect func(req *xhttp.Request, via []*xhttp.Request) error
}

// Client is http client.
type Client struct {
	conf   *ClientConfig
	client *xhttp.Client
	dialer *net.Dialer
}

// NewClient new a http client.
func NewClient(c *ClientConfig) *Client {
	client := new(Client)
	client.conf = c

	if c.Timeout <= 0 {
		panic("must config http timeout!!!")
	}

	return client
}

// SetProxy set client proxy.
func (client *Client) SetProxy(proxyURL string) {
	client.conf.ProxyURL = proxyURL
}

// SetConfig set client config.
func (client *Client) SetConfig(c *ClientConfig) {
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
	if len(c.ProxyURL) > 0 {
		client.conf.ProxyURL = c.ProxyURL
	}
	if c.CheckRedirect != nil {
		client.conf.CheckRedirect = c.CheckRedirect
	}
}

// NewRequest new http request with method, uri, ip, values and headers.
func (client *Client) NewRequest(method, uri string, values url.Values, headers xhttp.Header) (req *xhttp.Request, err error) {
	if method == xhttp.MethodGet {
		req, err = xhttp.NewRequest(xhttp.MethodGet, uri, nil)
	} else {
		bodyStr := strings.TrimSpace(values.Encode())
		req, err = xhttp.NewRequest(xhttp.MethodPost, uri, strings.NewReader(bodyStr))
	}
	if err != nil {
		err = pkgerr.Wrapf(err, "method:%s,uri:%s", method, uri)
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

	for k, vs := range headers {
		req.Header[k] = vs
	}

	return
}

// Get issues a GET to the specified URL.
func (client *Client) Get(c context.Context, uri string, headers xhttp.Header) ([]byte, *xhttp.Response, error) {
	req, err := client.NewRequest(xhttp.MethodGet, uri, nil, headers)
	if err != nil {
		return nil, nil, err
	}
	return client.Do(c, req)
}

// Post issues a POST to the specified URL.
func (client *Client) Post(c context.Context, uri string, values url.Values, headers xhttp.Header) ([]byte, *xhttp.Response, error) {
	req, err := client.NewRequest(xhttp.MethodPost, uri, values, headers)
	if err != nil {
		return nil, nil, err
	}
	return client.Do(c, req)
}

// Raw sends an HTTP request and returns bytes response
func (client *Client) Raw(c context.Context, req *xhttp.Request) (bs []byte, resp *xhttp.Response, err error) {
	var (
		cancel  func()
		timeout time.Duration
	)

	client.dialer = &net.Dialer{
		Timeout:   time.Duration(client.conf.Dial),
		KeepAlive: time.Duration(client.conf.KeepAlive),
	}

	transport := &xhttp.Transport{
		DialContext:     client.dialer.DialContext,
		TLSClientConfig: &tls.Config{InsecureSkipVerify: true},
	}

	if len(client.conf.ProxyURL) > 0 {
		proxyURL, err := url.Parse(client.conf.ProxyURL)
		if err == nil {
			transport.Proxy = xhttp.ProxyURL(proxyURL)
		}
	}

	client.client = &xhttp.Client{
		Transport:     transport,
		CheckRedirect: client.conf.CheckRedirect,
	}

	// timeout
	deliver := true
	timeout = time.Duration(client.conf.Timeout)
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
	req = req.WithContext(c)
	if resp, err = client.client.Do(req); err != nil {
		err = pkgerr.Wrapf(err, "url:%s", realURL(req))
		return
	}
	defer resp.Body.Close()
	if resp.StatusCode >= xhttp.StatusBadRequest {
		err = pkgerr.Errorf("incorrect http status:%d url:%s", resp.StatusCode, realURL(req))
		return
	}
	if bs, err = readAll(resp.Body, _minRead); err != nil {
		err = pkgerr.Wrapf(err, "url:%s", realURL(req))
		return
	}

	return
}

// Do sends an HTTP request and returns
func (client *Client) Do(c context.Context, req *xhttp.Request) (res []byte, resp *xhttp.Response, err error) {
	if res, resp, err = client.Raw(c, req); err != nil {
		return
	}
	return
}

// JSON sends an HTTP request and returns an HTTP json response.
func (client *Client) JSON(c context.Context, req *xhttp.Request, res interface{}) (resp *xhttp.Response, err error) {
	var bs []byte
	if bs, resp, err = client.Raw(c, req); err != nil {
		return
	}
	if res != nil {
		if err = json.Unmarshal(bs, res); err != nil {
			err = pkgerr.Wrapf(err, "url:%s", realURL(req))
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
