#!/usr/bin/env bash

. init-common.sh

print "dnf..."
sudo dnf update
sudo dnf install -y \
	git \
	stow \
	curl \
	bubblewrap \
	|| true

clone_dots

# print "rust..."
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# source $HOME/.cargo/env

# print "cargo binstall..."
# curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash

homebrew_install

# cargo binstall nu
$BREW install \
	nushell \
	starship \
	helix \
	zoxide \
	jj

print "nu as default..."
NUSHELL=$(brew --prefix)/bin/nu
echo $NUSHELL | sudo tee -a /etc/shells
sudo chsh -s $NUSHELL $USER 

print "🎉 Done!"

