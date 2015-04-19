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
  
  RESPONSE=`curl -s "https://www.duckdns.org/update?domains=$DOMAINS&token=$TOKEN&ip="`
  if [ "$RESPONSE" = "OK" ]; then
  echo "Your IP was updated at "$(date)
  else
  echo "Something went wrong, check your settings  "$(date)
  fi
