#!/bin/bash

# 🔔 Fancy Welcome Blink Text
echo -e "\033[5;35;43m 🔥 NEXUS BY PRODIP 🔥 \033[0m"
sleep 2

echo "🚀 Starting Full Nexus Node Auto-Setup..."

# Step 1: Update and install packages
sudo apt update && sudo apt upgrade -y
sudo apt install screen curl build-essential pkg-config libssl-dev git-all -y
sudo apt install protobuf-compiler -y
sudo apt install tmux -y

# Step 2: Install Rust
echo "🦀 Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Step 3: Load Rust environment
source $HOME/.cargo/env

# Step 4: Add RISC-V target
rustup target add riscv32i-unknown-none-elf

# Step 5: Install Nexus CLI
echo "📦 Installing Nexus CLI..."
curl https://cli.nexus.xyz/ | sh

# Step 6: Source .bashrc for Nexus CLI
source ~/.bashrc

# Step 7: Ask for Node ID
read -p "🔑 Enter your Node ID: " NODE_ID

# Step 8: Kill old tmux if exists
tmux kill-session -t NEX 2>/dev/null

# Step 9: Start tmux session and run node
tmux new-session -d -s NEX "source ~/.bashrc && nexus-network start --node-id $NODE_ID"

echo "✅ Nexus node started inside tmux session 'NEX'"
echo "🔍 To view:     tmux attach-session -t NEX"
echo "❌ To stop:     tmux kill-session -t NEX"
