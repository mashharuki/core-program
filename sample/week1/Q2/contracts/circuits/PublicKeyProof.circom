pragma circom 2.1.4;

include "../../node_modules/circomlib/circuits/mimc.circom";
include "../../node_modules/circomlib/circuits/eddsa.circom";
include "../../node_modules/circomlib/circuits/escalarmulfix.circom";
include "../../node_modules/circomlib/circuits/comparators.circom"; // comparators.circomをインポート

/**
 * PublicKeyProof Circuit
 */
template PublicKeyProof() {
    // プライベート入力：秘密鍵（証明者のみが知っている）
    signal input privateKey;
    
    // パブリック入力：検証したい公開鍵のx, y座標
    signal input publicKeyX;
    signal input publicKeyY;
    
    // 出力：証明が成功したかどうか（1 = 成功, 0 = 失敗）
    signal output valid;
    
    // Baby Jubjub曲線のベースポイント
    // escalarmulfix.circomで定義されている定数を使用
    // 古いバージョンでは手動で指定する必要があった
    // 最新版では内部で処理されるため、明示的な定義は不要な場合があるが、ここでは安全のために指定
    // 定数として定義し、テンプレートに渡す
    var BABY_JUBJUB_BASE_X = 5299619240641551281634865583518297030282874472190772894086521144482721001553;
    var BABY_JUBJUB_BASE_Y = 16950150798460657717958625567821834550301663161624707787222815936182638968203;
    var BASE_POINT[2] = [BABY_JUBJUB_BASE_X, BABY_JUBJUB_BASE_Y];

    // EscalarMulFixを使用してスカラー倍算を実行
    // n=255は秘密鍵のビット長（EdDSA）を想定
    component scalar_mul = EscalarMulFix(255, BASE_POINT);
    
    // 秘密鍵をビットに分解して入力
    component privateKeyBits = Num2Bits(255);
    privateKeyBits.in <== privateKey;

    for (var i = 0; i < 255; i++) {
        scalar_mul.e[i] <== privateKeyBits.out[i];
    }
    
    // 計算された公開鍵と入力された公開鍵を比較
    component xEqual = IsEqual();
    component yEqual = IsEqual();
    
    xEqual.in[0] <== scalar_mul.out[0];
    xEqual.in[1] <== publicKeyX;
    
    yEqual.in[0] <== scalar_mul.out[1];
    yEqual.in[1] <== publicKeyY;
    
    // 両方の座標が一致する場合のみvalid = 1
    valid <== xEqual.out * yEqual.out;
    
    // 秘密鍵が0でないことを確認（セキュリティ要件）
    component nonZero = IsZero();
    nonZero.in <== privateKey;
    nonZero.out === 0; // privateKeyが0でないことを制約
}

// メインコンポーネントの定義
component main = PublicKeyProof();
