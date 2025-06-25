#!/bin/bash

echo -e "\033[5;35;43m 🔥 NEXUS BY PRODIP 🔥 \033[0m"
sleep 2

echo "🚀 Starting Full Nexus Node Auto-Setup..."

# আপডেট ও ইনস্টল
sudo apt update && sudo apt upgrade -y
sudo apt install screen curl build-essential pkg-config libssl-dev git-all -y
sudo apt install protobuf-compiler -y
sudo apt install tmux -y

# Rust ইনস্টল
echo "🦀 Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

source $HOME/.cargo/env

rustup target add riscv32i-unknown-none-elf

# Nexus CLI ইনস্টল
echo "📦 Installing Nexus CLI..."
curl https://cli.nexus.xyz/ | sh

source ~/.bashrc

# Node ID নিন
read -p "🔑 Enter your Node ID: " NODE_ID

# পুরনো screen session থাকলে বন্ধ করুন
screen -S NEX -X quit 2>/dev/null

# নতুন screen session তৈরি ও nexus-node রান করুন
screen -dmS NEX bash -c "source ~/.bashrc; source \$HOME/.cargo/env; nexus-network start --node-id $NODE_ID; exec bash"

echo "✅ Nexus node started inside screen session 'NEX'"
echo "🔍 To view logs: screen -r NEX"
echo "❌ To stop node: screen -S NEX -X quit"
