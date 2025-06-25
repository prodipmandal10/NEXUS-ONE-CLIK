#!/bin/bash

echo -e "\033[5;35;43m 🔥 NEXUS BY PRODIP 🔥 \033[0m"
sleep 2

echo "🚀 Starting Full Nexus Node Auto-Setup..."

sudo apt update && sudo apt upgrade -y
sudo apt install screen curl build-essential pkg-config libssl-dev git-all -y
sudo apt install protobuf-compiler -y
sudo apt install tmux -y

echo "🦀 Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env
rustup target add riscv32i-unknown-none-elf

echo "📦 Installing Nexus CLI..."
curl https://cli.nexus.xyz/ | sh
source ~/.bashrc

read -p "🔑 Enter your Node ID: " NODE_ID

# পুরাতন screen বন্ধ করুন
screen -S NEX -X quit 2>/dev/null

# নতুন screen চালু করুন full path দিয়ে
screen -dmS NEX bash -c "~/.nexus/bin/nexus-network start --node-id $NODE_ID; exec bash"

echo "✅ Nexus node started inside screen session 'NEX'"
echo "🔍 To view logs: screen -r NEX"
echo "❌ To stop node: screen -S NEX -X quit"
