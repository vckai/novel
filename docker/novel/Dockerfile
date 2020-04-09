FROM golang:stretch

RUN apt-get update && apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor

WORKDIR /usr/app
USER root

# CMD ["/usr/bin/supervisord", "-c", "supervisord.conf"]