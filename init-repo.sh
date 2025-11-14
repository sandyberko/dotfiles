#!/usr/bin/env bash

set -euo pipefail

print() {
    local BLUE_BOLD="\033[1;34m"
    local RESET="\033[0m"
    echo -e "🔷 ${BLUE_BOLD}$*${RESET}"
}

dotdir="$HOME/.dotfiles"

print "dotfiles git repo..."

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
