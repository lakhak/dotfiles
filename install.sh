#!/usr/bin/env zsh

source bin/activate \
&& ansible-playbook -i inventory setup.yml "$@" \
&& deactivate

