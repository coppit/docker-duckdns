#!/bin/bash

. /etc/envvars.merged

#https://www.duckdns.org/update?domains={YOURVALUE}&token={YOURVALUE}[&ip={YOURVALUE}][&ipv6={YOURVALUE}][&verbose=true][&clear=true]
endpoint=https://www.duckdns.org/update

#-----------------------------------------------------------------------------------------------------------------------

function ts {
  echo [`date '+%b %d %X'`]
}

#-----------------------------------------------------------------------------------------------------------------------

if [ "$IPV6" = "yes" ]; then
  ip6=`ifconfig | grep inet6 | grep -i global | awk -F " " '{print $3}' | awk -F "/" '{print $1}'`
  ip4=
  echo "IP address is ${ip6}"
else
  echo "Will detect ipv4 automatically"
  ip6=
  ip4=
fi

while true
do
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
