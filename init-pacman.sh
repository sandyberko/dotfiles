#!/usr/bin/env bash

source ./common.sh

print "pacman..."
pacman -Syu \
  base-devel \
  git \
  jujutsu \
  nushell \
  helix \
  starship \
  zoxide \
  rustup

source ./init-repo.sh
