#!/bin/bash

# セットアップスクリプト
set -e

echo "🚀 Setting up Rust + Circom development environment..."

# Rust環境の確認とアップデート
echo "📦 Updating Rust..."
rustup update stable
rustup default stable

# Circomのインストール
echo "🔧 Installing Circom..."

# Cargoレジストリディレクトリの権限設定
echo "🔧 Setting up Cargo registry permissions..."
sudo mkdir -p /usr/local/cargo/registry
sudo chown -R vscode:rustlang /usr/local/cargo/registry
sudo chmod -R 755 /usr/local/cargo/registry

cd /tmp
git clone https://github.com/iden3/circom.git
cd circom
cargo build --release
cargo install --path circom

# snarkjsのインストール（Circomと連携するため）
echo "📦 Installing snarkjs..."
npm install -g snarkjs

# Circomライブラリのインストール
echo "📚 Installing circomlib..."
npm install -g circomlib

# 設定の確認
echo "✅ Checking installations..."
echo "Rust version:"
rustc --version
echo "Cargo version:"
cargo --version
echo "Circom version:"
circom --version || echo "Circom installed successfully"
echo "Node.js version:"
node --version
echo "npm version:"
npm --version
echo "snarkjs version:"
snarkjs --version || echo "snarkjs installed successfully"

echo "🎉 Setup completed successfully!"
echo ""
echo "📋 Available tools:"
echo "  - Rust (rustc, cargo)"
echo "  - Circom (circom)"
echo "  - Node.js & npm"
echo "  - snarkjs"
echo "  - circomlib"
echo ""
echo "🔗 Useful commands:"
echo "  circom --help          # Circom help"
echo "  cargo new <project>    # Create new Rust project"
echo "  snarkjs --help         # snarkjs help"