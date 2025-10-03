pragma circom 2.1.6;

include "../../node_modules/circomlib/circuits/poseidon.circom";

// ハッシュのプレイメージを知っていることを証明する回路
// 証明者は秘密の値（preimage）を知っており、
// その値をPoseidonハッシュした結果が公開されたハッシュ値と一致することを証明する
template PreimageProof() {
    // プライベート入力: ハッシュの元となる秘密の値
    signal input preimage;
    // パブリック入力: 期待されるハッシュ値
    signal input expectedHash;
    // 出力: 計算されたハッシュ値（検証用）
    signal output computedHash;
    
    // Poseidonハッシュコンポーネントのインスタンス化
    // 1つの入力値をハッシュする
    component hasher = Poseidon(1);
    // プレイメージをハッシュ関数に入力
    hasher.inputs[0] <== preimage;
    // 計算されたハッシュ値を出力に接続
    computedHash <== hasher.out;
    
    // 制約: 計算されたハッシュ値が期待されるハッシュ値と一致することを確認
    expectedHash === computedHash;
}

// メイン回路として設定
component main = PreimageProof();