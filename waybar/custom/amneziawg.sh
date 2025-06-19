#!/bin/bash

test -d /proc/sys/net/ipv4/conf/wg0
if [[ $? -eq 0 ]]; then
    IP_ADDRESS=$(ip addr show wg0 | awk '/inet/ {print $2}' | cut -d/ -f1)
    
    printf '{"text": "ON", "tooltip": "Tunneled as %s"}' $IP_ADDRESS
else
    printf '{"text": "OFF"}' 
fi


