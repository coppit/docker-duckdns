#!/bin/bash

  if [ ! -f /config/duck.conf ]; then
    cp /root/duckdns/duck.conf /config/duck.conf
  fi
