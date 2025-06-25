#!/bin/bash

# Fancy blinking banner
echo -e "\033[5;35;43m 🔥 NEXUS BY PRODIP 🔥 \033[0m"
sleep 2

echo "🚀 Starting Full Nexus Node Auto-Setup..."

# Update and install essentials
sudo apt update && sudo apt upgrade -y
sudo apt install screen curl build-essential pkg-config libssl-dev git-all -y
sudo apt install protobuf-compiler -y
sudo apt install tmux -y

# Install Rust silently
echo "🦀 Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Load Rust env for current shell
source $HOME/.cargo/env

# Add riscv32 target
rustup target add riscv32i-unknown-none-elf

# Install Nexus CLI
echo "📦 Installing Nexus CLI..."
curl https://cli.nexus.xyz/ | sh

# Source bashrc for Nexus CLI
source ~/.bashrc

# Ask for Node ID
read -p "🔑 Enter your Node ID: " NODE_ID

# Kill old tmux session if any
tmux kill-session -t NEX 2>/dev/null

# Start new tmux session with full env and keep session open with 'read'
tmux new-session -d -s NEX "bash -c 'source ~/.bashrc && source \$HOME/.cargo/env && nexus-network start --node-id $NODE_ID; echo \"\\n⚠️ Press Ctrl+b then d to detach from tmux session.\"; read'"

echo "✅ Nexus node started inside tmux session 'NEX'"
echo "🔍 To view logs: tmux attach-session -t NEX"
echo "❌ To stop node: tmux kill-session -t NEX"
