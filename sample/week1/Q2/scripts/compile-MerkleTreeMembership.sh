#!/bin/bash

cd contracts/circuits

mkdir MerkleTreeMembership

if [ -f ./powersOfTau28_hez_final_14.ptau ]; then
    echo "powersOfTau28_hez_final_14.ptau already exists. Skipping."
else
    echo 'Downloading powersOfTau28_hez_final_14.ptau'
    wget https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_14.ptau
fi

echo "Compiling MerkleTreeMembership.circom..."

# compile circuit

circom MerkleTreeMembership.circom --r1cs --wasm --sym -o MerkleTreeMembership
snarkjs r1cs info MerkleTreeMembership/MerkleTreeMembership.r1cs

# Start a new zkey and make a contribution

snarkjs groth16 setup MerkleTreeMembership/MerkleTreeMembership.r1cs powersOfTau28_hez_final_14.ptau MerkleTreeMembership/circuit_0000.zkey
snarkjs zkey contribute MerkleTreeMembership/circuit_0000.zkey MerkleTreeMembership/circuit_final.zkey --name="1st Contributor Name" -v -e="random text"
snarkjs zkey export verificationkey MerkleTreeMembership/circuit_final.zkey MerkleTreeMembership/verification_key.json

# generate solidity contract
snarkjs zkey export solidityverifier MerkleTreeMembership/circuit_final.zkey ../MerkleTreeMembershipVerifier.sol

cd ../..