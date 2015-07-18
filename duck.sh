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

#-----------------------------------------------------------------------------------------------------------------------

function ts {
  echo [`date '+%b %d %X'`]
}

#-----------------------------------------------------------------------------------------------------------------------

while true
do
  RESPONSE=$(curl -S -s "https://www.duckdns.org/update?domains=$DOMAINS&token=$TOKEN&ip=" 2>&1)

  if [ "$RESPONSE" = "OK" ]
  then
    echo "$(ts) DuckDNS successfully called. Result was \"$RESPONSE\"."
  elif [[ "$RESPONSE" == "" ]]
  then
    echo "$(ts) Something went wrong. Result was empty. Trying again in 5 minutes."
  else
    echo "$(ts) Something went wrong. Check your settings. Result was \"$RESPONSE\"."
    exit 2
  fi

  sleep 300
done
