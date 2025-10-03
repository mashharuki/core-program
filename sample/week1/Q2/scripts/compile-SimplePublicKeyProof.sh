#!/bin/bash

cd contracts/circuits

mkdir SimplePublicKeyProof

if [ -f ./powersOfTau28_hez_final_14.ptau ]; then
    echo "powersOfTau28_hez_final_14.ptau already exists. Skipping."
else
    echo 'Downloading powersOfTau28_hez_final_14.ptau'
    wget https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_14.ptau
fi

echo "Compiling SimplePublicKeyProof.circom..."

# compile circuit

circom SimplePublicKeyProof.circom --r1cs --wasm --sym -o SimplePublicKeyProof
snarkjs r1cs info SimplePublicKeyProof/SimplePublicKeyProof.r1cs

# Start a new zkey and make a contribution

snarkjs groth16 setup SimplePublicKeyProof/SimplePublicKeyProof.r1cs powersOfTau28_hez_final_14.ptau SimplePublicKeyProof/circuit_0000.zkey
snarkjs zkey contribute SimplePublicKeyProof/circuit_0000.zkey SimplePublicKeyProof/circuit_final.zkey --name="1st Contributor Name" -v -e="random text"
snarkjs zkey export verificationkey SimplePublicKeyProof/circuit_final.zkey SimplePublicKeyProof/verification_key.json

# generate solidity contract
snarkjs zkey export solidityverifier SimplePublicKeyProof/circuit_final.zkey ../SimplePublicKeyProofVerifier.sol

cd ../..