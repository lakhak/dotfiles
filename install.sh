#!/usr/bin/env zsh

script_dir="${0:A:h}"
ansible_playbook_exec="$script_dir/bin/ansible-playbook"
ansible_inventory="$script_dir/inventory.ini"

function run_playbook() {
    case "$1" in
        all)
            $ansible_playbook_exec -i "$ansible_inventory" "$script_dir/setup.yml" "${@:2}"
            ;;
        *)
            $ansible_playbook_exec -i "$ansible_inventory" "$script_dir/setup.yml" --tags dotfiles "$@"
            ;;
    esac
}

run_playbook "$@"
