const { expect, assert } = require("chai");
const { ethers } = require("hardhat");
const { groth16, plonk } = require("snarkjs");

const wasm_tester = require("circom_tester").wasm;

const F1Field = require("ffjavascript").F1Field;
const Scalar = require("ffjavascript").Scalar;
exports.p = Scalar.fromString("21888242871839275222246405745257275088548364400416034343698204186575808495617");
const Fr = new F1Field(exports.p);

describe("HelloWorld", function () {
    this.timeout(100000000);
    let Verifier;
    let verifier;

    beforeEach(async function () {
        Verifier = await ethers.getContractFactory("HelloWorldVerifier");
        verifier = await Verifier.deploy();
        await verifier.deployed();
    });

    it("Circuit should multiply two numbers correctly", async function () {
        const circuit = await wasm_tester("contracts/circuits/HelloWorld.circom");

        const INPUT = {
            "a": 2,
            "b": 3
        }

        const witness = await circuit.calculateWitness(INPUT, true);

        //console.log(witness);

        assert(Fr.eq(Fr.e(witness[0]),Fr.e(1)));
        assert(Fr.eq(Fr.e(witness[1]),Fr.e(6)));

    });

    it("Should return true for correct proof", async function () {
        //[assignment] Add comments to explain what each line is doing
        const { proof, publicSignals } = await groth16.fullProve({"a":"2","b":"3"}, "contracts/circuits/HelloWorld/HelloWorld_js/HelloWorld.wasm","contracts/circuits/HelloWorld/circuit_final.zkey");

        console.log('2 x 3 =',publicSignals[0]);
        // プルーフとパブリックシグナルをSolidityコントラクトで使用できる形式に変換
        const calldata = await groth16.exportSolidityCallData(proof, publicSignals);
        // コールデータを作成
        const argv = calldata.replace(/["[\]\s]/g, "").split(',').map(x => BigInt(x).toString());
    
        const a = [argv[0], argv[1]];
        const b = [[argv[2], argv[3]], [argv[4], argv[5]]];
        const c = [argv[6], argv[7]];
        const Input = argv.slice(8);
        // コントラクトのverifyProof関数を呼び出し、ZKProofが正しいか検証する
        // 問題なければtrueが返ってくるはず
        expect(await verifier.verifyProof(a, b, c, Input)).to.be.true;
    });
    it("Should return false for invalid proof", async function () {
        let a = [0, 0];
        let b = [[0, 0], [0, 0]];
        let c = [0, 0];
        let d = [0]
        expect(await verifier.verifyProof(a, b, c, d)).to.be.false;
    });
});


describe("Multiplier3 with Groth16", function () {

    beforeEach(async function () {
        // Verifier Contract インスタンスを生成
        Verifier = await ethers.getContractFactory("Multiplier3Verifier");
        verifier = await Verifier.deploy();
        await verifier.deployed();
    });

    it("Circuit should multiply three numbers correctly", async function () {
        const circuit = await wasm_tester("contracts/circuits/Multiplier3.circom");

        const INPUT = {
            "a": 2,
            "b": 3,
            "c": 4
        }
        // witnessの計算
        const witness = await circuit.calculateWitness(INPUT, true);

        //console.log(witness);
        assert(Fr.eq(Fr.e(witness[0]),Fr.e(1)));
        assert(Fr.eq(Fr.e(witness[1]),Fr.e(24)));
    });

    it("Should return true for correct proof", async function () {

        // ZK Proofの生成
        const { 
            proof, 
            publicSignals 
        } = await groth16.fullProve(
            {
                "a":"2",
                "b":"3",
                "c":"4"
            }, 
            "contracts/circuits/Multiplier3/Multiplier3_js/Multiplier3.wasm",
            "contracts/circuits/Multiplier3/circuit_final.zkey"
        );

        console.log('2 x 3 x 4 = ', publicSignals[0]);
        // プルーフとパブリックシグナルをSolidityコントラクトで使用できる形式に変換
        const calldata = await groth16.exportSolidityCallData(proof, publicSignals);
        // コールデータを作成
        const argv = calldata.replace(/["[\]\s]/g, "").split(',').map(x => BigInt(x).toString());
    
        const a = [argv[0], argv[1]];
        const b = [[argv[2], argv[3]], [argv[4], argv[5]]];
        const c = [argv[6], argv[7]];
        const Input = argv.slice(8);
        // コントラクトのverifyProof関数を呼び出し、ZKProofが正しいか検証する
        // 問題なければtrueが返ってくるはず
        expect(await verifier.verifyProof(a, b, c, Input)).to.be.true;
    });

    it("Should return false for invalid proof", async function () {
        let a = [0, 0];
        let b = [[0, 0], [0, 0]];
        let c = [0, 0];
        let d = [0]
        expect(await verifier.verifyProof(a, b, c, d)).to.be.false;
    });
});


describe("Multiplier3 with PLONK", function () {

    beforeEach(async function () {
        // Verifier Contract インスタンスを生成
        Verifier = await ethers.getContractFactory("PlonkVerifier");
        verifier = await Verifier.deploy();
        await verifier.deployed();
    });

    it("Should return true for correct proof", async function () {
        // ZK Proofの生成
        const { 
            proof, 
            publicSignals 
        } = await plonk.fullProve(
            {
                "a":"2",
                "b":"3",
                "c":"4"
            }, 
            "contracts/circuits/Multiplier3Plonk/Multiplier3_js/Multiplier3.wasm",
            "contracts/circuits/Multiplier3Plonk/circuit_final.zkey"
        );

        console.log('2 x 3 x 4 = ', publicSignals[0]);

        // プルーフとパブリックシグナルをSolidityコントラクトで使用できる形式に変換
        const calldata = await plonk.exportSolidityCallData(proof, publicSignals);
        
        // PLONKのコールデータは2つのJSON配列が連結された形式
        // 最初の "]" を見つけて2つの配列に分割
        const firstBracketEnd = calldata.indexOf(']') + 1;
        const proofDataStr = calldata.substring(0, firstBracketEnd);
        const publicInputsStr = calldata.substring(firstBracketEnd);
        
        // それぞれをJSONパース
        const proofData = JSON.parse(proofDataStr);
        const publicInputs = JSON.parse(publicInputsStr);
        
        // コントラクトのverifyProof関数を呼び出し、ZKProofが正しいか検証する
        // 問題なければtrueが返ってくるはず
        expect(await verifier.verifyProof(proofData, publicInputs)).to.be.true;
    });
    
    it("Should return false for invalid proof", async function () {
        // 無効な証明データ（全て0）
        const invalidProofData = Array(24).fill("0");
        const invalidPublicInputs = ["0"];
        
        expect(await verifier.verifyProof(invalidProofData, invalidPublicInputs)).to.be.false;
    });
});

describe("RangeProof", function () {

    beforeEach(async function () {
        // Verifier Contract インスタンスを生成
        Verifier = await ethers.getContractFactory("RangeProof");
        verifier = await Verifier.deploy();
        await verifier.deployed();
    });

    it("Should return true for correct proof", async function () {

        // ZK Proofの生成
        const { 
            proof, 
            publicSignals 
        } = await groth16.fullProve(
            {
                "in": "5",
                "range": ["1", "10"]
            }, 
            "contracts/circuits/RangeProof/RangeProof_js/RangeProof.wasm",
            "contracts/circuits/RangeProof/circuit_final.zkey"
        );

        // プルーフとパブリックシグナルをSolidityコントラクトで使用できる形式に変換
        const calldata = await groth16.exportSolidityCallData(proof, publicSignals);
        // コールデータを作成
        const argv = calldata.replace(/["[\]\s]/g, "").split(',').map(x => BigInt(x).toString());
    
        const a = [argv[0], argv[1]];
        const b = [[argv[2], argv[3]], [argv[4], argv[5]]];
        const c = [argv[6], argv[7]];
        const Input = argv.slice(8);
        // コントラクトのverifyProof関数を呼び出し、ZKProofが正しいか検証する
        // 問題なければtrueが返ってくるはず
        expect(await verifier.verifyProof(a, b, c, Input)).to.be.true;
    });
});

describe("Sudoku", function () {
    beforeEach(async function () {
        // Verifier Contract インスタンスを生成
        Verifier = await ethers.getContractFactory("SudokuVerifier");
        verifier = await Verifier.deploy();
        await verifier.deployed();
    });

    it("Should return true for correct proof", async function () {

        // ZK Proofの生成
        const { 
            proof, 
            publicSignals 
        } = await groth16.fullProve(
            {
                "puzzle": [
                    ["1", "0", "0", "0", "0", "0", "0", "0", "0"],
                    ["0", "8", "0", "0", "0", "0", "0", "0", "0"],
                    ["0", "0", "6", "0", "0", "0", "0", "0", "0"],
                    ["0", "0", "0", "5", "0", "0", "0", "0", "0"],
                    ["0", "0", "0", "0", "3", "0", "0", "0", "0"],
                    ["0", "0", "0", "0", "0", "1", "0", "0", "0"],
                    ["0", "0", "0", "0", "0", "0", "9", "0", "0"],
                    ["0", "0", "0", "0", "0", "0", "0", "7", "0"],
                    ["0", "0", "0", "0", "0", "0", "0", "0", "5"]
                ],
                "solution": [
                    ["0", "7", "4", "2", "8", "5", "3", "9", "6"],
                    ["2", "0", "5", "3", "9", "6", "4", "1", "7"],
                    ["3", "9", "0", "4", "1", "7", "5", "2", "8"],
                    ["4", "1", "7", "0", "2", "8", "6", "3", "9"],
                    ["5", "2", "8", "6", "0", "9", "7", "4", "1"],
                    ["6", "3", "9", "7", "4", "0", "8", "5", "2"],
                    ["7", "4", "1", "8", "5", "2", "0", "6", "3"],
                    ["8", "5", "2", "9", "6", "3", "1", "0", "4"],
                    ["9", "6", "3", "1", "7", "4", "2", "8", "0"]
                ]
            }, 
            "contracts/circuits/Sudoku/Sudoku_js/Sudoku.wasm",
            "contracts/circuits/Sudoku/circuit_final.zkey"
        );

        // プルーフとパブリックシグナルをSolidityコントラクトで使用できる形式に変換
        const calldata = await groth16.exportSolidityCallData(proof, publicSignals);
        // コールデータを作成
        const argv = calldata.replace(/["[\]\s]/g, "").split(',').map(x => BigInt(x).toString());
    
        const a = [argv[0], argv[1]];
        const b = [[argv[2], argv[3]], [argv[4], argv[5]]];
        const c = [argv[6], argv[7]];
        const Input = argv.slice(8);
        // コントラクトのverifyProof関数を呼び出し、ZKProofが正しいか検証する
        // 問題なければtrueが返ってくるはず
        expect(await verifier.verifyProof(a, b, c, Input)).to.be.true;
    });
});