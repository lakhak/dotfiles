#!/usr/bin/env zsh

function run_playbook() {
    case "$1" in
        all)
            ansible-playbook -i inventory.ini setup.yml "${@:2}"
            ;;
        *)
            ansible-playbook -i inventory.ini dotfiles.yml "$@"
            ;;
    esac
}

if [ -z "${VIRTUAL_ENV}" ]; then
    source bin/activate && run_playbook "$@" && deactivate
else
    run_playbook "$@"
fi

