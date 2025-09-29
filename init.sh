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
yes | apt upgrade -y || true
yes | apt install -y \
	build-essential \
	git \
	rust \
	nushell \
	helix \
	starship || true

print "git dotfiles..."
dotdir="$HOME/.dotfiles"
if [ -d "$dotdir" ]; then
    echo "⚪ already exists - skipping"
else
    git init --bare $dotdir
    alias cfg='/usr/bin/git --git-dir=$dotdir --work-tree=$HOME'
    cfg switch -c termux
    cfg remote add origin "https://github.com/sandyberko/dotfiles"
    cfg fetch origin main
    cfg reset --hard origin/termux
    cfg branch --set-upstream-to=origin/termux termux
    cfg config --local status.showUntrackedFiles no
fi

print "nushell..."
chsh -s nu

print "jujutsu vcs..."
curl -L https://github.com/jj-vcs/jj/releases/download/v0.33.0/jj-v0.33.0-aarch64-unknown-linux-musl.tar.gz \
    | tar -xzf - -C ~/.cargo/bin/
~/.cargo/bin/jj git init --git-repo $dotdir
~/.cargo/bin/jj config set snapshot.auto-track "none()" --repo

print "🎉 Done!"

