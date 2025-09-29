# モジュール6 - 回路入門（Circom）

モジュール4で学んだ通り、ZK 証明を作る最初のステップの一つは「問題を回路に変換する」ことです。

回路記述には主に Circom と Halo2 があります。

本モジュールでは学習資源が多い Circom にフォーカスし、基本的な回路を自分で書けるようになることを目標にします。

## 1. Circom を始める

Circom 2 の公式ドキュメントから、以下のページを読み動作させてください：

1. インストール（Circom / SnarkJS）: https://docs.circom.io/getting-started/installation/
2. 回路の書き方: https://docs.circom.io/getting-started/writing-circuits/
3. コンパイル（Apple Silicon 注意点あり）: https://docs.circom.io/getting-started/compiling-circuits/
4. Witness の計算: https://docs.circom.io/getting-started/computing-the-witness/
5. 証明の生成: https://docs.circom.io/getting-started/proving-circuits/

参考：
- https://github.com/enricobottazzi/ZKverse
- https://www.samsclass.info/141/proj/C523.htm

## 2. Circom 速習 💪

ここからは手を動かしつつ学びます。

以下は ZK University（ZKU）の演習を元にした内容です（元の課題: https://zku.gnomio.com/mod/assign/view.php?id=117）。

1. リポジトリを fork/clone: https://github.com/adrianmcli/week1
2. `Q2` ディレクトリで `npm install`

### 2.1 Trusted Setup

`contracts/circuits/HelloWorld.circom` を `scripts/compile-HelloWorld.sh` でコンパイルし、次に答えてください：

1. `HelloWorld.circom` の回路は何をしますか？
2. `powersOfTau28_hez_final_10.ptau` は Phase 1 用のファイルです。Powers of Tau とは？なぜ必要？
3. スクリプトの乱数寄与は Phase 2 のものです。Phase 1 と Phase 2 の違いは？

### 2.2 非二次制約（Non-Quadratic Constraints）

Circom には重要な制約があり、素直に3項積を一発で書くと `error[T3001]` に遭遇します：

1. 空の `scripts/compile-Multiplier3-groth16.sh` に、`Multiplier3.circom` をコンパイルし Verifier を生成するスクリプトを作る。
2. 実行して `error[T3001]` の意味を説明する。
3. 中間信号を用意して、2項ずつ掛ける形に回路を修正する。

### 2.3 Groth16 と PLONK

空の `scripts/compile-Multiplier3-plonk.sh` に、PLONK でコンパイルするスクリプトを作る（生成物には `_plonk` サフィックス）。

1. `snarkjs plonk setup` に変えるだけでは `zkey file is not groth16` となる。両者の手順の違いを説明する。
2. 実用面での違い（コントラクトサイズ、検証コスト、テスト実行時間など）を比較する。

### 2.4 検証とテスト

`snarkjs groth16 fullprove` で端末から検証できますが、Node.js からも可能です。Hardhat のテストを書いて Verifier を試しましょう：

1. `npx hardhat test` は最初 `HH606` で失敗します。`scripts/bump-solidity.js` を拡張し、追加した Verifier の Solidity バージョンも置換してください。
2. `npm run test` で `HelloWorldVerifier` のテストを動かし、`test/test.js` の各行にコメントで説明を入れる。
3. `Multiplier3`（Groth16 / PLONK）のテストを追加し、すべてパスさせる。

### 2.5 回路ライブラリ

この節では Circomlib などのライブラリを使って、より複雑な回路を作ります。素早い試行には [zkREPL](https://zkrepl.dev/) が便利です。

#### 2.5.1 比較器を用いた RangeProof

```
pragma circom 2.1.4;

include "circomlib/comparators.circom";

template RangeProof(n) {
    assert(n <= 252);
    signal input in;      // 範囲内であることを証明したい値
    signal input range[2]; // [下限, 上限]
    signal output out;

    component lt = LessEqThan(n);
    component gt = GreaterEqThan(n);

    // [assignment] 実装を記述
}

component main { public [ range ] } = RangeProof(32);

/* INPUT = {
    "in": "5",
    "range": ["1", "10"]
} */
```

#### 2.5.2 circomlib-matrix と数独

行列演算の Circom ライブラリ（circomlib-matrix）を使って、数独の検証回路を作ります。上の RangeProof を使い、入力が 0〜9 に入ることをチェックするよう改変してください。

サンプルコード（gist）: https://gist.github.com/adrianmcli/776d86438592c0486603f04ac6cee26e

コードは zkREPL で貼り付けて試せます。頑張ってください！

## 参考

時間に余裕があれば、PSE の Vivian Plasencia による以下のチュートリアルを強く推奨します：

👉 Zero Knowledge DApp を作る（ゼロから本番まで）: https://vivianblog.hashnode.dev/how-to-create-a-zero-knowledge-dapp-from-zero-to-production

回路の作成から、Verifier コントラクトの生成、フロントエンドの構築まで一通り体験できます。

## まとめ

本モジュールは、プログラムの第1段階の締めくくりです。以後は回路実装の経験を積み、最終的にオープンソースへ貢献していきます。

