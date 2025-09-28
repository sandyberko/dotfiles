#!/usr/bin/env bash

set -euo pipefail

print() {
    local BLUE_BOLD="\033[1;34m"
    local RESET="\033[0m"
    echo -e "🔷 ${BLUE_BOLD}$*${RESET}"
}

alias sudo=''

cd $HOME

print "apt..."
sudo apt update
sudo apt upgrade -y
sudo apt install -y build-essential git

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

print "rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
. "$HOME/.cargo/env"
rustup toolchain install stable
rustup default stable

print "cargo binstall..."
curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash

print "nushell..."
cargo binstall -y nu
command -v nu | sudo tee -a /etc/shells
sudo chsh -s $(which nu) $USER

print "configure vm..."
sudo ~/.cargo/bin/nu ~/.init_assets/cfg_vm.nu

print "jujutsu vcs..."
cargo binstall -y jj-cli

print "vscode server..."
curl -L --proto '=https' --tlsv1.2 -sSf \
	'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-arm64' \
	| sudo tar xvzf - -C /usr/local/bin code

print "vscode server service..."
sudo systemctl daemon-reload
systemctl --user enable code-server
systemctl --user start code-server

print "starship..."
cargo binstall -y starship

print "🎉 Done!"

