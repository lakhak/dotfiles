#!/usr/bin/env zsh

function run_playbook() {
    ansible-playbook -i inventory.ini setup.yml "$@"
}

if [ -z "${VIRTUAL_ENV}" ]; then
    source bin/activate && run_playbook "$@" && deactivate
else
    run_playbook "$@"
fi

