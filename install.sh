#!/usr/bin/env zsh

source bin/activate \
&& ansible-playbook -i inventory.ini setup.yml "$@" \
&& deactivate

