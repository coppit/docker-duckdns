#!/bin/bash

  tr -d '\r' < /config/duck.conf > /tmp/duck.conf

  . /tmp/duck.conf

  if [ -z "$DOMAINS" ]; then
    echo "DOMAINS must be defined in duck.conf"
    exit 1
  elif [ "$DOMAINS" = "yourdomain" ]; then
    echo "Please enter your domain in duck.conf"
    exit 1
  fi

  if [ -z "$TOKEN" ]; then
    echo "TOKEN must be defined in duck.conf"
    exit 1
  elif [ "$TOKEN" = "yourtoken" ]; then
    echo "Please enter your token in duck.conf"
    exit 1
  fi
  
  echo url="https://www.duckdns.org/update?domains=$DOMAINS&token=$TOKEN&ip=" | curl -s -k -K -
  echo "  "$(date)
