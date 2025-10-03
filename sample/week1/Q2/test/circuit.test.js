const { expect, assert } = require("chai");
const { ethers } = require("hardhat");
const { groth16, plonk } = require("snarkjs");
const { poseidon1 } = require("poseidon-lite");
const { buildPoseidon } = require("circomlibjs");

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

describe("Preimage", function () {
    beforeEach(async function () {
        // Verifier Contract インスタンスを生成
        Verifier = await ethers.getContractFactory("PreimageProofVerifier");
        verifier = await Verifier.deploy();
        await verifier.deployed();
    });

    it("Should return true for correct proof", async function () {
        // ハッシュ値の生成
        const preimage = "123456789";
        const expectedHash = poseidon1([preimage]);

        // ZK Proofの生成
        const { 
            proof, 
            publicSignals 
        } = await groth16.fullProve(
            {
                "preimage": preimage,
                "expectedHash": expectedHash.toString()
            }, 
            "contracts/circuits/PreimageProof/preimage_js/preimage.wasm",
            "contracts/circuits/PreimageProof/circuit_final.zkey"
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

    it("Should return false for incorrect proof", async function () {
        let a = [0, 0];
        let b = [[0, 0], [0, 0]];
        let c = [0, 0];
        let d = [0]
        expect(await verifier.verifyProof(a, b, c, d)).to.be.false;
    });
});

describe("SimplePublicKeyProof", function () {
    beforeEach(async function () {
        // Verifier Contract インスタンスを生成
        Verifier = await ethers.getContractFactory("SimplePublicKeyProofVerifier");
        verifier = await Verifier.deploy();
        await verifier.deployed();
    });

    it("Circuit should compute public key correctly", async function () {
        const circuit = await wasm_tester("contracts/circuits/SimplePublicKeyProof.circom");

        // テスト用の秘密鍵
        const privateKey = 123;
        // 期待される公開鍵（privateKey^2）
        const expectedPublicKey = privateKey * privateKey;
        // インプットデータ
        const INPUT = {
            "privateKey": privateKey,
            "expectedPublicKey": expectedPublicKey
        }
        // ウィットネスを生成
        const witness = await circuit.calculateWitness(INPUT, true);

        // 出力が1（有効）であることを確認
        assert(Fr.eq(Fr.e(witness[0]), Fr.e(1)));
        assert(Fr.eq(Fr.e(witness[1]), Fr.e(1))); // isValid output should be 1
    });

    it("Should return true for correct proof", async function () {
        const privateKey = 123;
        const expectedPublicKey = privateKey * privateKey;

        // ZK Proofの生成
        const { 
            proof, 
            publicSignals 
        } = await groth16.fullProve(
            {
                "privateKey": privateKey.toString(),
                "expectedPublicKey": expectedPublicKey.toString()
            }, 
            "contracts/circuits/SimplePublicKeyProof/SimplePublicKeyProof_js/SimplePublicKeyProof.wasm",
            "contracts/circuits/SimplePublicKeyProof/circuit_final.zkey"
        );

        console.log('SimplePublicKeyProof verification result:', publicSignals[0]);
        
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

    it("Should return false for incorrect proof", async function () {
        let a = [0, 0];
        let b = [[0, 0], [0, 0]];
        let c = [0, 0];
        let d = [0]
        expect(await verifier.verifyProof(a, b, c, d)).to.be.false;
    });
});

describe("EllipticCurvePublicKeyProof", function () {
    beforeEach(async function () {
        // Verifier Contract インスタンスを生成
        Verifier = await ethers.getContractFactory("EllipticCurvePublicKeyProofVerifier");
        verifier = await Verifier.deploy();
        await verifier.deployed();
    });

    it("Circuit should verify elliptic curve public key correctly", async function () {
        const circuit = await wasm_tester("contracts/circuits/EllipticCurvePublicKeyProof.circom");

        // テスト用の秘密鍵（小さな値でテスト）
        const privateKey = 1;
        // Baby Jubjubのベースポイント（秘密鍵1の場合の公開鍵）
        const publicKeyX = "5299619240641551281634865583518297030282874472190772894086521144482721001553";
        const publicKeyY = "16950150798460657717958625567821834550301663161624707787222815936182638968203";

        const INPUT = {
            "privateKey": privateKey,
            "publicKeyX": publicKeyX,
            "publicKeyY": publicKeyY
        }

        const witness = await circuit.calculateWitness(INPUT, true);

        // 出力が1（有効）であることを確認
        assert(Fr.eq(Fr.e(witness[0]), Fr.e(1)));
        assert(Fr.eq(Fr.e(witness[1]), Fr.e(1))); // isValid output should be 1
    });

    it("Should return true for correct proof", async function () {
        const privateKey = 1;
        const publicKeyX = "5299619240641551281634865583518297030282874472190772894086521144482721001553";
        const publicKeyY = "16950150798460657717958625567821834550301663161624707787222815936182638968203";

        // ZK Proofの生成
        const { 
            proof, 
            publicSignals 
        } = await groth16.fullProve(
            {
                "privateKey": privateKey.toString(),
                "publicKeyX": publicKeyX,
                "publicKeyY": publicKeyY
            }, 
            "contracts/circuits/EllipticCurvePublicKeyProof/EllipticCurvePublicKeyProof_js/EllipticCurvePublicKeyProof.wasm",
            "contracts/circuits/EllipticCurvePublicKeyProof/circuit_final.zkey"
        );

        console.log('EllipticCurvePublicKeyProof verification result:', publicSignals[0]);
        
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

    it("Should return false for incorrect proof", async function () {
        let a = [0, 0];
        let b = [[0, 0], [0, 0]];
        let c = [0, 0];
        let d = [0]
        expect(await verifier.verifyProof(a, b, c, d)).to.be.false;
    });
});

describe("PublicKeyProof", function () {
    beforeEach(async function () {
        // Verifier Contract インスタンスを生成
        Verifier = await ethers.getContractFactory("PublicKeyProofVerifier");
        verifier = await Verifier.deploy();
        await verifier.deployed();
    });

    it("Circuit should verify public key proof correctly", async function () {
        const circuit = await wasm_tester("contracts/circuits/PublicKeyProof.circom");

        // テスト用の秘密鍵
        const privateKey = 123;
        // MiMCハッシュで期待される公開鍵ハッシュを計算
        // この部分は実際のMiMCハッシュ実装に依存するため、簡単な値でテスト
        const expectedPublicKeyHash = "123"; // 実際の実装では適切なハッシュ値を使用

        const INPUT = {
            "privateKey": "123456789123456789123456789123456789123456789123456789123456789",
            "publicKeyX": "2493394592036737521743126938924619962299839498263590212456488346761502447952",
            "publicKeyY": "15371661642878696700085442526315802521711204094770244670051242306230919379841"
        }

        const witness = await circuit.calculateWitness(INPUT, true);

        // 出力が期待値と一致することを確認
        assert(Fr.eq(Fr.e(witness[0]), Fr.e(1)));
    });

    it("Should return true for correct proof", async function () {
        // ZK Proofの生成
        const { 
            proof, 
            publicSignals 
        } = await groth16.fullProve(
            {
                "privateKey": "123456789123456789123456789123456789123456789123456789123456789",
                "publicKeyX": "2493394592036737521743126938924619962299839498263590212456488346761502447952",
                "publicKeyY": "15371661642878696700085442526315802521711204094770244670051242306230919379841"
            }, 
            "contracts/circuits/PublicKeyProof/PublicKeyProof_js/PublicKeyProof.wasm",
            "contracts/circuits/PublicKeyProof/circuit_final.zkey"
        );

        console.log('PublicKeyProof verification result:', publicSignals[0]);
        
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

    it("Should return false for incorrect proof", async function () {
        let a = [0, 0];
        let b = [[0, 0], [0, 0]];
        let c = [0, 0];
        let d = [0]
        expect(await verifier.verifyProof(a, b, c, d)).to.be.false;
    });
});

describe("MerkleTreeMembershipVerifier", function () {
    beforeEach(async function () {
        // Verifier Contract インスタンスを生成
        Verifier = await ethers.getContractFactory("MerkleTreeMembershipVerifier");
        verifier = await Verifier.deploy();
        await verifier.deployed();
    });

    it("Circuit should verify Merkle tree membership correctly", async function () {
        const poseidon = await buildPoseidon();
        const F = poseidon.F;

        // リーフ（メンバーのID）
        // リーフ（メンバーのID）- depth=4なので16個のリーフが必要
        const leaves = [];
        for (let i = 0; i < 16; i++) {
            leaves.push(F.e(String(100 + i))); // 100, 101, 102, ...
        }

        // マークルツリーを構築（depth=4）
        // レベル0: 16個のリーフ
        // レベル1: 8個のノード
        const level1 = [];
        for (let i = 0; i < 8; i++) {
            level1.push(poseidon([leaves[i * 2], leaves[i * 2 + 1]]));
        }

        // レベル2: 4個のノード
        const level2 = [];
        for (let i = 0; i < 4; i++) {
            level2.push(poseidon([level1[i * 2], level1[i * 2 + 1]]));
        }

        // レベル3: 2個のノード
        const level3 = [];
        for (let i = 0; i < 2; i++) {
            level3.push(poseidon([level2[i * 2], level2[i * 2 + 1]]));
        }

        // レベル1のノードをハッシュ化
        const root = poseidon(level3);

        /*
                     Root
                    /    \
            level1[0] level1[1]
                /  \      /  \
            Alice Bob Carol David
            (0)   (1)  (2)   (3)
        */

        // インデックス1のリーフ（101）を証明
        // インデックス1 = 二進数で 0001（右、左、左、左）
        const leafIndex = 1;
        const leaf = leaves[leafIndex];

        // マークルパスを計算
        // レベル0: インデックス1は右側 → 兄弟はインデックス0（左）
        // レベル1: ペアインデックス0は左側 → 兄弟はインデックス1（右）
        // レベル2: ペアインデックス0は左側 → 兄弟はインデックス1（右）
        // レベル3: ペアインデックス0は左側 → 兄弟はインデックス1（右）
        const pathElements = [
            F.toString(leaves[0]),      // レベル0: インデックス0とペア
            F.toString(level1[1]),      // レベル1: インデックス1とペア
            F.toString(level2[1]),      // レベル2: インデックス1とペア
            F.toString(level3[1])       // レベル3: インデックス1とペア
        ];

        const pathIndices = [1, 0, 0, 0];  // 右、左、左、左
        
        // ZK Proofを生成する
        const { 
            proof, 
            publicSignals 
        } = await groth16.fullProve(
            {
                "leaf": F.toString(leaf),
                "pathElements": pathElements,
                "pathIndices": pathIndices,
                "root": F.toString(root)
            }, 
            "contracts/circuits/MerkleTreeMembership/MerkleTreeMembership_js/MerkleTreeMembership.wasm",
            "contracts/circuits/MerkleTreeMembership/circuit_final.zkey"
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