#!/bin/bash
yum install git -y;
pip install ansible;
git clone https://github.nike.com/amo145/waf-terraform-pricus.git /tmp/terraform-ansible;
/usr/local/bin/ansible-playbook -i /tmp/terraform-ansible/ansible/hosts /tmp/terraform-ansible/ansible/web.yml &> /tmp/ansible.log;