#!/usr/bin/env bash

set -euo pipefail

print() {
    local BLUE="\033[34m"
    local RESET="\033[0m"
    echo -e "🔵 ${BLUE}$1${RESET}"
}

print "apt..."
sudo apt update
sudo apt upgrade -y
sudo apt install -y build-essential git

print "rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
. "$HOME/.cargo/env"
rustup toolchain install stable
rustup default stable

print "cargo binstall..."
curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash

print "jujutsu vcs..."
cargo binstall -y jj-cli

print "vscode server..."
curl -L --proto '=https' --tlsv1.2 -sSf \
	'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-arm64' \
	| sudo tar xvzf - -C /usr/local/bin code

print "vscode server service..."

# Create systemd service
mkdir -p $HOME/.local/share/systemd/user
sudo tee $HOME/.local/share/systemd/user/code-server.service <<EOF
[Unit]
Description=code-server

[Service]
Type=simple
TimeoutStartSec=0
ExecStart=/usr/local/bin/code serve-web --without-connection-token

[Install]
WantedBy=default.target
EOF

# Enable and start service
sudo systemctl daemon-reload
systemctl --user enable code-server
systemctl --user start code-server

print "nushell..."
cargo binstall -y nu
command -v nu | sudo tee -a /etc/shells
sudo chsh -s $(which nu) $USER

print "git dotfiles..."
cd $HOME
git init
git switch -c main
git remote add origin "https://github.com/sandyberko/dotfiles"
git reses --hard HEAD
git pull origin main --set-upstream

print "🎉 Done!"
