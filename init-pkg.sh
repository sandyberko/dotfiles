#!/usr/bin/env bash

set -euo pipefail

print() {
    local BLUE_BOLD="\033[1;34m"
    local RESET="\033[0m"
    echo -e "🔷 ${BLUE_BOLD}$*${RESET}"
}

cd $HOME

print "pkg..."
pkg update
yes | pkg upgrade -y || true
yes | pkg install -y \
	tur-repo \
	build-essential \
	git \
	stow \
	curl \
	rust \
	rust-std-aarch64-linux-android \
	zoxide \
	nushell \
	helix \
	jujutsu \
	starship \
	tmux \
	|| true

source $HOME/.cargo/env

print "dotfiles..."
if [ -d dotfiles ]
then
	print "already exists. skipping"
else
	git clone https://github.com/sandyberko/dotfiles
fi
cd dotfiles
stow */

print "🎉 Done!"

