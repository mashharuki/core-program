#!/bin/bash

cd contracts/circuits

mkdir PreimageProof

if [ -f ./powersOfTau28_hez_final_14.ptau ]; then
    echo "powersOfTau28_hez_final_14.ptau already exists. Skipping."
else
    echo 'Downloading powersOfTau28_hez_final_14.ptau'
    wget https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_14.ptau
fi

echo "Compiling preimage.circom..."

# compile circuit

circom preimage.circom --r1cs --wasm --sym -o PreimageProof
snarkjs r1cs info PreimageProof/preimage.r1cs

# Start a new zkey and make a contribution

snarkjs groth16 setup PreimageProof/preimage.r1cs powersOfTau28_hez_final_14.ptau PreimageProof/circuit_0000.zkey
snarkjs zkey contribute PreimageProof/circuit_0000.zkey PreimageProof/circuit_final.zkey --name="1st Contributor Name" -v -e="random text"
snarkjs zkey export verificationkey PreimageProof/circuit_final.zkey PreimageProof/verification_key.json

# generate solidity contract
snarkjs zkey export solidityverifier PreimageProof/circuit_final.zkey ../PreimageProofVerifier.sol

cd ../..