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

if [ -z "$INTERVAL" ]; then
  INTERVAL='30m'
fi

if [ -z "$IPV6" ]; then
  IPV6='no'
elif [ "$IPV6" = "yes" ]; then
  echo "Using IPV6 for updates"
else
  echo "For IPv6, please use IPV6=yes in duck.conf"
  IPV6='no'
fi

if [[ ! "$INTERVAL" =~ ^[0-9]+[mhd]$ ]]; then
  echo "INTERVAL must be a number followed by m, h, or d. Example: 5m"
  exit 1
fi

if [[ "${INTERVAL: -1}" == 'm' && "${INTERVAL:0:-1}" -lt 5 ]]; then
  echo "The shortest allowed INTERVAL is 5 minutes"
  exit 1
fi

#https://www.duckdns.org/update?domains={YOURVALUE}&token={YOURVALUE}[&ip={YOURVALUE}][&ipv6={YOURVALUE}][&verbose=true][&clear=true]
endpoint=https://www.duckdns.org/update

#-----------------------------------------------------------------------------------------------------------------------

function ts {
  echo [`date '+%b %d %X'`]
}

#-----------------------------------------------------------------------------------------------------------------------

while true
do
  if [ "$IPV6" = "yes" ]; then
    ip6=`ifconfig | grep inet6 | grep -i global | awk -F " " '{print $3}' | awk -F "/" '{print $1}'`
    ip4=
    echo "IP address is ${ip6}"
  else
    echo "Will detect ipv4 automatically"
    ip6=
    ip4=
  fi

  RESPONSE=$(curl -S -s "${endpoint}?domains=$DOMAINS&token=$TOKEN&ip=${ip4}&ipv6=${ip6}" 2>&1)

  if [ "$RESPONSE" = "OK" ]
  then
    echo "$(ts) DuckDNS successfully called. Result was \"$RESPONSE\"."
  elif [[ "$RESPONSE" == "KO" ]]
  then
    echo "$(ts) DuckDNS reported an error. Check your settings. Result was \"$RESPONSE\"."
    exit 2
  else
    # For example: "curl: (6) Could not resolve host: www.duckdns.org". Also sometimes the response is ""
    echo "$(ts) Something went wrong. Result was \"$RESPONSE\". Trying again in 5 minutes."
  fi

  sleep $INTERVAL
done
