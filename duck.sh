#!/bin/bash

while true
do
  if [ ! -f /config/duck.conf ]; then
    echo "Could not find /config/duck.conf"
    exit 1
  fi

  tr -d '\r' < /config/duck.conf > /tmp/duck.conf

  . /tmp/duck.conf

  if [ -z "$INTERVAL" ]; then
    echo "INTERVAL must be defined in duck.conf"
    exit 1
  fi

  if [ -z "$DOMAINS" ]; then
    echo "DOMAINS must be defined in duck.conf"
    exit 1
  fi

  if [ -z "$TOKEN" ]; then
    echo "TOKEN must be defined in duck.conf"
    exit 1
  fi

  echo url="https://www.duckdns.org/update?domains=$DOMAINS&token=$TOKEN&ip=" | curl -s -k -K -
  # Append a newline to the "OK" output by curl
  echo

  sleep $INTERVAL
done
