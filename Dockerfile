FROM alpine:3.7

MAINTAINER David Coppit <david@coppit.org>

ENV TERM=xterm-256color

RUN true && \
\
echo "http://dl-cdn.alpinelinux.org/alpine/v3.7/community" >> /etc/apk/repositories && \
apk --update upgrade && \
\
# Basics, including runit
apk add bash curl htop runit && \
\
# Needed by our code
apk add net-tools && \
\
rm -rf /var/cache/apk/* && \
\
# RunIt stuff
adduser -h /home/user-service -s /bin/sh -D user-service -u 2000 && \
chown user-service:user-service /home/user-service && \
mkdir -p /etc/run_once /etc/service

# Boilerplate startup code
COPY ./boot.sh /sbin/boot.sh
RUN chmod +x /sbin/boot.sh
CMD [ "/sbin/boot.sh" ]

VOLUME ["/config"]

# Create template config file
COPY duck.conf /files/duck.conf

# run-parts ignores files with "." in them
COPY parse_config_file.sh /etc/run_once/parse_config_file
RUN chmod +x /etc/run_once/parse_config_file

COPY duck.sh /etc/service/duckdns/run
RUN chmod +x /etc/service/duckdns/run
