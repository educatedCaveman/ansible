#!/bin/bash
# requires the following variables are exported, in place of using one's email address
# - BW_CLIENTID="user.junk"
# - BW_CLIENTSECRET="alphabet_soup"
# https://bitwarden.com/help/article/personal-api-key/

ANSIBLE_DIR='/home/drake/ansible/maintenance'

# hosts for ansible
HOSTS=( \
    nextcloud_vm \
    jenkins_vm \
    lv_426 \
    sevastopol \
    singularity \
    plex_vm \
    swarm_portainer \
    swarm_data \
    apis_LB \
    vespae_LB \
    apis_1 \
    apis_2 \
    apis_3 \
    apis_4 \
    apis_5 \
    vespae_1 \
    vespae_2 \
    vespae_3 \
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

#handle drake users
for host in "${HOSTS[@]}"
do
    echo "starting configuration of $host"

    # get the full BitWarden item
    BW_ITEM=$(bw get item "$host")

    # filter out the password
    BW_PASS=$(echo "${BW_ITEM}" | jq '.login.password')
    PASSWORD=${BW_PASS:1:-1}

    # filter out the hostname
    BW_HOST=$(echo "${BW_ITEM}" | jq '.fields[0].value')
    HOSTNAME=${BW_HOST:1:-1}

    # filter out the LXC switch
    BW_LXC=$(echo "${BW_ITEM}" | jq '.fields[1].value')
    LXC=${BW_LXC:1:-1}

    # run the playbook, passing in the secrets
    ansible-playbook -l "$host" "${ANSIBLE_DIR}/PW_hostname.yml" \
        --extra-vars mypass="${PASSWORD}" --extra-vars hn="${HOSTNAME}"

    # handle the root user for LXC containers
    if [ "${LXC}" == "true" ]
    then
        ansible-playbook -l "$host" "${ANSIBLE_DIR}/LXC_root_setup.yml" \
            --extra-vars mypass="${PASSWORD}"
    fi

done

# setup LXC containers git
ansible-playbook "${ANSIBLE_DIR}/LXC_git.yml"

bw logout
