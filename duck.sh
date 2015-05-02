#!/bin/bash

# Search for custom config file, if it doesn't exist, copy the default one
if [ ! -f /config/duck.conf ]; then
  echo "Creating config file. Please do not forget to enter your domain and token info on duck.conf"
  cp /root/duckdns/duck.conf /config/duck.conf
  chmod a+w /config/duck.conf
  exit 1
fi

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
  echo "Your IP was last updated at "$(date)
else
  echo "Something went wrong, check your settings  "$(date)
fi
