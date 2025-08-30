# testing in docker

start ubuntu 24.04 docker container:
```bash
docker run -it ubuntu:24.04 /bin/bash
```

Example of first set of scripts:
```bash
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
ansible-playbook -i hosts2 playbooks/install-python313.yaml --connection=local
ansible-playbook -i hosts2 playbooks/install-python314.yaml --connection=local
ansible-playbook -i hosts2 playbooks/install-golang.yaml --connection=local
ansible-playbook -i hosts2 playbooks/install-vscode.yaml --connection=local

# elapsed time
duration=$SECONDS
elapsed_seconds=$((end_time - start_time))
echo "Script Completed - $((duration / 60)) minutes and $((duration % 60)) seconds elapsed."
```

# testing outside docker(bare metal):

I use this setup on bare metal hardware.  I also try to test this inside proxmox + ubuntu 24.04 virtual machine.  Read more about running docker inside proxmox <a href="https://pve.proxmox.com/wiki/Linux_Container">here.</a>  Proxmox recommends that you run docker inside a Proxmox QEMU VM.

Since this is going to automated I'm going to put this in a `bare_metal.sh` script.  See this script for more details.

# skip installing python3 from source:
copy/paste this block:
```bash
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
ansible-playbook -i hosts2 playbooks/install-docker.yaml --connection=local
ansible-playbook -i hosts2 playbooks/install-kubernetes.yaml --connection=local
ansible-playbook -i hosts2 playbooks/install-golang.yaml --connection=local
ansible-playbook -i hosts2 playbooks/install-vscode.yaml --connection=local

# elapsed time
duration=$SECONDS
elapsed_seconds=$((end_time - start_time))
echo "Script Completed - $((duration / 60)) minutes and $((duration % 60)) seconds elapsed."
```

# will there ever be an offical release or release cycle?

No there will never be a release cycle.  The code on the main branch is the latest and most stable version at any given time.  This code is extremely experimental and I would consider the code always changing as well. Use at  your own risk!

You can create your own versions:

For example set a directory called `version 1_0`
```bash
git clone https://github.com/thesheff17/ansible_examples.git ansible_examples_1_0
```
To upgrade the software you can do 2 things:
  * You can reclone the repo and bump the version number you were using.
  * or you can actually diff the repo between the 2 versions.  This gives you an idea what has changed from version A -> B.

```bash
git clone https://github.com/thesheff17/ansible_examples.git ansible_examples_2.0
diff -bur ansible_examples_1_0 ansible_examples_2.0
```

Upgrade the code when you want to with the changes you want. If you see a problem submit an issues [here.](https://github.com/thesheff17/ansible_examples/issues)


# which operating system does this support?
This assumes you will be running the latest Ubuntu Long Term Support (LTS) Version.  At this time this is called: <br/>`Ubuntu 24.04 code name: noble` 

This is the only os I will be testing on.  I'm sure these scripts could be adobted to another os.  I want to make sure this is as stable as possible and testing time is limited.

# AI stuff
I'm starting to work on a bunch of random AI stuff.  This will be self contained in the `playbooks/ai` directory.  This is all experimental stuff. Make PR if you see issues.
```bash
ansible-playbook -i hosts2 playbooks/ai/install-ollama.yaml --connection=local
ansible-playbook -i hosts2 playbooks/ai/install-openwebui.yaml --connection=local
```

There are some helper playbooks to manage the models for ollama. I have found `rsync` to be very fast. I setup ssh keys between these 2 machines.
```bash
# backup
time rsync -avz --delete -e ssh /usr/share/ollama/.ollama/models/ root@xxx.xxx.xx.x:/root/models/

# restore
time rsync -avz --delete -e ssh root@xxx.xxx.xx.x:/root/models/ /usr/share/ollama/.ollama/models/
```