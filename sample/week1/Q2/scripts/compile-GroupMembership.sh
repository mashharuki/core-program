#!/bin/bash

cd contracts/circuits

mkdir GroupMembership

if [ -f ./powersOfTau28_hez_final_14.ptau ]; then
    echo "powersOfTau28_hez_final_14.ptau already exists. Skipping."
else
    echo 'Downloading powersOfTau28_hez_final_14.ptau'
    wget https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_14.ptau
fi

echo "Compiling GroupMembership.circom..."

# compile circuit

circom GroupMembership.circom --r1cs --wasm --sym -o GroupMembership
snarkjs r1cs info GroupMembership/GroupMembership.r1cs

# Start a new zkey and make a contribution

snarkjs groth16 setup GroupMembership/GroupMembership.r1cs powersOfTau28_hez_final_14.ptau GroupMembership/circuit_0000.zkey
snarkjs zkey contribute GroupMembership/circuit_0000.zkey GroupMembership/circuit_final.zkey --name="1st Contributor Name" -v -e="random text"
snarkjs zkey export verificationkey GroupMembership/circuit_final.zkey GroupMembership/verification_key.json

# generate solidity contract
snarkjs zkey export solidityverifier GroupMembership/circuit_final.zkey ../GroupMembershipVerifier.sol

cd ../..