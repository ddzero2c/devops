#!/bin/bash

set -e -x

install_ansible() {
    dpkg -l | grep ansible 2>&1 > /dev/null && return 0
    apt-get update
    apt-get install software-properties-common -y
    apt-add-repository ppa:ansible/ansible -y
    apt-get update
    apt-get install ansible -y
    cp -af ansible.cfg /etc/ansible/ansible.cfg
}

setup_ssh_keys() {
    local pubkey="`cat ~/.ssh/id_rsa.pub`"
    ansible all_nodes -m shell -k -i inventory.py -a "mkdir -p ~/.ssh; cat ~/.ssh/authorized_keys | grep \"$pubkey\" 2>&1 > /dev/null || echo $pubkey >> ~/.ssh/authorized_keys"
    ansible all_nodes -m shell -K -i inventory.py -b -a 'echo "{{ ansible_user }} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/{{ ansible_user }}'
}

install_ansible
setup_ssh_keys

