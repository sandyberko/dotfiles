#!/usr/bin/env bash

. init-common.sh

print "zypper..."
sudo zypper install -y \
	git \
	stow \
	curl \
	zoxide \
	fzf \
	helix \
	tmux \
	nushell \
	starship \
	jujutsu \
	|| true

print "stow..."
(cd ~/Projects/dotfiles/packages/ && stow -t ~ * --adopt)

sudo usermod -s /usr/bin/nu $USER 

print "🎉 Done!"

