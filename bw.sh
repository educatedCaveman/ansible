#!/bin/bash

# requires the following variables are exported, in place of using one's email address
# - BW_CLIENTID="user.junk"
# - BW_CLIENTSECRET="alphabet_soup"
# https://bitwarden.com/help/article/personal-api-key/

# check BW_CLIENTID
if [[ -z "${BW_CLIENTID}" ]]; then
    echo "BW_CLIENTID env var is not set. exiting..."
fi

# check BW_CLIENTSECRET
if [[ -z "${BW_CLIENTSECRET}" ]]; then
    echo "BW_CLIENTSECRET env var is not set. exiting..."
fi

echo "bitwarden login:"
bw login --apikey

echo "\nBitwarden unlocking:"
SESSION_TXT=$(bw unlock)
echo "\n\nBitwarden session text:"
echo "${SESSION_TEXT}"
