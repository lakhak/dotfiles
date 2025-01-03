# Dotfiles

Set of ansible playbooks for setting up local machine including:

* Setting up my dotfiles
* Installing homebrew packages
* Installing JDKs via SDKMAN
* Cloning projects with git

## Pre-requisites

The playbooks assume that they will be run on macOS and rely on the following already being installed:

* Python 3
* [Homebrew](https://brew.sh/)
* [SDKMAN!](https://sdkman.io/)

The following one-time commands should be run in the project directory before executing the playbooks:

1. `python3 -m venv .`
2. `source bin/activate`
3. `pip install -r requirements.txt`

## Install

To install dotfiles only: `./install.sh`. 
To install everything: `./install.sh all`.

The `install.sh` script in turn executes `ansible-playbook` - additional arguments to ansible can be provided from `install.sh`. 
For example to provide the password for privilege escalation (see [Privilege escalation](#privilege-escalation)) run `./install.sh -K`.

## Privilege escalation

For the most part the playbooks can be run without requiring any admin privileges. The exceptions to this are documented below.

### Configuring shell environment

If the value for `default_shell` is not present in `/etc/shells` the playbook attempts to add it and execute `chsh`, requiring the script to be called with `-K` flag and BECOME password to be provided. 
Unless this is different from the default (`/bin/zsh` since macOS Catalina [source](https://support.apple.com/en-us/102360)) then this can be ignored as the task should be skipped anyway.
