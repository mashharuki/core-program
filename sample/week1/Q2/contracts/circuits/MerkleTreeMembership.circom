pragma circom 2.0.0;

include "../../node_modules/circomlib/circuits/poseidon.circom";
include "../../node_modules/circomlib/circuits/mimcsponge.circom";

// ============================================
// Poseidonを使用したマークルツリーメンバーシップ証明
// ============================================

template MerkleTreeMembershipPoseidon(depth) {
    // ============ 入力信号 ============
    
    // プライベート入力: 証明したいリーフ（メンバーのID等）
    signal input leaf;
    
    // プライベート入力: マークルパス（兄弟ノードのハッシュ値）
    signal input pathElements[depth];
    
    // プライベート入力: パスの方向（0=左、1=右）
    signal input pathIndices[depth];
    
    // パブリック入力: マークルルート（検証者が知っている正しいルート）
    signal input root;
    
    // ============ 内部信号（forループの外で宣言） ============
    
    // 各レベルでの計算されたハッシュ値を保持
    signal computedHash[depth + 1];
    
    // 各レベルでのハッシュ計算用コンポーネント配列
    component hashers[depth];
    
    // 条件分岐用の中間信号（二次制約を満たすために分解）
    signal leftInput[depth];
    signal rightInput[depth];
    
    // 中間計算用の信号（非二次制約を避けるため）
    signal leftPart1[depth];   // (1 - pathIndices[i]) * computedHash[i]
    signal leftPart2[depth];   // pathIndices[i] * pathElements[i]
    signal rightPart1[depth];  // pathIndices[i] * computedHash[i]
    signal rightPart2[depth];  // (1 - pathIndices[i]) * pathElements[i]
    
    // ============ 検証ロジック ============
    
    // 最初のハッシュはリーフそのもの
    computedHash[0] <== leaf;
    
    // ツリーを下から上へ辿る
    for (var i = 0; i < depth; i++) {
        // pathIndices[i]が0か1であることを制約（0=左、1=右）
        pathIndices[i] * (1 - pathIndices[i]) === 0;
        
        // 左側の値を計算（二次制約に分解）
        // leftInput = (1 - pathIndices[i]) * computedHash[i] + pathIndices[i] * pathElements[i]
        leftPart1[i] <== (1 - pathIndices[i]) * computedHash[i];
        leftPart2[i] <== pathIndices[i] * pathElements[i];
        leftInput[i] <== leftPart1[i] + leftPart2[i];
        
        // 右側の値を計算（二次制約に分解）
        // rightInput = pathIndices[i] * computedHash[i] + (1 - pathIndices[i]) * pathElements[i]
        rightPart1[i] <== pathIndices[i] * computedHash[i];
        rightPart2[i] <== (1 - pathIndices[i]) * pathElements[i];
        rightInput[i] <== rightPart1[i] + rightPart2[i];
        
        // Poseidonハッシュ関数コンポーネント（2入力）
        hashers[i] = Poseidon(2);
        hashers[i].inputs[0] <== leftInput[i];
        hashers[i].inputs[1] <== rightInput[i];
        
        // 次のレベルのハッシュとして保存
        computedHash[i + 1] <== hashers[i].out;
    }
    
    // ============ 最終検証 ============
    
    // 計算されたルートが、パブリックな正しいルートと一致することを確認
    // この制約が満たされれば、leafがツリーのメンバーであることが証明される
    root === computedHash[depth];
}


// ============================================
// MiMCを使用したマークルツリーメンバーシップ証明
// ============================================

template MerkleTreeMembershipMiMC(depth) {
    // ============ 入力信号 ============
    
    // プライベート入力: 証明したいリーフ（メンバーのID等）
    signal input leaf;
    
    // プライベート入力: マークルパス（兄弟ノードのハッシュ値）
    signal input pathElements[depth];
    
    // プライベート入力: パスの方向（0=左、1=右）
    signal input pathIndices[depth];
    
    // パブリック入力: マークルルート（検証者が知っている正しいルート）
    signal input root;
    
    // ============ 内部信号（forループの外で宣言） ============
    
    // 各レベルでの計算されたハッシュ値を保持
    signal computedHash[depth + 1];
    
    // 各レベルでのハッシュ計算用コンポーネント配列
    component hashers[depth];
    
    // 条件分岐用の中間信号（二次制約を満たすために分解）
    signal leftInput[depth];
    signal rightInput[depth];
    
    // 中間計算用の信号（非二次制約を避けるため）
    signal leftPart1[depth];   // (1 - pathIndices[i]) * computedHash[i]
    signal leftPart2[depth];   // pathIndices[i] * pathElements[i]
    signal rightPart1[depth];  // pathIndices[i] * computedHash[i]
    signal rightPart2[depth];  // (1 - pathIndices[i]) * pathElements[i]
    
    // ============ 検証ロジック ============
    
    // 最初のハッシュはリーフそのもの
    computedHash[0] <== leaf;
    
    // ツリーを下から上へ辿る
    for (var i = 0; i < depth; i++) {
        // pathIndices[i]が0か1であることを制約（0=左、1=右）
        pathIndices[i] * (1 - pathIndices[i]) === 0;
        
        // 左側の値を計算（二次制約に分解）
        // leftInput = (1 - pathIndices[i]) * computedHash[i] + pathIndices[i] * pathElements[i]
        leftPart1[i] <== (1 - pathIndices[i]) * computedHash[i];
        leftPart2[i] <== pathIndices[i] * pathElements[i];
        leftInput[i] <== leftPart1[i] + leftPart2[i];
        
        // 右側の値を計算（二次制約に分解）
        // rightInput = pathIndices[i] * computedHash[i] + (1 - pathIndices[i]) * pathElements[i]
        rightPart1[i] <== pathIndices[i] * computedHash[i];
        rightPart2[i] <== (1 - pathIndices[i]) * pathElements[i];
        rightInput[i] <== rightPart1[i] + rightPart2[i];
        
        // MiMCSpongeハッシュ関数コンポーネント
        // nInputs=2: 2つの入力をハッシュ化
        // nRounds=220: ラウンド数
        // nOutputs=1: 1つのハッシュ値を出力
        hashers[i] = MiMCSponge(2, 220, 1);
        hashers[i].k <== 0;  // k値（鍵）は0に設定
        hashers[i].ins[0] <== leftInput[i];
        hashers[i].ins[1] <== rightInput[i];
        
        // 次のレベルのハッシュとして保存
        computedHash[i + 1] <== hashers[i].outs[0];
    }
    
    // ============ 最終検証 ============
    
    // 計算されたルートが、パブリックな正しいルートと一致することを確認
    // この制約が満たされれば、leafがツリーのメンバーであることが証明される
    root === computedHash[depth];
}


// ============ メインコンポーネント ============
// Poseidon版（推奨: より効率的で広く使われている）
component main {public [root]} = MerkleTreeMembershipPoseidon(4);

// MiMC版を使いたい場合は、上記をコメントアウトして以下を使用
// component main {public [root]} = MerkleTreeMembershipMiMC(4);