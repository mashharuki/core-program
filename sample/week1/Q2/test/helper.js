// ============================================
// Merkleツリー構築用のヘルパークラス
// ============================================
export class MerkleTree {
    constructor(depth, poseidon) {
        this.depth = depth;
        this.poseidon = poseidon;
        this.leaves = [];
        this.tree = [];
    }

    // リーフを追加
    addLeaf(leaf) {
        this.leaves.push(BigInt(leaf));
    }

    // Poseidonハッシュ関数（2つの入力）
    hash(left, right) {
        const hash = this.poseidon([BigInt(left), BigInt(right)]);
        return this.poseidon.F.toString(hash);
    }

    // ツリーを構築
    build() {
        // リーフが2^depthより少ない場合、0で埋める
        const leafCount = 2 ** this.depth;
        while (this.leaves.length < leafCount) {
            this.leaves.push(BigInt(0));
        }

        // レベル0（リーフ層）
        this.tree[0] = this.leaves.map(leaf => leaf.toString());

        // 上位レベルを構築
        for (let level = 1; level <= this.depth; level++) {
            this.tree[level] = [];
            const prevLevel = this.tree[level - 1];
            
            for (let i = 0; i < prevLevel.length; i += 2) {
                const left = prevLevel[i];
                const right = prevLevel[i + 1];
                const parent = this.hash(left, right);
                this.tree[level].push(parent);
            }
        }
    }

    // ルートを取得
    getRoot() {
        return this.tree[this.depth][0];
    }

    // 特定のリーフのMerkleパスを取得
    getProof(leafIndex) {
        const pathElements = [];
        const pathIndices = [];
        let currentIndex = leafIndex;

        for (let level = 0; level < this.depth; level++) {
            const isRightNode = currentIndex % 2;
            const siblingIndex = isRightNode ? currentIndex - 1 : currentIndex + 1;
            
            pathElements.push(this.tree[level][siblingIndex]);
            pathIndices.push(isRightNode);
            
            currentIndex = Math.floor(currentIndex / 2);
        }

        return { pathElements, pathIndices };
    }
}
