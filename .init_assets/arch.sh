#!/usr/bin/env bash

source ~/init-repo.sh

print "pacman..."
pacman -Syu \
  base-devel \
  git \
  jujutsu \
  nushell \
  helix \
  starship \
  rustup

command -v nu | tee -a /etc/shells
chsh -s $(command -v nu)

print "arch setup done!"
