# docker-duckdns


This is a simple Docker container for running the [Duck DNS](http://duckdns.org) dynamic DNS update script. It will keep your domain.duckdns.org DNS alias up-to-date as your home IP changes. The script runs every 5 minutes.

Both IPv4 and IPv6 are supported.

## Usage

This docker image is available as a [trusted build on the docker index](https://index.docker.io/u/davebv/docker-duckdns/).

Run:

`sudo docker run --name=duckdns -d -v /etc/localtime:/etc/localtime -v /config/dir/path:/config davebv/docker-duckdns`

When run for the first time, a file named duck.conf will be created in the config dir, and the container will exit. Edit this file, adding your domain and token. Then rerun the command.

To check the status, run `docker logs duckdns`.

## IPv6

By default IPv6 is not enabled. In order to enable it, uncomment the line in duck.conf to enable IPv6
`IPV6=yes`

## Credits
Image updated from https://github.com/coppit/docker-duckdns
