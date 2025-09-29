# モジュール2 - 暗号プリミティブ：暗号化・ハッシュ関数ほか

モジュール2へようこそ！本モジュールでは、暗号化・ハッシュ関数・その他の暗号基盤技術を学びます。

これらの基本ブロックを理解することで、ブロックチェーン等の実装における応用が見えてきます。

# 詳細な自習ガイド

以下のトピックを自分で調査し、理解を深めてください。

各セクション末の問いに自信を持って答えられるようにしましょう。

難しい点は Discord で質問しても構いません。

## 共通鍵暗号 vs 公開鍵暗号

暗号化は、正しい鍵を持つ者のみが読めるようにデータを変換する技術です。大別して2種類あります。

**共通鍵暗号（対称鍵）**：暗号化・復号に同じ鍵を使います。  
代表例は AES（Advanced Encryption Standard）。

**公開鍵暗号（非対称鍵）**：暗号化鍵と復号鍵が対になっています。  
代表例は RSA。

違いは「鍵の数」です。対称鍵は1本、非対称鍵は2本（公開鍵・秘密鍵）。参考資料：
- Symmetric vs. Asymmetric Encryption – differences: https://www.ssl2buy.com/wiki/symmetric-vs-asymmetric-encryption-what-are-differences
- AES Explained（Computerphile）[14:13]: https://www.youtube.com/watch?v=O4xNJsjtN6E
- Prime Numbers & RSA（Computerphile）[15:06]: https://www.youtube.com/watch?v=JD72Ry60eP4
- What Is AES Encryption: https://www.simplilearn.com/tutorials/cryptography-tutorial/aes-encryption
- What is RSA encryption: https://www.comparitech.com/blog/information-security/rsa-encryption/

:::info
🤔 考えてみよう
1. 対称鍵と非対称鍵の主な違いは？
2. AES はどのように動作しますか（概要）？
3. なぜ RSA は公開鍵暗号で広く使われているのでしょう？
:::

## DLP（離散対数問題）に基づく公開鍵暗号

RSA は「素因数分解の困難性」に基づきますが、もう一つの系譜として「離散対数問題（DLP）」に基づく公開鍵暗号があります。

1. **離散対数問題（DLP）**：多くのプロトコルの基盤です。
   - Khan Academy: https://youtu.be/SL7J8hPKEWY
   - 解説記事: https://www.di-mgt.com.au/public-key-crypto-discrete-logs-0.html

2. **Diffie–Hellman 鍵共有**：DLP に基づく古典的プロトコル。安全でないチャネル上でも共有鍵を合意できます。
   - Computerphile（概要）[8:39]: https://www.youtube.com/watch?v=NmM9HA2MQGI
   - Mathematics bit [7:04]: https://youtu.be/Yjrfm_oRO0w
   - 実装例: https://www.geeksforgeeks.org/implementation-diffie-hellman-algorithm/

3. **ElGamal 暗号**：DLP を用いる公開鍵暗号。
   - Intro [8:20]: https://www.youtube.com/watch?v=oQqr8d5s3Uk
   - Simple example [6:38]: https://www.youtube.com/watch?v=4xVCrTb_1II
   - 解説: https://www.geeksforgeeks.org/elgamal-encryption-algorithm/

:::info
🤔 考えてみよう
1. 離散対数問題（DLP）とは？
2. Diffie–Hellman はどう動作しますか？
3. ElGamal の要点は？
4. DLP 系の弱点（欠点）を1つ挙げてください。
:::

## ハッシュ関数

ハッシュ関数は入力から固定長の値を返します。ここでは **SHA-256** と **Poseidon** を重視します（Poseidon は回路に親和的）。

特性：第一原像困難性、第二原像困難性、衝突困難性。ブロックチェーンではデータ完全性やブロック識別に利用されます。

## メルクル木

大規模データの検証を効率化する二分木構造です。葉はデータのハッシュ、内部は子のハッシュから構成され、ルートハッシュで集合全体を要約します。

## クリプトグラフィック・コミットメント（Pedersen など）

コミット（隠す）→リビール（開示）という2段階の原則で、値を伏せつつ後で正しさを証明します。Pedersen は「秘匿性」と「束縛性」を両立します。

## デジタル署名（Schnorr・DSA）

公開鍵暗号では受信者の公開鍵で暗号化し秘密鍵で復号します。署名では、送信者が秘密鍵で署名し、誰でも公開鍵で検証できます。したがって署名のメッセージは公開されます。

入門：What are Digital Signatures?（Computerphile）[10:16]: https://www.youtube.com/watch?v=s22eJ1eVLTU

**Schnorr 署名**：シンプルで効率的。
- GfG: https://www.geeksforgeeks.org/schnorr-digital-signature/
- 動画 [4:58]: https://www.youtube.com/watch?v=mV9hXEFUB6A

**DSA**：インターネットセキュリティで重要な署名方式。
- 解説: https://www.simplilearn.com/tutorials/cryptography-tutorial/digital-signature-algorithm
- 動画 [5:46]: https://www.youtube.com/watch?v=iS1nK4G6EtA
- 詳細動画 [24:32]: https://www.youtube.com/watch?v=MtT3NBfpV5Q

:::info
🤔 考えてみよう
1. デジタル署名の役割と重要性は？
2. DSA の仕組みを説明してください。
:::

# 💪 演習

## 記述問題

1. 対称鍵 vs 非対称鍵の違いと、それぞれの実用例。
2. Diffie–Hellman を用いたメッセージングの安全性向上の仕組み。
3. SHA-256 と Poseidon の特徴と、Poseidon の利点を1つ。
4. メルクル木が大規模データ検証を効率化する理由。
5. Pedersen コミットメントがトランザクションのプライバシーを保つ方法。
6. デジタル署名付き文書の真正性確認の方法。

## プログラミング課題（Node.js）

必要パッケージ：

```bash
npm install merkletreejs poseidon-encryption ffjavascript
```

### 課題1：公開鍵暗号とデジタル署名

Node.js の `crypto` を使って、RSA鍵生成→暗号化→復号→署名→検証まで行ってください。

```javascript
const crypto = require('crypto');

const { publicKey, privateKey } = crypto.generateKeyPairSync('rsa', { modulusLength: 2048 });

// Encrypt（公開鍵で暗号化）
const plaintext = 'This is a secret message.';
// TODO: publicKey を使って暗号化

// Decrypt（秘密鍵で復号）
// TODO: privateKey を使って復号

// 署名
const sign = crypto.createSign('SHA256');
sign.update(plaintext);
sign.end();
// TODO: privateKey で署名

// 検証
const verify = crypto.createVerify('SHA256');
verify.update(plaintext);
verify.end();
// TODO: publicKey で署名検証
```

ヒント：`crypto` のドキュメントを参照: https://nodejs.org/api/crypto.html

### 課題2：SHA-256 と Poseidon のハッシュ

```javascript
const crypto = require("crypto");
const poseidon = require("poseidon-encryption");

// SHA-256
const data = "This is some data X.";
// TODO: SHA-256 ハッシュを計算して表示。入力を少し変えて差異を観察。

// Poseidon（整数配列を入力）
const inputs = [1, 2, 3, 4];
// TODO: Poseidon ハッシュを計算して表示
```

ヒント：`hash.digest('hex')` で可読な16進文字列に。`poseidon-encryption` はドキュメントが少ないため、ソースやテストを参考に。

### 課題3：シンプルなメルクル木

```javascript
const MerkleTree = require('merkletreejs');
const crypto = require('crypto');

function hashFunction(data) {
  const hash = crypto.createHash('sha256');
  hash.update(data);
  return hash.digest();
}

// 葉を作成
const leaves = ['a', 'b', 'c', 'd'].map(x => hashFunction(x));
// TODO: メルクル木を構築し、ルートを表示

// 証明の生成と検証
const leaf = hashFunction('b');
// TODO: leaf 'b' の包含証明を生成し、ルートに対して検証
```

ドキュメント: https://github.com/merkletreejs/merkletreejs

### 課題4：Pedersen コミットメントの実装

```javascript
class PedersenCommitment {
  constructor() {
    this.p = BigInt(23); // 実運用では大きな素数に
    this.g = BigInt(4);  // 実運用では大きな生成元に
    this.h = null;
    this.r = null;
    this.s = null;
  }

  // h = g^r mod p を生成
  generateH() {
    // TODO: r をランダム生成（this.r）し、h を計算（this.h）
  }

  // コミット C = g^s * h^r mod p
  generateCommitment(s) {
    // TODO: s を BigInt 化（this.s）し、C を返す
  }

  // 開示（s, r）
  reveal() {
    // TODO: s, r を返す
  }

  // 検証（再計算して一致を確認）
  verify(s, r, C) {
    // TODO: C と g^s * h^r mod p を比較
  }
}

// テスト
const pc = new PedersenCommitment();
pc.generateH();

let secretNumber = 7;
let commitment = pc.generateCommitment(secretNumber);
console.log("Commitment: ", commitment);

let reveal = pc.reveal();
console.log("Revealed: ", reveal);

let verification = pc.verify(reveal.s, reveal.r, commitment);
console.log("Verification: ", verification);
```

最終行が `Verification: true` になっていれば成功です。お疲れさまでした！

## まとめ

暗号化、ハッシュ、メルクル木、コミットメント、署名といった暗号プリミティブを俯瞰しました。これらはブロックチェーンや ZKP の基盤です。次は楕円曲線暗号へ進みます。

