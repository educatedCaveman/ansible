#!/bin/bash

source /etc/default/apt-proxy-checker

if [[ $APT_PROXY_ENABLED == "1" ]] && nc -w1 -z $APT_PROXY_HOST $APT_PROXY_PORT &>/dev/null; then
    echo "http://$APT_PROXY_HOST:$APT_PROXY_PORT"
else
    echo "DIRECT"
fi 