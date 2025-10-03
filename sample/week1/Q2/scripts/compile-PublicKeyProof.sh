#!/bin/bash

cd contracts/circuits

mkdir PublicKeyProof

if [ -f ./powersOfTau28_hez_final_14.ptau ]; then
    echo "powersOfTau28_hez_final_14.ptau already exists. Skipping."
else
    echo 'Downloading powersOfTau28_hez_final_14.ptau'
    wget https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_14.ptau
fi

echo "Compiling PublicKeyProof.circom..."

# compile circuit

circom PublicKeyProof.circom --r1cs --wasm --sym -o PublicKeyProof
snarkjs r1cs info PublicKeyProof/PublicKeyProof.r1cs

# Start a new zkey and make a contribution

snarkjs groth16 setup PublicKeyProof/PublicKeyProof.r1cs powersOfTau28_hez_final_14.ptau PublicKeyProof/circuit_0000.zkey
snarkjs zkey contribute PublicKeyProof/circuit_0000.zkey PublicKeyProof/circuit_final.zkey --name="1st Contributor Name" -v -e="random text"
snarkjs zkey export verificationkey PublicKeyProof/circuit_final.zkey PublicKeyProof/verification_key.json

# generate solidity contract
snarkjs zkey export solidityverifier PublicKeyProof/circuit_final.zkey ../PublicKeyProofVerifier.sol

cd ../..