#!/bin/bash

# Ensure all required dependencies exist.
# Right now, this is just rust-g.

# strict mode
set -euo pipefail

# +e: don't fail the whole script if it's not there
set +e
has_git="$(command -v git)"
has_cargo="$(command -v ~/.cargo/bin/cargo)"
has_sudo="$(command -v sudo)"
has_grep="$(command -v grep)"
set -e

# if cargo is not there, install rust
if ! [ -x "$has_cargo" ]; then
	echo "Installing Rust..."
	curl https://sh.rustup.rs -sSf | sh -s -- -y
	. ~/.profile
fi

# grab required apt packages from what we used in PreCompile
if ! ( [ -x "$has_git" ] && [ -x "$has_grep" ] && [ -f "/usr/lib/i386-linux-gnu/libssl.so" ] ); then
	echo "Installing apt dependencies..."
	if ! [ -x "$has_sudo" ]; then
		dpkg --add-architecture i386
		apt-get update
		apt-get install -y lib32z1 git pkg-config libssl-dev:i386 libssl-dev libssl1.1:i386
		rm -rf /var/lib/apt/lists/*
	else
		sudo dpkg --add-architecture i386
		sudo apt-get update
		sudo apt-get install -y lib32z1 git pkg-config libssl-dev:i386 libssl-dev libssl1.1:i386
		sudo rm -rf /var/lib/apt/lists/*
	fi
fi
