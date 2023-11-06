#!/usr/bin/env zsh

function dotf() {
	local dotfiles_dir="${HOME}/Projects/dotfiles"

	if [ -z "$1" ]; then
		git --git-dir="${dotfiles_dir}/.git" --work-tree="${dotfiles_dir}" checkout main 1> /dev/null
	fi

	git --git-dir="${dotfiles_dir}/.git" --work-tree="${dotfiles_dir}" checkout $1 1> /dev/null
}
