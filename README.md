docker-duckdns
==============

This is a simple Docker container for running the [Duck DNS](http://duckdns.org) dynamic DNS update script. It will keep your domain.duckdns.org DNS alias up-to-date as your home IP changes. The script runs every 5 minutes.

Usage
-----

This docker image is available as a [trusted build on the docker index](https://index.docker.io/u/coppit/duckdns/).

Run:

`sudo docker run --name=duckdns -d -v /etc/localtime:/etc/localtime -v /config/dir/path:/config coppit/duckdns`

When run for the first time, a file named duck.conf will be created in the config dir, and the container will exit. Edit this file, adding your domain and token. Then rerun the command.

To check the status, run `docker logs duckdns`.
