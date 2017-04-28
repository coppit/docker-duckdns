FROM phusion/baseimage:0.9.21

MAINTAINER David Coppit <david@coppit.org>

VOLUME ["/config"]

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Create template config file
ADD duck.conf /root/duckdns/duck.conf

RUN mkdir /etc/service/duckdns
ADD duck.sh /etc/service/duckdns/run
RUN chmod +x /etc/service/duckdns/run
