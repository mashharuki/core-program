# モジュール6 回答例

### 2.1 Trusted Setup

1. `HelloWorld.circom` の回路は？
   - 2つの入力の積を出力する単純な回路。
2. Phase 1（Powers of Tau）とは？
   - 複数者がランダム性を寄与し共通参照文字列（CRS）の基盤を生成する MPC セレモニー。中間値（toxic waste）を適切に破棄することが安全性の鍵。
3. Phase 1 と Phase 2 の違いは？
   - Phase 1 は汎用（ユニバーサル）、Phase 2 は回路固有（サーキット・スペシフィック）。

### 2.2 非二次制約

1. `compile-Multiplier3-groth16.sh` の作成：Multiplier3 をコンパイルし Verifier を生成するスクリプトを作る。
2. `error[T3001]` の意味：
   - Circom の制約は二次まで。3項積を一度に置くと非二次制約になりエラー。中間信号で2回に分ける必要がある。
3. 3入力乗算の修正例：

```circom
pragma circom 2.0.0;

template Multiplier3 () {
   signal input a;
   signal input b;
   signal input c;
   signal temp;
   signal output d;

   temp <== a * b;
   d <== temp * c;
}

component main = Multiplier3();
```

### 2.3 Groth16 と PLONK

1. 手順の違い：
   - PLONK は Phase 2 の（回路固有）寄与が不要。構築フローや zkey 形式が Groth16 と異なる。
2. 実用上の違い：
   - 一般に PLONK は検証コスト・コントラクトサイズが大きめ、Groth16 は証明が短く検証も速い（トレードオフ）。

### 2.4 検証とテスト

- `bump-solidity.js` で各 Verifier の Solidity バージョンを 0.8 系へ置換。
- `HelloWorld` / `Multiplier3 (Groth16)` / `Multiplier3 (PLONK)` のテストを作成し、正当な証明で true、無効な入力で false となることを確認。

### 2.5 回路ライブラリ（抜粋）

- RangeProof：`GreaterEqThan` と `LessEqThan` を用い、下限以上かつ上限以下を満たすとき 1 を出力。
- Sudoku：各マスが 0〜9 に入ることを RangeProof で確認。行・列・ブロックの和や二乗和の検査で解の整合性をチェック。Poseidon を用いてパズルのハッシュを出力。

