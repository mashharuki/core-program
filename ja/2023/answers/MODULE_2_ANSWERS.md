### 記述問題

1. 対称鍵 vs 非対称鍵：
   - 対称鍵暗号：暗号化・復号に同一鍵。高速・単純だが鍵配送が課題。
     - 例：信頼できるチャネル内でのデータ送信（WiFi の暗号化など）。
   - 非対称鍵暗号：公開鍵で暗号化、秘密鍵で復号。鍵共有は容易だが計算コストが高い。
     - 例：PGP メール。受信者の公開鍵で暗号化し、受信者だけが復号。

2. 公開鍵暗号と鍵合意：
   - Diffie–Hellman は安全でないネットワーク上で共有秘密を合意できる。実運用ではメッセージングのエンドツーエンド暗号化の基盤となる。

3. ハッシュ関数：
   - SHA-256 は衝突・原像攻撃への耐性と速度のバランスが良い。Poseidon は回路に親和的な設計で ZKP に適する。

4. メルクル木：
   - 葉〜根の経路ハッシュのみで包含検証ができるため、大規模データでも効率的に検証可能。ブロックチェーンのトランザクション検証に使われる。

5. コミットメント：
   - Pedersen は値を隠しつつ後で開示可能（ハイディング＆バインディング）。機密送金で金額を伏せる用途など。

6. デジタル署名：
   - 署名者の公開鍵で検証する。検証成功は「対応する秘密鍵所持者が署名し、メッセージが改ざんされていない」ことを示す。

### プログラミング課題

#### 課題1：公開鍵暗号と署名

```javascript
const crypto = require('crypto');

const { publicKey, privateKey } = crypto.generateKeyPairSync('rsa', { modulusLength: 2048 });

// 暗号化（公開鍵）
const plaintext = 'This is a secret message.';
const encrypted = crypto.publicEncrypt(publicKey, Buffer.from(plaintext));

// 復号（秘密鍵）
const decrypted = crypto.privateDecrypt(privateKey, encrypted);
console.log('Decrypted message:', decrypted.toString());

// 署名
const sign = crypto.createSign('SHA256');
sign.update(plaintext);
sign.end();
const signature = sign.sign(privateKey);

// 検証
const verify = crypto.createVerify('SHA256');
verify.update(plaintext);
verify.end();
console.log('Signature valid:', verify.verify(publicKey, signature));
```

#### 課題2：SHA-256 と Poseidon

```javascript
const crypto = require("crypto");
const poseidon = require("poseidon-encryption");

// SHA-256
const data = "This is some data X.";
const hash = crypto.createHash("sha256");
hash.update(data);
const sha256Hash = hash.digest("hex");
console.log("SHA-256 Hash:", sha256Hash);

// Poseidon（整数配列入力）
const inputs = [1, 2, 3, 4, 5];
const poseidonHash = poseidon.poseidon(inputs);
console.log("Poseidon Hash:", poseidonHash.toString());
```

#### 課題3：メルクル木

```javascript
const MerkleTree = require('merkletreejs');
const crypto = require('crypto');

function hashFunction(data) {
  const hash = crypto.createHash('sha256');
  hash.update(data);
  return hash.digest();
}

const leaves = ['a', 'b', 'c', 'd'].map(x => hashFunction(x));
const tree = new MerkleTree.MerkleTree(leaves, hashFunction);
const root = tree.getRoot().toString('hex');
console.log('Merkle Root:', root);

const leaf = hashFunction('b');
const proof = tree.getProof(leaf);
console.log('Proof valid:', tree.verify(proof, leaf, tree.getRoot()));
```

#### 課題4：Pedersen コミットメント

```javascript
class PedersenCommitment {
  constructor() {
    this.p = BigInt(23);
    this.g = BigInt(4);
    this.h = null;
    this.r = null;
    this.s = null;
  }

  generateH() {
    this.r = BigInt(Math.floor(Math.random() * 10 + 1));
    this.h = this.g ** this.r % this.p;
  }

  generateCommitment(s) {
    this.s = BigInt(s);
    return (this.g ** BigInt(s) * this.h ** this.r) % this.p;
  }

  reveal() {
    return { s: this.s, r: this.r };
  }

  verify(s, r, C) {
    return C === (this.g ** BigInt(s) * this.h ** BigInt(r)) % this.p;
  }
}

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

