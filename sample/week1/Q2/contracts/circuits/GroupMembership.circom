pragma circom 2.0.0;

include "../../node_modules/circomlib/circuits/poseidon.circom";
include "../../node_modules/circomlib/circuits/comparators.circom";

// ============================================
// グループ所属証明サーキット
// ============================================
// このサーキットは、ユーザーが特定のグループに所属していることを
// プライバシーを保ちながら証明します。
// 
// 使用例:
// - 匿名投票（有権者であることを証明するが、誰が投票したかは秘密）
// - アクセス制御（メンバーであることを証明するが、IDは明かさない）
// - 年齢確認（成人グループに属していることを証明）
// ============================================

template GroupMembership(depth) {
    // ============ 入力信号 ============
    
    // === プライベート入力（証明者のみが知っている情報） ===
    
    // ユーザーの秘密ID（誰であるかを特定する情報）
    signal input userSecret;
    
    // ユーザーの属性情報（例: 年齢、権限レベルなど）
    signal input userAttribute;
    
    // Merkleツリーのパス（ユーザーがツリーに含まれることを証明）
    signal input pathElements[depth];
    signal input pathIndices[depth];
    
    // === パブリック入力（検証者も知っている情報） ===
    
    // グループのMerkleルート（このグループのメンバーリスト）
    signal input root;
    
    // ヌリファイア用のユニークな識別子（二重使用防止用）
    // 例: 投票IDや、トランザクションIDなど
    signal input nullifierSeed;
    
    // === パブリック出力 ===
    
    // ヌリファイア: 同じユーザーが同じアクションを複数回行うことを防ぐ
    // nullifier = Hash(userSecret, nullifierSeed)
    signal output nullifier;
    
    // コミットメント: ユーザーの身元を隠しながら一貫性を保つ
    // commitment = Hash(userSecret, userAttribute)
    signal output commitment;
    
    // ============ 内部信号とコンポーネント ============
    
    // Merkleツリー検証用の信号
    signal computedHash[depth + 1];
    component hashers[depth];
    signal leftInput[depth];
    signal rightInput[depth];
    signal leftPart1[depth];
    signal leftPart2[depth];
    signal rightPart1[depth];
    signal rightPart2[depth];
    
    // リーフ値の計算用ハッシャー（userSecretとuserAttributeからリーフを生成）
    component leafHasher = Poseidon(2);
    
    // ヌリファイア計算用ハッシャー
    component nullifierHasher = Poseidon(2);
    
    // コミットメント計算用ハッシャー
    component commitmentHasher = Poseidon(2);
    
    // ============ ステップ1: リーフ値の計算 ============
    // ユーザーの秘密IDと属性から、Merkleツリーのリーフ値を計算
    // leaf = Hash(userSecret, userAttribute)
    
    leafHasher.inputs[0] <== userSecret;
    leafHasher.inputs[1] <== userAttribute;
    signal leaf;
    leaf <== leafHasher.out;
    
    // ============ ステップ2: Merkleツリーメンバーシップ証明 ============
    // リーフがMerkleツリーに含まれることを証明
    
    computedHash[0] <== leaf;
    
    for (var i = 0; i < depth; i++) {
        // pathIndices[i]は0または1のみ（左=0、右=1）
        pathIndices[i] * (1 - pathIndices[i]) === 0;
        
        // 左側の入力を計算
        // pathIndices[i] == 0なら computedHash[i]が左、pathElements[i]が右
        // pathIndices[i] == 1なら pathElements[i]が左、computedHash[i]が右
        leftPart1[i] <== (1 - pathIndices[i]) * computedHash[i];
        leftPart2[i] <== pathIndices[i] * pathElements[i];
        leftInput[i] <== leftPart1[i] + leftPart2[i];
        
        // 右側の入力を計算
        rightPart1[i] <== pathIndices[i] * computedHash[i];
        rightPart2[i] <== (1 - pathIndices[i]) * pathElements[i];
        rightInput[i] <== rightPart1[i] + rightPart2[i];
        
        // ハッシュを計算して次のレベルへ
        hashers[i] = Poseidon(2);
        hashers[i].inputs[0] <== leftInput[i];
        hashers[i].inputs[1] <== rightInput[i];
        computedHash[i + 1] <== hashers[i].out;
    }
    
    // 計算されたルートが公開ルートと一致することを検証
    root === computedHash[depth];
    
    // ============ ステップ3: ヌリファイアの生成 ============
    // 同じユーザーが同じアクション（nullifierSeed）を複数回実行することを防ぐ
    // nullifier = Hash(userSecret, nullifierSeed)
    // 
    // 例: 投票システムでは、同じ人が同じ投票に複数回投票できないようにする
    
    nullifierHasher.inputs[0] <== userSecret;
    nullifierHasher.inputs[1] <== nullifierSeed;
    // ハッシュ値を生成
    nullifier <== nullifierHasher.out;
    
    // ============ ステップ4: コミットメントの生成 ============
    // ユーザーのIDを明かさずに、一貫性を保つための値
    // commitment = Hash(userSecret, userAttribute)
    // 
    // これにより、検証者は同じユーザーが複数回証明を行っていることを
    // 追跡できる（必要な場合）が、実際のIDは分からない
    
    commitmentHasher.inputs[0] <== userSecret;
    commitmentHasher.inputs[1] <== userAttribute;
    // ハッシュ値を生成
    commitment <== commitmentHasher.out;
}

// ============================================
// 年齢制限付きグループ所属証明サーキット
// ============================================
// より実用的な例: 年齢確認付きメンバーシップ証明
// 
// 使用例:
// - 成人向けコンテンツへのアクセス（18歳以上であることを証明）
// - シニア割引（65歳以上であることを証明）
// - 年齢層別サービス（特定の年齢範囲にいることを証明）
// ============================================

template AgeRestrictedGroupMembership(depth, minAge) {
    // ============ 入力信号 ============
    
    signal input userSecret;
    signal input userAge;           // ユーザーの年齢
    signal input pathElements[depth];
    signal input pathIndices[depth];
    signal input root;
    signal input nullifierSeed;
    
    signal output nullifier;
    signal output commitment;
    
    // ============ 年齢検証コンポーネント ============
    
    // ユーザーの年齢が最小年齢以上であることを確認
    component ageCheck = GreaterEqThan(32); // 32ビット比較
    ageCheck.in[0] <== userAge;
    ageCheck.in[1] <== minAge;
    
    // 年齢条件を満たさない場合、証明は失敗する
    ageCheck.out === 1;
    
    // ============ 内部コンポーネント ============
    
    signal computedHash[depth + 1];
    component hashers[depth];
    signal leftInput[depth];
    signal rightInput[depth];
    signal leftPart1[depth];
    signal leftPart2[depth];
    signal rightPart1[depth];
    signal rightPart2[depth];
    
    component leafHasher = Poseidon(2);
    component nullifierHasher = Poseidon(2);
    component commitmentHasher = Poseidon(2);
    
    // ============ リーフ値計算 ============
    
    leafHasher.inputs[0] <== userSecret;
    leafHasher.inputs[1] <== userAge;
    signal leaf;
    leaf <== leafHasher.out;
    
    // ============ Merkleツリー検証 ============
    
    computedHash[0] <== leaf;
    
    for (var i = 0; i < depth; i++) {
        pathIndices[i] * (1 - pathIndices[i]) === 0;
        
        leftPart1[i] <== (1 - pathIndices[i]) * computedHash[i];
        leftPart2[i] <== pathIndices[i] * pathElements[i];
        leftInput[i] <== leftPart1[i] + leftPart2[i];
        
        rightPart1[i] <== pathIndices[i] * computedHash[i];
        rightPart2[i] <== (1 - pathIndices[i]) * pathElements[i];
        rightInput[i] <== rightPart1[i] + rightPart2[i];
        
        hashers[i] = Poseidon(2);
        hashers[i].inputs[0] <== leftInput[i];
        hashers[i].inputs[1] <== rightInput[i];
        computedHash[i + 1] <== hashers[i].out;
    }
    
    root === computedHash[depth];
    
    // ============ ヌリファイアとコミットメント ============
    
    nullifierHasher.inputs[0] <== userSecret;
    nullifierHasher.inputs[1] <== nullifierSeed;
    nullifier <== nullifierHasher.out;
    
    commitmentHasher.inputs[0] <== userSecret;
    commitmentHasher.inputs[1] <== userAge;
    commitment <== commitmentHasher.out;
}

// ============ メインコンポーネントの選択 ============

// 基本的なグループメンバーシップ証明（depth=4のMerkleツリー）
component main {public [root, nullifierSeed]} = GroupMembership(4);

// 年齢制限付き証明を使いたい場合（18歳以上）
// 上記をコメントアウトして以下を有効化
// component main {public [root, nullifierSeed]} = AgeRestrictedGroupMembership(4, 18);

// ============================================
// 使用方法の説明
// ============================================
// 
// 1. グループ管理者側:
//    - メンバーの情報からMerkleツリーを構築
//    - 各メンバーのleaf = Hash(userSecret, userAttribute)
//    - ツリーのrootを公開
// 
// 2. 証明者（メンバー）側:
//    - 自分のuserSecretとuserAttributeを保持
//    - 自分のMerkleパス（pathElements, pathIndices）を取得
//    - nullifierSeedを受け取る（アクション固有のID）
//    - 証明を生成: (userSecret, userAttribute, pathElements, pathIndices, root, nullifierSeed)
// 
// 3. 検証者側:
//    - rootとnullifierSeedを公開入力として受け取る
//    - 証明を検証
//    - nullifierをチェックして二重使用を防止
//    - commitmentを記録（必要な場合）
// 
// プライバシー保証:
// - userSecretは決して公開されない（誰であるかは秘密）
// - nullifierにより同一ユーザーの追跡が可能だが、IDは不明
// - commitmentにより一貫性を保ちつつ匿名性を維持
// ============================================