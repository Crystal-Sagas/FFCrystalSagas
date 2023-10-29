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

# grab required apt packages: git, grep, and 32-bit libssl
if ! ( [ -x "$has_git" ] && [ -x "$has_grep" ] && [ -f "/usr/lib/i386-linux-gnu/libssl.so" ] ); then
	echo "Installing apt dependencies..."
	if ! [ -x "$has_sudo" ]; then
		dpkg --add-architecture i386
		apt-get update
		apt-get install -y git libssl-dev:i386
		rm -rf /var/lib/apt/lists/*
	else
		sudo dpkg --add-architecture i386
		sudo apt-get update
		sudo apt-get install -y git libssl-dev:i386
		sudo rm -rf /var/lib/apt/lists/*
	fi
fi

# load dependencies from game directory
original_dir=$PWD
cd "$1"
. dependencies.sh
cd "$original_dir"

# update rust-g
if [ ! -d "rust-g" ]; then
	echo "Cloning rust-g..."
	git clone https://github.com/Crystal-Sagas/rust-g
	cd rust-g
else
	echo "Fetching rust-g..."
	cd rust-g
	git fetch
fi

# prep for rust-g build
dpkg --add-architecture i386
rustup target add i686-unknown-linux-gnu

echo "Deploying rust-g..."
git checkout "$RUST_G_VERSION"
env PKG_CONFIG_ALLOW_CROSS=1
cargo build --release --target=i686-unknown-linux-gnu --all-features
mv target/i686-unknown-linux-gnu/release/librust_g.so "$1/librust_g.so"
cd ..
