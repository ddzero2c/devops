# Logging service for Everest

### Installation

1. ./bootstrape.sh
2. deploy
  * production: ansible-playbook playbooks/deploy.yml -i inventory.py -e @production.yml
  * development: ansible-playbook playbooks/deploy.yml -i inventory.py -e @dev.yml
