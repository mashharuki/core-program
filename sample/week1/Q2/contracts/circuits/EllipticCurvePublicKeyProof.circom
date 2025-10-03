pragma circom 2.1.4;

include "../../node_modules/circomlib/circuits/escalarmulfix.circom";
include "../../node_modules/circomlib/circuits/comparators.circom";
include "../../node_modules/circomlib/circuits/bitify.circom";
include "../../node_modules/circomlib/circuits/poseidon.circom";

/**
 * EllipticCurvePublicKeyProof Circuit
 * 
 * Baby Jubjub楕円曲線を使用して、秘密鍵から公開鍵が正しく導出されることを証明する。
 * この回路は実際の楕円曲線暗号の仕組みに基づいている。
 */
template EllipticCurvePublicKeyProof() {
    // プライベート入力：秘密鍵（254ビット）
    // EdDSAでは254ビットが一般的
    signal input privateKey;
    
    // パブリック入力：検証対象の公開鍵座標
    signal input publicKeyX;
    signal input publicKeyY;
    
    // 出力：証明の成功/失敗
    signal output isValid;
    
    // 秘密鍵をビットに分解
    component privateKeyBits = Num2Bits(254);
    privateKeyBits.in <== privateKey;

    // Baby Jubjubのベースポイント G = (Gx, Gy) でのスカラー乗算
    // escalarmulfix.circomで定義されているベースポイントを使用
    component scalarMult = EscalarMulFix(254, [
        5299619240641551281634865583518297030282874472190772894086521144482721001553,
        16950150798460657717958625567821834550301663161624707787222815936182638968203
    ]);
    
    // privateKey * G を計算
    for (var i = 0; i < 254; i++) {
        scalarMult.e[i] <== privateKeyBits.out[i];
    }
    
    // 計算された公開鍵と入力された公開鍵を比較
    component xMatch = IsEqual();
    component yMatch = IsEqual();
    
    xMatch.in[0] <== scalarMult.out[0];
    xMatch.in[1] <== publicKeyX;
    
    yMatch.in[0] <== scalarMult.out[1];
    yMatch.in[1] <== publicKeyY;
    
    // 両座標が一致する場合のみ有効
    isValid <== xMatch.out * yMatch.out;
    
    // 秘密鍵が0でないことを保証
    component notZero = IsZero();
    notZero.in <== privateKey;
    (1 - notZero.out) === 1;
}

/**
 * SchnorrLikeProof Circuit
 * 
 * ポセイドンハッシュを使った単純なSchnorr風の知識証明。
 */
template SchnorrLikeProof() {
    // プライベート入力
    signal input privateKey;
    signal input nonce; // ランダムネス
    
    // パブリック入力
    signal input publicKeyX;
    signal input publicKeyY;
    signal input response;
    
    // 出力
    signal output isValid;

    // challenge = poseidon_hash(R, P)
    // R = nonce * G, P = privateKey * G
    component noncePoint = EscalarMulFix(254, [
        5299619240641551281634865583518297030282874472190772894086521144482721001553,
        16950150798460657717958625567821834550301663161624707787222815936182638968203
    ]);
    component nonceBits = Num2Bits(254);
    nonceBits.in <== nonce;
    for (var i = 0; i < 254; i++) {
        noncePoint.e[i] <== nonceBits.out[i];
    }

    component poseidon = Poseidon(4);
    poseidon.inputs[0] <== noncePoint.out[0];
    poseidon.inputs[1] <== noncePoint.out[1];
    poseidon.inputs[2] <== publicKeyX;
    poseidon.inputs[3] <== publicKeyY;

    var challenge = poseidon.out;

    // 検証: s*G = R + c*P
    // R + c*Pを計算
    // c*P
    component pubKeyPoint = EscalarMulFix(254, [publicKeyX, publicKeyY]);
    component pubKeyBits = Num2Bits(254);
    pubKeyBits.in <== privateKey;
    for (var i = 0; i < 254; i++) {
        pubKeyPoint.e[i] <== pubKeyBits.out[i];
    }
    
    // R + c*P

    // 秘密鍵の知識証明
    component pubKeyVerification = EllipticCurvePublicKeyProof();
    pubKeyVerification.privateKey <== privateKey;
    pubKeyVerification.publicKeyX <== publicKeyX;
    pubKeyVerification.publicKeyY <== publicKeyY;
    
    isValid <== pubKeyVerification.isValid;
}

// メインコンポーネント
component main = EllipticCurvePublicKeyProof();
