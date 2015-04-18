# The config file is named duck.conf, and has the format:
# DOMAINS=<your domain>
# TOKEN=<your token>
# INVERVAL=<update period. e.g. "5m" or "1h">

# Output will be written to /config/duck.log

FROM phusion/baseimage:0.9.11

MAINTAINER aptalca (based on original docker by David Coppit <david@coppit.org>)

VOLUME ["/config"]

ADD duck.sh /root/duckdns/duck.sh

CMD /bin/bash -c '/root/duckdns/duck.sh >/config/duck.log 2>&1'
