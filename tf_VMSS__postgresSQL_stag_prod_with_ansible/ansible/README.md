## You will have 2 files with, one for staging and the second one is for production.

## The master / controller VM will be LoadBalncer in which we will download Ansible with those commands:

- sudo apt update
- sudo apt upgrade -y
- sudo apt install software-properties-common
- sudo add-apt-repository --yes --update ppa:ansible/ansible
- sudo apt install ansible -y
- ansible --version

## After installing , we will add hosts VMs to 
- nano /etc/Ansible/hosts

[stage_frontend_hosts]
- {user}@{ip}
- {user}@{ip}

[prod_frontend_hosts]
- {user}@{ip}
- {user}@{ip}
- {user}@{ip}

## Then you will need to run the command with this command
ansible-playbook frontend_config.yml --ask-pass









