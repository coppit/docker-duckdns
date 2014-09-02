docker-duckdns
==============

This is a simple Docker container for running the [Duck DNS](http://duckdns.org) dynamic DNS update script. It will keep
your domain.duckdns.org DNS alias up-to-date as your home IP changes.

Usage
-----

This docker image is available as a [trusted build on the docker index](https://index.docker.io/u/coppit/duckdns/).

Create a config file /config/dir/path/duck.conf with the following:

```
DOMAINS=yourdomain
TOKEN=yourtoken
INTERVAL=5m
```

Then run:

`sudo docker run --name=duckdns -d -v /config/dir/path:/config coppit/duckdns`

A log file /config/dir/path/duck.log will be created. If everything is working fine, then every 5 minutes an “OK” line
will be appended to the log.

This container is stateless. If you don't need it anymore, you can `stop` and `remove` it.
