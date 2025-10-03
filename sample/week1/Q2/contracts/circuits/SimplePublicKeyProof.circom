pragma circom 2.1.4;

/**
 * SimpleHashBasedPublicKeyProof Circuit
 * 
 * ハッシュ関数を使用したシンプルな公開鍵証明回路。
 * 理解しやすく、実際にテストしやすい実装。
 * 
 * 仕組み：
 * 1. 秘密鍵をハッシュ化して「公開鍵」とする
 * 2. 証明者は秘密鍵を知っていることを、再計算して証明する
 * 3. 実際の楕円曲線暗号よりもシンプルだが、概念は同じ
 */
template SimpleHashBasedPublicKeyProof() {
    // プライベート入力：秘密鍵
    signal input privateKey;
    
    // パブリック入力：検証したい公開鍵（ハッシュ値）
    signal input expectedPublicKey;
    
    // 出力：証明が有効かどうか
    signal output isValid;
    
    // 秘密鍵の二乗を計算（簡単なハッシュ関数の代わり）
    // 実際のハッシュ関数の代わりに、理解しやすい演算を使用
    signal publicKeyComputed;
    publicKeyComputed <== privateKey * privateKey;
    
    // 計算された公開鍵と期待される公開鍵が一致するかチェック
    component equal = IsEqual();
    equal.in[0] <== publicKeyComputed;
    equal.in[1] <== expectedPublicKey;
    
    isValid <== equal.out;
    
    // 秘密鍵が0でないことを確認（セキュリティ要件）
    component privateKeyNonZero = IsZero();
    privateKeyNonZero.in <== privateKey;
    
    // 秘密鍵が0の場合、証明は無効
    component notZero = NOT();
    notZero.in <== privateKeyNonZero.out;
    
    // セキュリティ制約：秘密鍵は0であってはならない
    notZero.out === 1;
}

/**
 * PoseidonBasedPublicKeyProof Circuit
 * 
 * Poseidonハッシュを使用したより安全な公開鍵証明回路。
 * Poseidonはゼロ知識回路に最適化されたハッシュ関数。
 */
template PoseidonBasedPublicKeyProof() {
    // プライベート入力：秘密鍵
    signal input privateKey;
    
    // パブリック入力：期待される公開鍵（Poseidonハッシュ）
    signal input expectedPublicKey;
    
    // 出力：証明の有効性
    signal output isValid;
    
    // Poseidonハッシュを計算（1入力版）
    component hasher = Poseidon(1);
    hasher.inputs[0] <== privateKey;
    
    // 計算されたハッシュと期待される公開鍵を比較
    component equal = IsEqual();
    equal.in[0] <== hasher.out;
    equal.in[1] <== expectedPublicKey;
    
    isValid <== equal.out;
    
    // 秘密鍵の有効性チェック
    component privateKeyCheck = IsZero();
    privateKeyCheck.in <== privateKey;
    component validPrivateKey = NOT();
    validPrivateKey.in <== privateKeyCheck.out;
    validPrivateKey.out === 1;
}

/**
 * MultiFactorPublicKeyProof Circuit
 * 
 * 複数の要素を組み合わせた公開鍵証明。
 * より複雑だが現実的なケース。
 */
template MultiFactorPublicKeyProof() {
    // プライベート入力
    signal input privateKey;
    signal input salt; // ソルト値
    
    // パブリック入力
    signal input expectedPublicKey;
    
    // 出力
    signal output isValid;
    
    // 秘密鍵とソルトを組み合わせてハッシュ化
    component hasher = Poseidon(2);
    hasher.inputs[0] <== privateKey;
    hasher.inputs[1] <== salt;
    
    // 結果を比較
    component equal = IsEqual();
    equal.in[0] <== hasher.out;
    equal.in[1] <== expectedPublicKey;
    
    isValid <== equal.out;
    
    // 入力値の有効性チェック
    component privateKeyCheck = IsZero();
    privateKeyCheck.in <== privateKey;
    component privateKeyValid = NOT();
    privateKeyValid.in <== privateKeyCheck.out;
    privateKeyValid.out === 1;
    
    component saltCheck = IsZero();
    saltCheck.in <== salt;
    component saltValid = NOT();
    saltValid.in <== saltCheck.out;
    saltValid.out === 1;
}

// ヘルパー回路定義
template IsEqual() {
    signal input in[2];
    signal output out;
    
    component isz = IsZero();
    isz.in <== in[1] - in[0];
    out <== isz.out;
}

template IsZero() {
    signal input in;
    signal output out;
    
    signal inv;
    inv <-- in != 0 ? 1 / in : 0;
    out <== -in * inv + 1;
    in * out === 0;
}

template NOT() {
    signal input in;
    signal output out;
    
    out <== 1 - in;
}

// 簡易Poseidonハッシュ実装（実際の実装では circomlib を使用）
template Poseidon(n) {
    signal input inputs[n];
    signal output out;
    
    // 簡易版：入力値の合計の二乗を計算
    // 実際のPoseidonはより複雑な置換関数を使用
    var sum = 0;
    for (var i = 0; i < n; i++) {
        sum += inputs[i];
    }
    out <== sum * sum + sum + 1; // 簡単な非線形変換
}

// メインコンポーネント（最もシンプルなバージョンを使用）
component main = SimpleHashBasedPublicKeyProof();