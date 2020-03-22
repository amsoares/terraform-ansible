#!/bin/bash
yum install git -y;
pip install ansible;
git clone https://github.com/amsoares/terraform-ansible.git /tmp/terraform-ansible;
/usr/local/bin/ansible-playbook -i /tmp/terraform-ansible/infrastructure/ansible/hosts /tmp/terraform-ansible/infrastructure/ansible/web.yml &> /tmp/ansible.log;