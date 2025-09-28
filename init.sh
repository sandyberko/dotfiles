#!/usr/bin/env bash

set -euo pipefail

print() {
    local BLUE_BOLD="\033[1;34m"
    local RESET="\033[0m"
    echo -e "🔷 ${BLUE_BOLD}$*${RESET}"
}

cd $HOME

print "apt..."
apt update
apt upgrade -y
apt install -y \
	build-essential \
	git \
	rust \
	nushell \
	helix \
	starship

print "git dotfiles..."
if [ -d ".git" ]; then
    echo "⚪ already exists - skipping"
else
    git init
    git switch -c main
	git remote add origin "https://github.com/sandyberko/dotfiles"
    git fetch origin main
    git reset --hard origin/main
	git branch --set-upstream-to=origin/main main
fi

print "nushell..."
command -v nu | sudo tee -a /etc/shells
chsh -s $(which nu) $USER

print "jujutsu vcs..."
curl -L https://github.com/jj-vcs/jj/releases/download/v0.33.0/jj-v0.33.0-aarch64-unknown-linux-musl.tar.gz \
    | tar -xzf - -C ~/.cargo/bin/

print "🎉 Done!"

