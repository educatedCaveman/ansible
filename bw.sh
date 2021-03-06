#!/bin/bash

# requires the following variables are exported, in place of using one's email address
# - BW_CLIENTID="user.junk"
# - BW_CLIENTSECRET="alphabet_soup"
# https://bitwarden.com/help/article/personal-api-key/

bw logout
# check BW_CLIENTID
if [[ -z "${BW_CLIENTID}" ]]; then
    echo "BW_CLIENTID env var is not set. exiting..."
    exit 1
fi

# check BW_CLIENTSECRET
if [[ -z "${BW_CLIENTSECRET}" ]]; then
    echo "BW_CLIENTSECRET env var is not set. exiting..."
    exit 1
fi

# echo "bitwarden login:"
bw login --apikey

echo "Unlock BitWarden Vault:"
SESSION_TXT=$(bw unlock | tee)
# echo "Bitwarden session text:"
# echo "${SESSION_TXT}"

SESSION_LINE=$(echo "${SESSION_TXT}" | grep "export BW_SESSION")
echo "line containing the session key is:"
echo "${SESSION_LINE}"

bw logout
