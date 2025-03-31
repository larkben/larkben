#!/bin/bash

# This file is Benjamin's personal setup scripts for any workstation.

# 1. Zig

# Fetch the latest stable Zig version from GitHub API
ZIG_VERSION=$(curl -s https://api.github.com/repos/ziglang/zig/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

# Define the download URL
ZIG_DOWNLOAD_URL="https://ziglang.org/download/${ZIG_VERSION}/zig-linux-x86_64-${ZIG_VERSION}.tar.xz"

# Create a temporary directory for the download
TEMP_DIR=$(mktemp -d)

# Download and extract Zig
curl -L $ZIG_DOWNLOAD_URL | tar -xJ -C $TEMP_DIR --strip-components=1

# Move the Zig binary to /usr/local/bin
sudo ln -s $TEMP_DIR/zig /usr/local/bin/zig

# Verify installation
zig version

# 2. Zig Zls ~ language server protocol

# Fetch the latest stable Zls version from GitHub API
ZLS_VERSION=$(curl -s https://api.github.com/repos/zigtools/zls/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

# Define the download URL
ZLS_DOWNLOAD_URL="https://github.com/zigtools/zls/releases/download/${ZLS_VERSION}/zls-x86_64-linux.tar.xz"

# Create a temporary directory for the download
TEMP_DIR=$(mktemp -d)

# Download and extract Zls
curl -L $ZLS_DOWNLOAD_URL | tar -xJ -C $TEMP_DIR

# Move the Zls binary to /usr/local/bin
sudo ln -s $TEMP_DIR/zls /usr/local/bin/zls

# Verify installation
zls --version

# 3. Deno

# Install Deno script
curl -fsSL https://deno.land/install.sh | sh

# Verify Deno Version
deno --version

# 4. Rust ~ "john would be proud"

# Rust Install Script
curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh

# Possible Additions

# docker install script
# node / npm <> deno
# alephium devnet
# tmux
# neovim
# etc ... <nerdFont>
# 5GseA8jbzKgisGzXoGwr5TeUp8bFbYFcy7aZWceHfLwDKw8T (tao)
