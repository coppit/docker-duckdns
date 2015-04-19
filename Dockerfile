# The config file is named duck.conf, and has the format:
# DOMAINS=<your domain>
# TOKEN=<your token>
# TIMEZONE=<your timezone>

# Output will be written to /config/duck.log

FROM phusion/baseimage:0.9.11

MAINTAINER David Coppit <david@coppit.org>

VOLUME ["/config"]

# Add dynamic dns script
ADD duck.sh /root/duckdns/duck.sh

# Create template config file
ADD duck.conf /root/duckdns/duck.conf

# Check if conf file already exits, if not copy template
RUN mkdir -p /etc/my_init.d
ADD firstrun.sh /etc/my_init.d/firstrun.sh
RUN chmod +x /etc/my_init.d/firstrun.sh

# Add our crontab file
ADD duckcron.conf /root/duckdns/duckcron.conf

# Incorporate the crontab file
RUN crontab /root/duckdns/duckcron.conf

# Start cron
RUN cron
