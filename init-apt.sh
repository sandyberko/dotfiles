#!/usr/bin/env bash

. init-common.sh

print "apt..."
sudo apt update
yes | sudo apt upgrade -y || true
yes | sudo apt install -y \
	build-essential \
	git \
	stow \
	curl \
	zoxide \
	hx \
	tmux \
	|| true

print "stow..."
stow */

homebrew_install

print "brew install..."
$BREW install \
	nushell \
	starship \
	jujutsu

# sudo add-shell $HOME/.cargo/bin/nu
# sudo chsh -s $HOME/.cargo/bin/nu $USER 

print "🎉 Done!"

