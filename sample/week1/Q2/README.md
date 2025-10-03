# zku-c3-week1-q2

Install the required node modules by running:
```shell
npm install
```

Try running some of the following tasks:

```shell
. scripts/compile-HelloWorld.sh
node scripts/bump-solidity.js && npx hardhat test
```

## 公開鍵関連の回路

### 1. SimplePublicKeyProof.circom
最もシンプルな実装。理解しやすく、テストしやすい設計です。

- **仕組み**: 秘密鍵の二乗を「公開鍵」として使用
- **特徴**: 数学的にシンプル、教育目的に最適
- **用途**: 概念の理解、プロトタイピング

### 2. PublicKeyProof.circom
より現実的な実装。EdDSAやMiMCハッシュを使用します。

- **仕組み**: EdDSA公開鍵導出またはMiMCハッシュベース
- **特徴**: 実際の暗号プリミティブを使用
- **用途**: 実用的なアプリケーション

### 3. EllipticCurvePublicKeyProof.circom
楕円曲線暗号を使用した最も現実的な実装。

- **仕組み**: Baby Jubjub楕円曲線でのスカラー乗算
- **特徴**: 実際のECDSAに近い実装
- **用途**: 本格的なアプリケーション