#!/bin/bash
ANSIBLE_DIR='/home/drake/ansible'

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
    dev_LB \
    dev_db_01 \
    dev_db_02 \
    dev_k3s_server_01 \
    dev_k3s_server_02 \
    dev_k3s_worker_01 \
    dev_k3s_worker_02 \
    dev_k3s_data_01 \
    dev_k3s_data_02 \
)
LXC_HOSTS=( \
    dev_api_LB \
    prd_api_LB \
    apt_cache \
    apt_mirror \
    dev_LB \
    dev_db_01 \
    dev_db_02 \
)

# lastpass login paths
LOGINS=( \
    "Homelab\ssh/swarm-api-lb.lab" \
    "Homelab\ssh/lv426-manager-01.lab" \
    "Homelab\ssh/lv426-manager-02.lab" \
    "Homelab\ssh/lv426-manager-03.lab" \
    "Homelab\ssh/lv426-worker-01.lab" \
    "Homelab\ssh/lv426-worker-02.lab" \
    "Homelab\ssh/lv426-worker-03.lab" \
    "Homelab\ssh/lv426-worker-04.lab" \
    "Homelab\ssh/swarm-api-lb.vm" \
    "Homelab\ssh/sevastopol-manager-01.vm" \
    "Homelab\ssh/sevastopol-manager-02.vm" \
    "Homelab\ssh/sevastopol-manager-03.vm" \
    "Homelab\ssh/sevastopol-worker-01.vm" \
    "Homelab\ssh/sevastopol-worker-02.vm" \
    "Homelab\ssh/sevastopol-worker-03.vm" \
    "Homelab\ssh/sevastopol-worker-04.vm" \
    "Homelab\ssh/gitlab.vm" \
    "Homelab\ssh/oxygen.vm" \
    "Homelab\ssh/apt-cache.vm" \
    "Homelab\ssh/apt-mirror.vm" \
    "Homelab\ssh/dev-load-balancer.lab" \
    "Homelab\ssh/dev-db-01.lab" \
    "Homelab\ssh/dev-db-02.lab" \
    "Homelab\ssh/k3s-server-01.lab" \
    "Homelab\ssh/k3s-server-02.lab" \
    "Homelab\ssh/k3s-worker-01.lab" \
    "Homelab\ssh/k3s-worker-02.lab" \
    "Homelab\ssh/k3s-data-01.lab" \
    "Homelab\ssh/k3s-data-02.lab" \
)
LXC_LOGINS=( \
    "Homelab\ssh/swarm-api-lb.lab" \
    "Homelab\ssh/swarm-api-lb.vm" \
    "Homelab\ssh/apt-cache.vm" \
    "Homelab\ssh/apt-mirror.vm" \
    "Homelab\ssh/dev-load-balancer.lab" \
    "Homelab\ssh/dev-db-01.lab" \
    "Homelab\ssh/dev-db-02.lab" \
)

HOSTNAMES=( \
    "swarm-api-lb" \
    "lv426-manager-01" \
    "lv426-manager-02" \
    "lv426-manager-03" \
    "lv426-worker-01" \
    "lv426-worker-02" \
    "lv426-worker-03" \
    "lv426-worker-04" \
    "swarm-api-lb" \
    "sevastopol-manager-01" \
    "sevastopol-manager-02" \
    "sevastopol-manager-03" \
    "sevastopol-worker-01" \
    "sevastopol-worker-02" \
    "sevastopol-worker-03" \
    "sevastopol-worker-04" \
    "gitlab" \
    "oxygen" \
    "apt-cache" \
    "apt-mirror" \
    "dev-load-balancer" \
    "dev-mariadb-01" \
    "dev-mariadb-02" \
    "k3s-server-01" \
    "k3s-server-02" \
    "k3s-worker-01" \
    "k3s-worker-02" \
    "k3s-storage-01" \
    "k3s-storage-02" \
)

#handle drake users
for (( n=0; n<${#LOGINS[@]}; n++ ))
do
    PW=$(lpass show -p "${LOGINS[$n]}")
    ansible-playbook -l "${HOSTS[$n]}" "${ANSIBLE_DIR}/setup/initial_setup.yml" \
        --extra-vars mypass="${PW}" --extra-vars hn="${HOSTNAMES[$n]}"
done

#handle root users, LCX containers only
for (( n=0; n<${#LXC_LOGINS[@]}; n++ ))
do
    PW=$(lpass show -p "${LXC_LOGINS[$n]}")
    ansible-playbook -l "${LXC_HOSTS[$n]}" "${ANSIBLE_DIR}/setup/LXC_root_setup.yml" \
        --extra-vars mypass="${PW}"
done
