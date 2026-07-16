#!/usr/bin/env bash

set -euo pipefail

print() {
    local BLUE_BOLD="\033[1;34m"
    local RESET="\033[0m"
    echo -e "🔷 ${BLUE_BOLD}$*${RESET}"
}

cd $HOME

print "dnf..."
sudo dnf update
sudo dnf install -y \
	git \
	stow \
	curl \
	bubblewrap \
	|| true

print "dotfiles..."
if [ -d dotfiles ]; then
	print "already exists. skipping"
else
	git clone https://github.com/sandyberko/dotfiles
fi
cd dotfiles
stow */

print "homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" -y
echo >> /home/opc/.bashrc
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"' >> /home/opc/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"
BREW=/home/linuxbrew/.linuxbrew/bin/brew

# print "rust..."
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# source $HOME/.cargo/env

# print "cargo binstall..."
# curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash

print "homebrew install..."
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

