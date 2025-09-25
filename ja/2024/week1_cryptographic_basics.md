 # Week 1 - 暗号の基本
 
 ## 実践編
 
 各モジュールでは、できるだけ早く手を動かせるよう「実践」を用意しています。まずは Circom による回路記述の基本から始めましょう。
 
 ### Circom の始め方
 
 #### Circom 回路がアプリにどう統合されるか
 以下のワークフローで、Circom 回路がアプリに統合されるイメージを掴みましょう：
 
 ```mermaid
 sequenceDiagram
     participant Developer
     participant Circom
     participant User
     participant App
     participant ProverModule
     participant Verifier
 
     Developer->>Circom: Writes circuit definition
     Developer->>Circom: Compiles circuit
     Developer->>Circom: Runs Trusted Setup
     Circom->>Developer: Return the ZK artifacts
     Developer->>ProverModule: Installs Witness calculator & Proving key
     Developer->>Verifier: Deploys contract or service with .vkey.json 
     User->>App: Inputs data for proof generation
     App->>ProverModule: Sends inputs & proving key
     ProverModule->>ProverModule: Generates cryptographic proof
     ProverModule->>App: Returns proof
     App->>Verifier: Sends proof for verification
     Verifier->>App: Verifies proof and returns result
     App->>User: Displays verification result
 ```
 
 ##### 生成物（Circom コンパイラが生成）
 - Witness 計算機: 入力から witness を計算（.wasm / .js / .wtns など）
 - 証明鍵/検証鍵: Trusted Setup（Groth16, PLONK 等）で生成（.zkey / .vkey.json）
 - コントラクト: 検証用スマートコントラクト（通常 Solidity .sol）
 
 ### 文法と zkREPL
 
 セットアップ不要で Circom をブラウザで試せる zkREPL（https://zkrepl.dev/）から始めると楽です。
 おすすめ動画：Circom Workshop 1（0xParc）: https://learn.0xparc.org/materials/circom/learning-group-1/circom-1/
 
 まずは以下のサンプルを zkREPL に貼ってコンパイル：
 
 ```circom
 pragma circom 2.1.6;
 
 template AdditionProof() {
     // declaration of signals
     signal input a;
     signal input b;
     signal output sum;
 
     // constraint
     sum <== a + b;
 }
 
 component main = AdditionProof();
 
 /* INPUT = {
     "a": 3,
     "b": 5
 } */
 ```
 
 `a` と `b` は非公開入力です。
 
 ### 乗算の証明回路を書いてみる
 
 まず2数の乗算、次に3数の乗算を証明する回路を作ってみましょう。コードは保存しておき、週末に提出できるようにします。
 
 ### ハッシュプリイメージの証明回路
 
 Poseidon を使って、プリイメージを知っていることを証明します。先頭に以下を追加：
 
 ```circom
 include "circomlib/poseidon.circom";
 ```
 
 使い方：
 
 ```circom
 component hasher = Poseidon(1);
 hasher.inputs[0] <== preimage;
 hashOutput <== hasher.out;
 ```
 
 入力例：
 
 ```circom
 /* INPUT = {
     "preimage": "12345",
     "hash": "4267533774488295900887461483015112262021273608761099826938271132511348470966"
 } */
 ```
 
 ### 楕円曲線上の加算
 
 `babyjub.circom` を取り込み、点加算を確認する回路：
 
 ```circom
 // Code modified from circomlib test
 pragma circom 2.1.6;
 
 include "circomlib/circuits/babyjub.circom";
 
 template AddNumOnEllipticCurve() {
     signal input x1;
     signal input y1;
     signal input x2;
     signal input y2;
     // To check xout yout
     signal input xout;
     signal input yout;
     component babyAdd = BabyAdd();
     babyAdd.x1 <== x1;
     babyAdd.y1 <== y1;
     babyAdd.x2 <== x2;
     babyAdd.y2 <== y2;
     xout === babyAdd.xout;
     yout === babyAdd.yout;
 }
 
 component main = AddNumOnEllipticCurve();
 
 /* INPUT = {
     "x1": "17777552123799933955779906779655732241715742912184938656739573121738514868268",
     "y1": "2626589144620713026669568689430873010625803728049924121243784502389097019475",
     "x2": "17777552123799933955779906779655732241715742912184938656739573121738514868268",
     "y2": "2626589144620713026669568689430873010625803728049924121243784502389097019475",
     "xout": "6890855772600357754907169075114257697580319025794532037257385534741338397365",
     "yout": "4338620300185947561074059802482547481416142213883829469920100239455078257889"
 } */
 ```
 
 ### メルクル木の包含証明
 
 参考：TheBC01 の例 https://github.com/TtheBC01/zkSNARK-playground/blob/main/examples/merkle-tree/tree.circom
 
 Poseidon を n=2 で初期化し、Mux を使って左右を選択：
 
 ```circom
 poseidons[i] = Poseidon(2);
 mux[i] = MultiMux1(2);
 ```
 
 ### Tips
 
 circomlib の例が参考になります: https://github.com/iden3/circomlib
 
 ## 学習編
 
 ### 共通鍵 vs 公開鍵（AES, RSA）
 
 - 共通鍵（対称鍵）：暗号化・復号に同じ鍵。代表例：AES
 - 公開鍵（非対称鍵）：公開鍵で暗号化、秘密鍵で復号。代表例：RSA
 
 参考：
 - 対称 vs 非対称: https://www.ssl2buy.com/wiki/symmetric-vs-asymmetric-encryption-what-are-differences
 - AES（Computerphile）: https://www.youtube.com/watch?v=O4xNJsjtN6E
 - RSA（Computerphile）: https://www.youtube.com/watch?v=JD72Ry60eP4
 - AES 解説: https://www.simplilearn.com/tutorials/cryptography-tutorial/aes-encryption
 - RSA 解説: https://www.comparitech.com/blog/information-security/rsa-encryption/
 
 :::info
 🤔 考えてみよう
 1. 対称鍵と非対称鍵の主な違いは？
 2. AES の動作を簡潔に説明してください。
 3. RSA が公開鍵暗号で広く使われる理由は？
 :::
 
 ### ハッシュ関数とメルクル木
 
 #### ハッシュ関数
 
 入力から固定長出力を生成。ここでは SHA-256 と Poseidon（回路親和的）に注目。
 
 特性：原像困難性、第二原像困難性、衝突困難性。ブロックチェーンではブロック・トランザクションの識別・完全性に利用。
 
 ```mermaid
 flowchart TB
     subgraph Inputs
         A1["Input 1: 'Hello World'"]
         A2["Input 2: 'Hello'"]
         A3["Input 3: '123456'"]
         A4["Input 4: 'Blockchain'"]
     end
 
     subgraph Poseidon Hash Function
         Poseidon["Poseidon Hash"]
     end
 
     subgraph Outputs
         B1["Hash Output 1: 9f86d081884c7d659a2feaa0c55ad015..."]
         B2["Hash Output 2: e0ac3600c813991f82cdbb3f707d7898..."]
         B3["Hash Output 3: a83e50450ac94b2c8fd1bc73f540dbdb..."]
         B4["Hash Output 4: 0fb2e6a2b3470e2a69d0b13e4b75d28e..."]
     end
 
     A1 -->|Input 1| Poseidon
     A2 -->|Input 2| Poseidon
     A3 -->|Input 3| Poseidon
     A4 -->|Input 4| Poseidon
     
     Poseidon -->|Hash 1| B1
     Poseidon -->|Hash 2| B2
     Poseidon -->|Hash 3| B3
     Poseidon -->|Hash 4| B4
 
 ```
 
 参考：
 - SHA-256 の仕組み: https://www.ssldragon.com/blog/sha-256-algorithm/
 - ブロックチェーンでの SHA-256: https://www.educative.io/answers/how-is-sha-256-used-in-blockchain-and-why
 - Poseidon 論文: https://eprint.iacr.org/2019/458.pdf
 - USENIX Security '21（動画）: https://www.youtube.com/watch?v=hUx3WpDV_l0
 
 :::info
 🤔 考えてみよう
 1. ハッシュ関数とは何か、その主用途は？
 2. SHA-256 の高レベル動作は？
 3. Poseidon が ZKP に有用な理由は？
 :::
 
 #### メルクル木
 
 二分木にハッシュを格納し、ルートで大規模集合を要約。包含証明が効率的。
 
 ```mermaid
 flowchart TB
     subgraph "Merkle Tree"
         A0["Leaf 1: Tx1 Hash"]
         A1["Leaf 2: Tx2 Hash"]
         A2["Leaf 3: Tx3 Hash"]
         A3["Leaf 4: Tx4 Hash"]
         
         B0["Hash of (Leaf 1 + Leaf 2)"]
         B1["Hash of (Leaf 3 + Leaf 4)"]
         
         C0["Merkle Root: Hash of (B0 + B1)"]
         
         A0 -->|Hash| B0
         A1 -->|Hash| B0
         A2 -->|Hash| B1
         A3 -->|Hash| B1
         
         B0 -->|Hash| C0
         B1 -->|Hash| C0
     end
 
     subgraph "Ethereum"
         StateRoot["State Root"]
         TxRoot["Transaction Root"]
         ReceiptRoot["Receipt Root"]
     end
 
     C0 -->|Stored in| TxRoot
     TxRoot -->|Verification| EthereumApp["Smart Contract or App"]
     EthereumApp -->|Prove Validity| Verifier
 
 ```
 
 参考：
 - 動画: https://www.youtube.com/watch?v=3giNelTfeAk
 - 解説: https://academy.binance.com/en/articles/merkle-trees-and-merkle-roots-explained
 - 効率的メルクル木: https://kndrck.co/posts/efficient-merkletrees-zk-proofs/
 - Solidity 実装ガイド: https://soliditydeveloper.com/merkle-tree
 
 :::info
 🤔 考えてみよう
 1. メルクル木の構造を説明してください。
 2. ブロックチェーンでの利用方法は？
 3. なぜ効率的・安全に大規模検証できるのか？
 :::
 
 ### デジタル署名（Schnorr）
 
 デジタル署名は真正性・完全性を保証します。公開鍵暗号では公開鍵で暗号化・秘密鍵で復号、署名では秘密鍵で署名・公開鍵で検証します。
 
 （以降の DLP / Diffie–Hellman / ElGamal / コミットメント / ECC / BLS / ペアリング などは原文リンクに沿って学習してください）
 
 # 💪 演習
 
 1. 対称鍵と非対称鍵の違いとユースケース
 2. Diffie–Hellman がメッセージングの安全性をどう高めるか
 3. SHA-256 と Poseidon の特徴、Poseidon の利点
 4. メルクル木が大規模データ検証を効率化する理由
 5. Pedersen コミットメントでトランザクションのプライバシーを保つ方法
 6. 署名付き文書の真正性検証方法
 
