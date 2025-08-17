#!/bin/bash

SECONDS=0
cd /root/
export DEBIAN_FRONTEND=noninteractive
apt-get update 
apt-get upgrade -y
apt-get install -y git software-properties-common
add-apt-repository --yes --update ppa:ansible/ansible
apt-get update
apt-get install -y ansible
ansible --version
git clone https://github.com/thesheff17/ansible_examples.git
cd ansible_examples
ansible-playbook -i hosts2 playbooks/update-apt-packages.yaml --connection=local
ansible-playbook -i hosts2 playbooks/base-packages.yaml --connection=local
ansible-playbook -i hosts2 playbooks/install-python311.yaml --connection=local
ansible-playbook -i hosts2 playbooks/install-python312.yaml --connection=local
ansible-playbook -i hosts2 playbooks/install-python313.yaml --connection=local
ansible-playbook -i hosts2 playbooks/install-python314.yaml --connection=local
ansible-playbook -i hosts2 playbooks/install-docker.yaml --connection=local
ansible-playbook -i hosts2 playbooks/install-kubernetes.yaml --connection=local
ansible-playbook -i hosts2 playbooks/install-pip312-localstack.yaml --connection=local
ansible-playbook -i hosts2 playbooks/install-samba.yaml --connection=local
ansible-playbook -i hosts2 playbooks/install-apache2.yaml --connection=local
ansible-playbook -i hosts2 playbooks/install-golang.yaml --connection=local
ansible-playbook -i hosts2 playbooks/install-vscode.yaml --connection=local

# elapsed time
duration=$SECONDS
elapsed_seconds=$((end_time - start_time))
echo "Script Completed - $((duration / 60)) minutes and $((duration % 60)) seconds elapsed."