#!/bin/bash
# requires the following variables are exported, in place of using one's email address
# - BW_CLIENTID="user.junk"
# - BW_CLIENTSECRET="alphabet_soup"
# https://bitwarden.com/help/article/personal-api-key/

ANSIBLE_DIR='/home/drake/ansible/depreciated'

# hosts for ansible
HOSTS=( \
    dev_api_LB \
    dev_swarm_manager_01 \
    dev_swarm_manager_02 \
    dev_swarm_manager_03 \
    dev_swarm_worker_01 \
    dev_swarm_worker_02 \
    dev_swarm_worker_03 \
    dev_swarm_worker_04 \
    prd_api_LB \
    prd_swarm_manager_01 \
    prd_swarm_manager_02 \
    prd_swarm_manager_03 \
    prd_swarm_worker_01 \
    prd_swarm_worker_02 \
    prd_swarm_worker_03 \
    prd_swarm_worker_04 \
    gitlab \
    oxygen \
    apt_cache \
    apt_mirror \
)
LXC_HOSTS=( \
    dev_api_LB \
    prd_api_LB \
    apt_cache \
    apt_mirror \
)

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

# echo "Unlock BitWarden Vault:"
SESSION_TXT=$(bw unlock | tee)
SESSION_LINE=$(echo "${SESSION_TXT}" | grep "export BW_SESSION")
SESSION_KEY=${SESSION_LINE:20}
export BW_SESSION=$SESSION_KEY

# # put stuff to get passwords here
# ALL_ITEMS=$(bw list items)
# FOLDER_ID=$(bw get folder "Homelab/ssh" | jq '.id')
# python3 filter.py "${FOLDER_ID}" "${ALL_ITEMS}"

#handle drake users
for (( n=0; n<${#HOSTS[@]}; n++ ))
do
    # PW=$(lpass show -p "${LOGINS[$n]}")
    BW_ITEM=$(bw get item "${HOSTS[$n]}")

    BW_PASS=$(echo "${BW_ITEM}" | jq '.login.password')
    PASSWORD=${BW_PASS:1:-1}

    BW_HOST=$(echo "${BW_ITEM}" | jq '.fields[0].value')
    HOSTNAME=${BW_HOST:1:-1}

    echo "${HOSTS[$n]} info:"
    echo "    hostname:  ${HOSTNAME}"
    echo "    password:  ${PASSWORD}"
    echo ""
    # ansible-playbook -l "${HOSTS[$n]}" "${ANSIBLE_DIR}/setup/initial_setup.yml" \
    #     --extra-vars mypass="${PW}" --extra-vars hn="${HOSTNAMES[$n]}"
done

# #handle root users, LCX containers only
# for (( n=0; n<${#LXC_LOGINS[@]}; n++ ))
# do
#     PW=$(lpass show -p "${LXC_LOGINS[$n]}")
#     ansible-playbook -l "${LXC_HOSTS[$n]}" "${ANSIBLE_DIR}/setup/LXC_root_setup.yml" \
#         --extra-vars mypass="${PW}"
# done

# # setup LXC containers git
# ansible-playbook "${ANSIBLE_DIR}/setup/LXC_git.yml"

bw logout
