#!/usr/bin/env bash

source ./common.sh

cd $HOME

print "apt..."
sudo apt update
yes | sudo apt upgrade -y || true
yes | sudo apt install -y \
	build-essential \
	git \
	stow \
	curl \
	|| true

print "rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env

print "cargo binstall..."
curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash

print "nushell..."
cargo binstall nu
sudo add-shell $HOME/.cargo/bin/nu
sudo chsh -s $HOME/.cargo/bin/nu $(whoami) 

print "starship..."
cargo binstall starship

print "helix..."
cargo binstall helix

print "stow..."
cd $HOME/dotfiles
stow */

print "🎉 Done!"

