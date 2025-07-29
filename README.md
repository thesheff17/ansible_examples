# testing in docker

start ubuntu 24.04 docker container:
```bash
docker run -it ubuntu:24.04 /bin/bash
```

Now copy/paste this block:
```bash
SECONDS=0
cd /root/
export DEBIAN_FRONTEND=noninteractive
apt-get update 
apt-get upgrade -y
apt-get install -y git software-properties-common ansible
add-apt-repository --yes --update ppa:ansible/ansible
git clone https://github.com/thesheff17/ansible_examples.git
cd ansible_examples
ansible-playbook -i hosts2 playbooks/update-apt-packages.yaml --connection=local
ansible-playbook -i hosts2 playbooks/base-packages.yaml --connection=local
ansible-playbook -i hosts2 playbooks/install-python313.yaml --connection=local
ansible-playbook -i hosts2 playbooks/install-python314.yaml --connection=local

# elapsed time
duration=$SECONDS
elapsed_seconds=$((end_time - start_time))
echo "Script Completed - $((duration / 60)) minutes and $((duration % 60)) seconds elapsed."
```