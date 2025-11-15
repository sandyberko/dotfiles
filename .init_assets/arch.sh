#!/usr/bin/env bash

source ~/init-repo.sh

print "pacman..."
sudo pacman -Syu \
  base-devel \
  git \
  jujutsu \
  nushell \
  helix \
  starship \
  rustup

command -v nu | sudo tee -a /etc/shells
sudo chsh -s $(command -v nu) $USER

print "arch setup done!"
