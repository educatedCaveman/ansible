#!/bin/bash
set -e

HOSTNAME="carbon"
GIT_DIR="${HOME}/github"
KEYFILE="${HOME}/.ssh/${HOSTNAME}_id_ed25519"
KEYFILE_GIT="${HOME}/.ssh/github_id_ed25519"
SSH_CONFIG="${HOME}/.ssh/config"

# create git directory if it doesn't already exist
if [ ! -f "${GIT_DIR}" ]; then
    mkdir -p "$GIT_DIR"
fi

# updates
sudo pamac update --no-confirm

# installs not possible via ansible
sudo pamac install konsave ansible google-chrome vscodium ultra-flat-icons-blue brother-hll2395dw --no-confirm
flatpak install flathub tv.plex.PlexDesktop
flatpak install flathub com.plexamp.Plexamp

# SSH Key setup
# create ssh keys if they don't already exist
if [ ! -f "${KEYFILE}" ]; then
    ssh-keygen -t ed25519 -N "" -C "drake_${HOSTNAME}" -f "${KEYFILE}"
fi
if [ ! -f "${KEYFILE_GIT}" ]; then
    ssh-keygen -t ed25519 -N "" -C "github_${HOSTNAME}" -f "${KEYFILE}"
fi
eval "$(ssh-agent -s)"
sudo tee -a /root/.ssh/authorized_keys < "${KEYFILE}"
echo "# ssh config" > "${SSH_CONFIG}"
echo "IdentityFile ${KEYFILE}" > "${SSH_CONFIG}"
echo "IdentityFile ${KEYFILE_GIT}" > "${SSH_CONFIG}"

sudo systemctl enable --now sshd

# pause to add public key to github account
echo "ssh public key for GitHub: ${KEYFILE_GIT}"
read -rp "Press enter after adding the above private key to github account, and\ntesting it with this command: ssh -T git@github.com"

# clone ansible repo
cd "${GIT_DIR}" || exit
git clone git@github.com:educatedCaveman/ansible.git

# run the main ansible playbook?
cd "${GIT_DIR}/ansible/" || exit
ansible-playbook hosts/carbon.yml -i hosts.ini --key-file "${HOME}/.ssh/carbon_id_ed25519"

# post-ansible commands?
# restore KDE settings
if [ -f "${GIT_DIR}/drake.knsv" ]; then
    konsave -i "${HOME}/github/drake.knsv"
fi


echo "give me a courtesy reboot"