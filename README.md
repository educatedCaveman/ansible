# Ansible

test


bootstrap commmand:
```shell
export ANSIBLE_CONFIG=$HOME/github/ansible/bootstrap_config.cfg; ansible-playbook hosts/carbon.yml -i hosts.ini --key-file /home/drake/.ssh/theseus2_id_ed25519.pub 
```

## TODOs

- combine the foloowing roles. Basically, these all go together:
    - `VM`
    - `LXC`
    - `git_config`
    - `git_dotfiles`
    - `client_ssh_keys`
    - `linux`
    - `drake`
- simplify or consolidate the NFS roles

## Useful facts:

there are MANY others

From an LXC host:
```json
{
    "ansible_facts": {
        "ansible_distribution": "Ubuntu",
        "ansible_distribution_file_variety": "Debian",
        "ansible_distribution_release": "resolute",
        "ansible_lsb": {
            "codename": "resolute",
            "description": "Ubuntu 26.04.1 LTS",
            "id": "Ubuntu",
            "major_release": "26",
            "release": "26.04"
        },
        "ansible_os_family": "Debian",
        "ansible_pkg_mgr": "apt",
        "ansible_virtualization_role": "guest",
        "ansible_virtualization_tech_guest": [
            "lxc",
            "container"
        ],
        "ansible_virtualization_tech_host": [
            "kvm"
        ],
        "ansible_virtualization_type": "lxc",
    }
}
```

Or, for a VM:
```json
{
    "ansible_facts": {
        "ansible_virtualization_role": "guest",
        "ansible_virtualization_tech_guest": [
            "kvm"
        ],
        "ansible_virtualization_tech_host": [],
        "ansible_virtualization_type": "kvm",
    }
}
```