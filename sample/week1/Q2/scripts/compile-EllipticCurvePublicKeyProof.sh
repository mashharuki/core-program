#!/bin/bash

cd contracts/circuits

mkdir EllipticCurvePublicKeyProof

if [ -f ./powersOfTau28_hez_final_14.ptau ]; then
    echo "powersOfTau28_hez_final_14.ptau already exists. Skipping."
else
    echo 'Downloading powersOfTau28_hez_final_14.ptau'
    wget https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_14.ptau
fi

echo "Compiling EllipticCurvePublicKeyProof.circom..."

# compile circuit

circom EllipticCurvePublicKeyProof.circom --r1cs --wasm --sym -o EllipticCurvePublicKeyProof
snarkjs r1cs info EllipticCurvePublicKeyProof/EllipticCurvePublicKeyProof.r1cs

# Start a new zkey and make a contribution

snarkjs groth16 setup EllipticCurvePublicKeyProof/EllipticCurvePublicKeyProof.r1cs powersOfTau28_hez_final_14.ptau EllipticCurvePublicKeyProof/circuit_0000.zkey
snarkjs zkey contribute EllipticCurvePublicKeyProof/circuit_0000.zkey EllipticCurvePublicKeyProof/circuit_final.zkey --name="1st Contributor Name" -v -e="random text"
snarkjs zkey export verificationkey EllipticCurvePublicKeyProof/circuit_final.zkey EllipticCurvePublicKeyProof/verification_key.json

# generate solidity contract
snarkjs zkey export solidityverifier EllipticCurvePublicKeyProof/circuit_final.zkey ../EllipticCurvePublicKeyProofVerifier.sol

cd ../..