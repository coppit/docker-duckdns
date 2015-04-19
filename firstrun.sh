#!/bin/bash

  #Search for custom config file, if it doesn't exist, copy the default one
  if [ ! -f /config/duck.conf ]; then
    echo "Using default config file duck.conf"
    cp /root/duckdns/duck.conf /config/duck.conf
    chmod a+w /config/duck.conf
  fi
