#!/bin/bash

  #Search for custom config file, if it doesn't exist, copy the default one
  if [ ! -f /config/duck.conf ]; then
    echo "Using default config file. Please do not forget to enter your domain and token info on duck.conf"
    cp /root/duckdns/duck.conf /config/duck.conf
    chmod a+w /config/duck.conf
  fi
  
  #Get docker env timezone and set system timezone
  echo $TZ > /etc/timezone
  export DEBCONF_NONINTERACTIVE_SEEN=true DEBIAN_FRONTEND=noninteractive
  dpkg-reconfigure tzdata
