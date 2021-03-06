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

# must first log out, to make sure the key will be printed later
bw logout

# use the API key so we don't have to use an email address
bw login --apikey

echo "Unlock BitWarden Vault:"
SESSION_TXT=$(bw unlock | tee)
SESSION_LINE=$(echo "${SESSION_TXT}" | grep "export BW_SESSION")
SESSION_KEY=${SESSION_LINE:20}
export $SESSION_KEY

# put stuff to get passwords here
ALL_ITEMS=$(bw get items)
FOLDER_ID=$(bw get folder "Homelab/ssh" | jq '.id')
python3 "${FOLDER_ID}" "${ALL_ITEMS}"

bw logout
