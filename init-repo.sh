#!/usr/bin/env bash

source ./common.sh

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
