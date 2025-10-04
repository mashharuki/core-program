 # Week 2 - さらなる暗号、SNARKs と STARKs
 
 ## 実践
 
 ### Circom クラッシュコース（CLI / ZKU コース）
 
 ZKU の Week 2 はハッシュとメルクル木、Tornado Cash の基礎を扱います：
 - https://zku.gnomio.com/（Week2: https://zku.gnomio.com/mod/assign/view.php?id=119）
 - 参考: https://circom.erhant.me/
 
 ## 学習
 
 ### KZG 多項式コミットメント（直感重視のブラックボックス）
 
 多項式コミットメントは、係数を隠したまま特定点の評価値だけを開示・検証可能にします。
 
 KZG の直感は「多項式へのロック」。
 
 ![KZG](./assets/polynomial-commitments-1.jpeg)
 
 導入：
 - KZG Commitments（Inevitable Ethereum）: https://www.inevitableeth.com/home/concepts/kzg-commitment
 
 数学的詳細（任意）：
 - Dankrad Feist: https://dankradfeist.de/ethereum/2020/06/16/kate-polynomial-commitments.html
 - コード解説（Kai Jun Eer）: https://kaijuneer.medium.com/explaining-kzg-commitment-with-code-walkthrough-216638a620c9
 
 ### 信頼できるセットアップ
 
 Trusted Setup は楕円曲線上の点列（同一生成元の累乗）を生成し、PCS で用います。概念理解：
 - https://www.inevitableeth.com/en/home/concepts/pcs-trusted-setup
 
 ### STARKs と SNARKs（高レベルの比較）
 
 どちらも「証明システム」。ZK・簡潔性・非対話性・健全性・知識性などの性質を持つ構成が多い。両者を組み合わせる実例（Polygon zkEVM など）もあります。
 
 ![polygon-zkevm](./assets/polygon-zkevm.png)
 [Source](https://docs.polygon.technology/zkEVM/architecture/)
 
 高レベル比較記事（10分）: https://medium.com/@ramsesfv/starks-vs-snarks-d2e09c4e6069
 
 ### 計算から ZKP へ
 
 Vitalik の図を簡略理解：算術回路（加算・乗算ゲート）で制約を表し、各ゲートの正しさ（ゲート制約）と隣接整合性（置換制約）を多項式で示す。
 
 ![Vitalik's circuit](./assets/vitalik-circuit.png)
 
 プログラム→証明化の流れ：
 1. 制約系へ変換（例：x*x=16）
 2. 制約充足を多項式で証明（Plonk ではゲート計算と近傍整合性の証明）
 
 多様な算術化（R1CS / Plonkish / AIR）や IOP+PCS の組み合わせが存在：
 
 ![Program to Proof](./assets/program-to-proof.png)
 [Source](https://rdi.berkeley.edu/zk-learning/assets/lecture14.pdf)
 
 タクソノミ：
 
 ![Taxonomy](./assets/taxonomy.png)
 [Source](https://people.cs.georgetown.edu/jthaler/ProofsArgsAndZK.pdf)
 
 ### Groth16（ブラックボックス理解）
 
 長所：証明が小さい。導入： http://www.zeroknowledgeblog.com/index.php/groth16
 
 ### STARKs と FRI
 
 STARK は耐量子性・高速生成（証明サイズは大きめ）。
 - Vitalik Part 1: https://vitalik.eth.limo/general/2017/11/09/starks_part_1.html
 - Part 2: https://vitalik.eth.limo/general/2017/11/22/starks_part_2.html
 - （任意）Part 3: https://vitalik.eth.limo/general/2018/07/21/starks_part_3.html
 
 深掘り（任意）：
 - Stark Anatomy: https://aszepieniec.github.io/stark-anatomy/
 - Circle STARKs: https://vitalik.eth.limo/general/2024/07/23/circlestarks.html
 
 # 💪 演習
 
 1. 証明システムとは何か？
 2. input / witness / circuit / proof を定義せよ。
 3. プログラムから証明への変換プロセスを説明せよ。
 
