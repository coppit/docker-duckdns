# docker-duckdns


This is a simple Docker container for running the [Duck DNS](http://duckdns.org) dynamic DNS update script. It will keep your domain.duckdns.org DNS alias up-to-date as your home IP changes. The script runs every 30 minutes.

Both IPv4 and IPv6 are supported.

## Usage

This docker image is available as a [trusted build on the docker index](https://index.docker.io/u/coppit/duckdns/).

There are two modes of running this container. The first is with environment variables:

`sudo docker run --name=duckdns -d -v /etc/localtime:/etc/localtime -v /config/dir/path:/config -e DOMAINS=<domains> -e TOKEN=<token> -e INTERVAL=<interval> -e IPV6=<yes or no> coppit/duckdns`

The second mode is with a config file. To create a template config file, run:

`sudo docker run --name=duckdns -d -v /etc/localtime:/etc/localtime -v /config/dir/path:/config coppit/duckdns`

When run for the first time, a file named duck.conf will be created in the config dir, and the container will exit. Edit this file, setting the required and optional settings. Then rerun the command.

To check the status, run `docker logs duckdns`.

## Required Settings

The domains to update and security token are required. Domains should be comma-separated.

## Optional Settings

The update interval should be a number followed by "d", "h", or "m", indicating days, hours, and minutes, respectively. The minimum update interval is 5 minutes.

By default IPv6 is not enabled. Set IPV6 to "yes" to enable it.

## Credits

IPv6 support by [davebv](https://github.com/davebv).
