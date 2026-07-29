#!/usr/bin/env bash

. common.sh

clone_dots() {
  print "dotfiles..."
  if [ -d dotfiles ]; then
  	print "already exists. skipping"
  else
  	git clone https://github.com/sandyberko/dotfiles
  fi
  cd dotfiles
}

homebrew_install() {
  print "homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" -y
  echo >> ~/.bashrc
  echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"' >> ~/.bashrc
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"

  export BREW=/home/linuxbrew/.linuxbrew/bin/brew
}

cd $HOME
