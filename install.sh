#!/usr/bin/env zsh

script_dir="${0:A:h}"
ansible_playbook_exec="$script_dir/bin/ansible-playbook"
ansible_inventory_exec="$script_dir/bin/ansible-inventory"
ansible_inventory="$script_dir/inventory.ini"
dotfile_host="$script_dir/.dotfile_host"

function validate_inventory_host() {
    $ansible_inventory_exec --host "$1" -i $ansible_inventory > /dev/null 2>&1
}

function run_playbook() {
    local host
    if [[ "$#" -gt 0 && -n "$1" ]]; then
        validate_inventory_host "$1"
        if [[ "$?" -eq 0 ]]; then
            host="$1"; shift
            echo "Saving '$host' to $dotfile_host for future installs"
            echo "$host" > $dotfile_host
        fi
    fi

    if [[ -f $dotfile_host ]]; then
        host="$(head -1 $dotfile_host)"
        validate_inventory_host "$host"
        if [[ "$?" -ne 0 ]]; then
            printf "\033[1;31mERROR\033[0m: $dotfile_host contains invalid host: '$host'\n"
            exit 2
        fi

    else
        printf "\033[1;31mERROR\033[0m: Requires specifying a valid host\n"
        exit 1
    fi

    printf "Executing playbook against \033[1;94m$host\033[0m\n"
    case "$1" in
        all)
            $ansible_playbook_exec --limit "$host" -i "$ansible_inventory" "$script_dir/setup.yml" "${@:2}"
            ;;
        *)
            $ansible_playbook_exec --limit "$host" -i "$ansible_inventory" "$script_dir/setup.yml" --tags dotfiles "$@"
            ;;
    esac
}

run_playbook "$@"
