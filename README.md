docker-duckdns
==============

This is a simple Docker container for running the [Duck DNS](http://duckdns.org) dynamic DNS update script. It will keep
your domain.duckdns.org DNS alias up-to-date as your home IP changes.

Usage
-----

Create a config file /config/dir/path/duck.conf with the following:

```
DOMAINS=yourdomain
TOKEN=yourtoken
INTERVAL=5m
```


