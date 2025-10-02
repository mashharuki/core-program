#!/bin/bash

# Multiplier3.circomをPLONK証明システム用にコンパイルおよびセットアップするスクリプト

# ----------------------------------------------------
# 1. 環境設定
# ----------------------------------------------------
cd contracts/circuits

# 回路ディレクトリの作成
mkdir -p Multiplier3Plonk

# powersOfTau28_hez_final_14.ptau (普遍的なトラステッドセットアップ)のダウンロード
if [ -f ./powersOfTau28_hez_final_14.ptau ]; then
    echo "powersOfTau28_hez_final_14.ptau がすでに存在します。スキップします。"
else
    echo 'Downloading powersOfTau28_hez_final_14.ptau'
    # Hermezのptauファイルを使用
    wget https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_14.ptau
fi

echo "Compiling Multiplier3.circom..."

# ----------------------------------------------------
# 2. 回路のコンパイル
# ----------------------------------------------------
# R1CS、WASM、SYMファイルを生成
circom Multiplier3.circom --r1cs --wasm --sym -o Multiplier3Plonk

# R1CSの情報を表示
snarkjs r1cs info Multiplier3Plonk/Multiplier3.r1cs

# ----------------------------------------------------
# 3. PLONKのセットアップ（ZKeyの作成）
# ----------------------------------------------------
echo "Starting PLONK setup and generating initial zkey..."

# Groth16の代わりにplonk setupを使用
# R1CSファイルとptauファイルから最初のZKeyファイルを生成
snarkjs plonk setup Multiplier3Plonk/Multiplier3.r1cs powersOfTau28_hez_final_14.ptau Multiplier3Plonk/circuit_0000.zkey

# ----------------------------------------------------
# 4. ZKeyの確定
# ----------------------------------------------------
echo "Renaming zkey file. Contribution is not required for PLONK."

# PLONKでは普遍的なSRSが使用されるため、Groth16のような個別の貢献フェーズは不要です。
# 0000.zkeyをfinal.zkeyにリネームして、以降のコマンドで使用します。
mv Multiplier3Plonk/circuit_0000.zkey Multiplier3Plonk/circuit_final.zkey

# ----------------------------------------------------
# 5. 検証キーの生成とエクスポート
# ----------------------------------------------------
echo "Exporting verification key..."

snarkjs zkey export verificationkey Multiplier3Plonk/circuit_final.zkey Multiplier3Plonk/verification_key.json

# ----------------------------------------------------
# 6. Solidity PLONK Verifierコントラクトの生成
# ----------------------------------------------------
echo "Exporting PLONK Verifier Solidity Contract..."

# Groth16の代わりにplonkverifierコマンドを使用
# コントラクト名も 'Multiplier3VerifierPlonk.sol' に変更して区別しやすくします
snarkjs zkey export solidityverifier Multiplier3Plonk/circuit_final.zkey ../Multiplier3VerifierPlonk.sol

echo "PLONK setup for Multiplier3Plonk is complete."
cd ../..
