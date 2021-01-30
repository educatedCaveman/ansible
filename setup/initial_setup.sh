#!/bin/bash
ANSIBLE_DIR='/home/drake/ansible'

HOSTS=(dev_swarm_manager_01)
# HOSTS=( \
#     dev_api_LB \
#     dev_swarm_manager_01 \
#     dev_swarm_manager_01 \
#     dev_swarm_manager_01 \
#     dev_swarm_worker_01 \
#     dev_swarm_worker_01 \
#     dev_swarm_worker_01 \
#     dev_swarm_worker_01 \
#     prd_api_LB \
#     prd_swarm_manager_01 \
#     prd_swarm_manager_01 \
#     prd_swarm_manager_01 \
#     prd_swarm_worker_01 \
#     prd_swarm_worker_01 \
#     prd_swarm_worker_01 \
#     prd_swarm_worker_01 \
# )

LOGINS=("Homelab\ssh/swarm-api-lb.lab")
# LOGINS=( \
#     "Homelab\ssh/swarm-api-lb.lab" \
#     "Homelab\ssh/lv426-manager-01.lab" \
#     "Homelab\ssh/lv426-manager-02.lab" \
#     "Homelab\ssh/lv426-manager-03.lab" \
#     "Homelab\ssh/lv426-worker-01.lab" \
#     "Homelab\ssh/lv426-worker-02.lab" \
#     "Homelab\ssh/lv426-worker-03.lab" \
#     "Homelab\ssh/lv426-worker-04.lab" \
#     "Homelab\ssh/swarm-api-lb.vm" \
#     "Homelab\ssh/sevastopol-manager-01.vm" \
#     "Homelab\ssh/sevastopol-manager-02.vm" \
#     "Homelab\ssh/sevastopol-manager-03.vm" \
#     "Homelab\ssh/sevastopol-worker-01.vm" \
#     "Homelab\ssh/sevastopol-worker-02.vm" \
#     "Homelab\ssh/sevastopol-worker-03.vm" \
#     "Homelab\ssh/sevastopol-worker-04.vm" \
# )

for (( n=0; n<${#LOGINS[@]}; n++ ))
do
    PW=$(lpass show -p "${LOGINS[$n]}")
    ansible-playbook -l "${HOSTS[$n]}" "${ANSIBLE_DIR}/setup/LXC_setup.yml"
done