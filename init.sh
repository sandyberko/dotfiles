#!/usr/bin/env bash

source ./common.sh

cd $HOME

print "apt..."
apt update
yes | apt upgrade -y || true
yes | apt install -y \
	build-essential \
	git \
	rust \
	rust-analyzer \
	nushell \
	helix \
	starship || true

source ./init-repo.sh

print "nushell..."
chsh -s nu

print "jujutsu vcs..."
curl -L https://github.com/jj-vcs/jj/releases/download/v0.33.0/jj-v0.33.0-aarch64-unknown-linux-musl.tar.gz \
    | tar -xzf - -C ~/.cargo/bin/
~/.cargo/bin/jj git init --git-repo $dotdir
~/.cargo/bin/jj config set snapshot.auto-track "none()" --repo

print "🎉 Done!"

