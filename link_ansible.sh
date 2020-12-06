#!/bin/bash

#TODO: make this not static:

ln -s /var/lib/jenkins/workspace/Ansible_pipeline_master/ansible.cfg /etc/ansible/ansible.cfg
ln -s /var/lib/jenkins/workspace/Ansible_pipeline_master/hosts /etc/ansible/hosts



# #relink ansiblei

# #core variables
# ANS_DIR=/etc/ansible
# SRC_DIR=$HOME/ansible
# BACKUP=$HOME/backup_ansible
# FILES=(ansible.cfg hosts)

# #create backup directory if it doesn't exist
# if [ -e "${BACKUP}" ]
# then
#     echo backup dir already exists.  emptying...
#     rm "${BACKUP}"/*
# else
#     echo backup dir doesn\'t exist.  creating...
#     mkdir -p "${BACKUP}"
# fi

# #backup files, and link
# for file in "${FILES[@]}"
# do
#     if [ -e "${ANS_DIR}"/"${file}" ];
#     then
#         echo "${file}" exists.  we need to back it up.
#         cp "${ANS_DIR}"/"${file}" "${BACKUP}"
#         sudo rm "${ANS_DIR}"/"${file}"
#     fi

#     #link the file
#     echo linking "${SRC_DIR}"/"${file}" to "${ANS_DIR}"/"${file}"...
#     sudo ln -s "${SRC_DIR}"/"${file}" "${ANS_DIR}"/"${file}" 
# done

