# Ansible

test


bootstrap commmand:
```shell
export ANSIBLE_CONFIG=$HOME/github/ansible/bootstrap_config.cfg; ansible-playbook hosts/carbon.yml -i hosts.ini --key-file /home/drake/.ssh/theseus2_id_ed25519.pub 
```