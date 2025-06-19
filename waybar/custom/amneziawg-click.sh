#!/bin/bash

test -d /proc/sys/net/ipv4/conf/wg0
if [[ $? -eq 0 ]]; then
    awg-quick down wg0
else
    awg-quick up wg0
fi
