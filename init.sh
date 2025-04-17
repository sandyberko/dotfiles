#!/usr/bin/env bash

set -euox pipefail

echo apt...
sudo apt update
sudo apt upgrade -y
sudo apt install -y build-essential git

echo rust...
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
. "$HOME/.cargo/env"
rustup toolchain install stable
rustup default stable

echo cargo binstall...
curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash

echo jujutstu vcs...
cargo binstall -y jj-cli

echo vscode server...
curl -L --proto '=https' --tlsv1.2 -sSf \
	'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-arm64' \
	| sudo tar xvzf - -C /usr/local/bin code

echo vscode service...

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
sudo systemctl --user enable code-server
sudo systemctl --user start code-server

echo nushell...
cargo binstall -y nu
command -v nu | sudo tee -a /etc/shells
sudo chsh -s $(which nu) $USER

echo Done!
