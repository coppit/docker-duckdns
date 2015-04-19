THIS IS MY TEST DOCKER. PLEASE USE THE OFFICIAL ONE AT https://registry.hub.docker.com/u/coppit/duckdns/


docker-duckdns
==============

This is a simple Docker container for running the [Duck DNS](http://duckdns.org) dynamic DNS update script. It will keep
your domain.duckdns.org DNS alias up-to-date as your home IP changes. the script runs every 5 minutes.

Usage
-----

Create a config file /path/to/duckdns/duck.conf with the following:

```
DOMAINS=yourdomain
TOKEN=yourtoken
```


