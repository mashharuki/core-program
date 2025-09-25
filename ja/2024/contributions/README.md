# PSE Core Program 2024: Contributions（貢献一覧）

![Core Program](https://img.shields.io/badge/Core-Program-blue)
![PSE Projects](https://img.shields.io/badge/PSE-Projects-orange)

## PSE Core Program 期間中の貢献

本プログラム期間中、暗号・ブロックチェーンの最前線に挑む多くの開発者・チームが集い、幅広い領域のプロジェクトに貢献しました。ここに挙げる成果は、参加者の技術力を示すだけでなく、分散型エコシステムにおける実課題を協働で解決していくマインドセットの表れでもあります。

## PSE Core Program 2024 プロジェクト一覧

以下は参加者による貢献の一覧です。

| プロジェクト名 | プロジェクト概要 |
| :-- | :-- |
| [AnonAr](#anonar) 🇦🇷 | DNI 保有者がプライバシーを保ったまま本人性を証明できるゼロ知識プロトコル。 |
| [ZK-Kit](#zk-kit-contributions) 🇦🇷 | Lean-IMT Merkle Tree において、複数葉の一括更新で各ノードを高々一度だけ更新する実装により、最悪計算量を O(n log n) から O(n) へ改善。 |
| [IMT Benchmarks](#imt-benchmarks) 🇦🇷 | サーバ／ブラウザでの Incremental Merkle Tree 実装比較（Rust→wasm 版と JS 版）。 |
| [TLSN - Duolingo](#tlsn-duolingo) 🇦🇷 | TLSN を用い、Duolingo の連続記録（streak）を、ユーザーIDやメールを秘匿したまま証明。 |
| [Anon x MACI](#anon-x-maci) 🇪🇨 | 取引所向けプルーフ・オブ・リザーブ（Summa）への貢献。 |
| [Semaphore (issue 332)](#semaphore-issue) 🇪🇨 | 拡張コントラクトパッケージを使った DApp 構築のステップバイステップチュートリアルを作成。 |
| [ZK-Kit (issue 230)](#zk-kit-issue) 🇪🇨 | eddsa-poseidon の signMessage で許容するメッセージ型の制限・明確化。 |
| [Summa Solvency](#summa-solvency) 🇦🇷 | Summa Solvency への PR。検証鍵の確認容易化など透明性向上に寄与。 |
| [MPC Adventures](#mpc-adventures) 🇦🇷 | MPC 基本プリミティブ（Yao, OT, Shamir）の素朴実装と解説ノート。 |
| [Jubmoji Quest - Proof of Location Extension](#jubmoji-quest-proof-of-location-extension) 🇨🇷 | QR 経由の位置情報証明を Jubmoji に拡張。 |

（この後に続く各セクションで詳細を記載します）

---

### AnonAr

**Contributors（貢献者）:**

- Lorenzo Hardoy - https://x.com/lorenzz29

**Project Description（説明）:**
AnonAr は、DNI 保有者がプライバシーを保ったまま本人性を証明できるゼロ知識プロトコルです。

**Technical Stack（技術）:**

- Circom

**Project Goals（目標）:**
ユーザーが有効な証明を生成できる MVP を構築する。

**GitHub Link:**
[https://github.com/Lorenz29/anon-ar/](https://github.com/Lorenz29/anon-ar/)

---

### ZK-Kit contributions

**Contributors（貢献者）:**

- Chino Cribioli - @chino_cribioli

**Project Description（説明）:**

- Contribution 1:
  ライブラリの Lean-IMT（葉の追加・削除・更新に対応する Merkle Tree 実装）において、複数葉を一括更新するメソッドを実装。更新対象葉が木全体に近い規模のとき、各ノードを全体を通して高々一度だけ更新するよう設計し、最悪計算量を O(n log n) から O(n) に改善。計算量の詳細な分析も同梱。

- Contribution 2:
  EdDSA パッケージにおける Baby JubJub 実装のタイミング攻撃脆弱性を指摘。`mulPointScalar` が古典的な square-and-multiply に基づくため、処理時間から秘密値の二進表現に含まれる 1 の個数を推測できる恐れがある。詳細は issue を参照: https://github.com/privacy-scaling-explorations/zk-kit/issues/324

**Technical Stack（技術）:**

- Typescript
- アルゴリズム解析

**Project Goals（目標）:**

- Contribution 1: 更新件数が多い場合のパッケージ性能を最適化。
- Contribution 2: 対応として Montgomery Ladder の実装を提案（タイミング攻撃耐性のある手法）。

**GitHub Link:**

- Contribution 1: https://github.com/privacy-scaling-explorations/zk-kit/pull/314
- Contribution 2: https://github.com/privacy-scaling-explorations/zk-kit/pull/325

---

### IMT Benchmarks

**Contributors（貢献者）:**

- Sebastián Giraudo - @sebagiraudo

**Project Description（説明）:**
サーバ／ブラウザにおける Incremental Merkle Tree 実装の比較。Rust 実装を wasm 化して比較し、JS 実装とも対比。

**Technical Stack（技術）:**

- Rust, TypeScript, wasm 変換

**Project Goals（目標）:**
各実装のベンチマーク取得と比較。

**GitHub Link:**
https://github.com/sebagiraudo/imt-benchmarks

---

### TLSN-Duolingo

**Contributors（貢献者）:**

- Sebastián Giraudo - @sebagiraudo

**Project Description（説明）:**
Duolingo の streak（連続記録）を TLSN で証明するプロジェクト。user_id と email は秘匿。

**Technical Stack（技術）:**

- TLSN, Rust

**Project Goals（目標）:**
TLSN の使い方習得と、リクエスト／レスポンス中の秘匿データの扱いの検証（PoC）。

**GitHub Link:**
https://github.com/sebagiraudo/tlsn-duolingo

---

### Anon X MACI

**Contributors（貢献者）:**

- @protocolwhisper
- @protocolllo

**Project Description（説明）:**
取引所の準備金証明（Summa）への貢献。

**Technical Stack（技術）:**

- Rust

**Project Goals（目標）:**
全残高を開示せずに流動性の証明を作成可能にする。

**GitHub Link:**
https://github.com/summa-dev/summa-solvency/pull/301

---

### Semaphore issue

**Contributors（貢献者）:**

- Fernando Ledesma - https://t.me/f3rledesma

**Project Description（説明）:**
拡張コントラクトパッケージを用いた DApp を段階的に作る Semaphore のチュートリアルを作成（`SemaphoreWhistleblowing.sol` を使用）。

**Technical Stack（技術）:**

- Semaphore, TypeScript, Next.js, wagmi, RainbowKit

**Project Goals（目標）:**
DApp をデプロイし、手順を記事化して公開する。

**GitHub Link:**
https://github.com/f3r10/semaphore-whistleblowing-example-app

---

### ZK-Kit issue

**Contributors（貢献者）:**

- Fernando Ledesma - https://t.me/f3rledesma

**Project Description（説明）:**
eddsa-poseidon の `signMessage` におけるメッセージ型を制限し、32 バイト超の入力を受け付けないなど型を明確化。

**Technical Stack（技術）:**

- TypeScript

**Project Goals（目標）:**
開発者が使用すべき型を誤解しないよう、パラメータ型を更新。

**GitHub Link:**
https://github.com/privacy-scaling-explorations/zk-kit/pull/318

---

### Summa Solvency

**Contributors（貢献者）:**

- Francisco Bezzecchi - @bezze

**Project Description（説明）:**
Summa Solvency への PR。利用者が上流の Ethereum 検証コントラクトで使われる検証鍵を容易に確認できるようにし、フロー全体の透明性向上に寄与。

**Technical Stack（技術）:**

- Rust, Solidity, Halo2

**Project Goals（目標）:**
検証鍵確認の容易化など、Summa 全体の透明性向上。

**GitHub Link:**
https://github.com/summa-dev/halo2-solidity-verifier/pull/2

---

### MPC Adventures

**Contributors（貢献者）:**

- Caro Lang - @carolang

**Project Description（説明）:**
MPC プリミティブ（Yao のガーブルド回路、OT、Shamir 秘密分散）の素朴実装を Python で示し、解説ノート（演習と解答つき）を提供。数学的資料とコミュニティの橋渡しとなる実行可能コードを提示。

**Technical Stack（技術）:**

- Jupyter Notebook, pycryptodome, SageMath

**Project Goals（目標）:**
学習用の実行可能資料を提供。将来的には自動テストやコードのモジュール化、最適化版の追加を計画。

**GitHub Link:**
https://github.com/carolang/mpc-adventures

---

### Jubmoji Quest Proof of Location Extension

**Contributors（貢献者）:**

- Joaquin Barrientos - @jbmkahdeksan
- Steven Cordero - @stevencartavia
- Erick Vásquez - @evgongora
- Humberto Trejos - @HumbertoTM10
- Ricardo Bonilla - @richbm10
- Roberto Solano - @robertosolano

**Project Description（説明）:**
QR コードを通じた位置情報証明を Jubmoji に拡張。

**Technical Stack（技術）:**

- Circom, SnarkJS, Next.js

**Project Goals（目標）:**
QR による Proof of Location 検証機能を Jubmoji に実装。

**GitHub Link:**
https://github.com/richbm10/jubmoji.quest

---

### ZK Multiverse

**Contributors（貢献者）:**

- Alfredo - https://x.com/brolag
- Mai - https://x.com/MaiCVCR

**Project Description（説明）:**
インタラクティブな課題を通じて ZK を学ぶ学習経路を提示。Circom や Noir で回路を作る演習に加え、暗号・数学の基礎もカバー。手を動かす実践重視で、学習者が本当に必要なスキルにフォーカスできるようガイドする。

**Technical Stack（技術）:**

- Circom, Noir, Scaffold-ETH（Next.js, TailwindCSS, TypeScript）

**Project Goals（目標）:**
理論過多と情報過多のギャップを埋め、実践的シナリオで ZK スキルを身につけられるようにする。

**GitHub Link:**
https://github.com/brolag/zk-multiverse

---

### KZG implementation

**Contributors（貢献者）:**

- Lucas Dario Cardacci

**Project Description（説明）:**
（動機）
既存のベクターコミットメントはハッシュと Merkle Tree により所属／非所属や出現回数を証明するが、学位論文で KZG に基づくベクターコミットメントを提示。これを Rust で実装する。

**Technical Stack（技術）:**

- Rust

**Project Goals（目標）:**
KZG ベースの所属／非所属・出現回数証明を提供する Rust ライブラリを実装・十分にテスト・文書化し、他システムへ容易に統合可能にする。

**GitHub Link:**
https://github.com/lcarda/Curucucha

---

### Semaphore UI contribution

**Contributors（貢献者）:**

- yagopajarino - @0xyago

**Project Description（説明）:**
CLI モノレポの ethers 更新や subgraph Web アプリの UI 更新。

**Technical Stack（技術）:**

- React, HTML, CSS

**Project Goals（目標）:**
Semaphore デモのフロントエンドを更新。

**GitHub Link:**
https://github.com/semaphore-protocol/semaphore/pull/841

---

### ZKP2P landing bug fix

**Contributors（貢献者）:**

- yagopajarino - @0xyago

**Project Description（説明）:**
ZKP2P ランディングページのドキュメント URL を修正。

**Technical Stack（技術）:**

- Frontend

**Project Goals（目標）:**
ランディングページのドキュメント URL を是正。

**GitHub Link:**
https://github.com/zkp2p/zk-p2p/pull/398

---

### Zk-mercadopago

**Contributors（貢献者）:**

- yagopajarino - @0xyago

**Project Description（説明）:**
Mercado Pago 上のトランザクションを証明する Circom 回路を作成。

**Technical Stack（技術）:**

- Circom

**Project Goals（目標）:**
決済システム上の取引が成されたことを証明する回路を実装。

**GitHub Link:**
https://github.com/zkemail/zk-email-verify

---

### Noir Playground

**Contributors（貢献者）:**

- Bruno Weisz - @TheRasmuz

**Project Description（説明）:**
ブラウザ上で Noir プログラムを記述し、回路の典型ワークフロー（コンパイル／実行／証明／検証）を体験できる Web アプリ。オンチェーン検証（Verifier コントラクトの生成・コンパイル・デプロイ・トランザクション）も動的に実行可能。

**Technical Stack（技術）:**

- フロント: Noir.js, Vite + React（ethers.js）
- バックエンド: Node + Express（コントラクトのコンパイルに使用）
- Devnet/ビルド: Hardhat（ローカル開発ネット・コンパイル）

**Project Goals（目標）:**

- より多くの人に ZK・回路・コントラクトの導入を容易にする。
- Noir.js を使った汎用テンプレ（各工程の疎結合構成）を提供。
- ブラウザでの証明生成・コントラクト連携を自身も学ぶ。

**GitHub Link:**
https://github.com/brweisz/noir-dapp-custom-template

---

### Grupo PLONK

**Contributors（貢献者）:**

- Wilman - @wildanvin
- Chris - protocolwhisper

**Project Description（説明）:**
Anon Aadhaar と MACI を統合した投票テンプレート。匿名 ID 検証（Anon Aadhaar）と反談合インフラ（MACI）を組み合わせ、オンチェーンで安全・透明・プライバシー重視の投票基盤を提供。

**Technical Stack（技術）:**

- Scaffold-ETH2, Tailwind, Hardhat, Solidity

**Project Goals（目標）:**
Anon Aadhaar × MACI による、より堅牢でプライベートな投票テンプレートの作成。

**GitHub Link:**
https://github.com/wildanvin/maci-anonAadhaar

Wilman による MACI リポジトリへの貢献：  
https://github.com/privacy-scaling-explorations/maci/issues/1153  
https://github.com/privacy-scaling-explorations/maci/pull/1797  
https://github.com/privacy-scaling-explorations/maci/pull/1824

**Video Link:**
https://www.youtube.com/watch?v=WCTqd1djGz4

---

### Zk-grammar

**Contributors（貢献者）:**

- Pablo Dallegri

**Project Description（説明）:**
与えられた文脈自由文法から秘密データが生成可能であることを示すための Noir ライブラリ。

**Technical Stack（技術）:**

- Noir

**Project Goals（目標）:**
文脈自由文法検証の PoC を公開。

**GitHub Link:**
https://codeberg.org/pdallegri/zk-grammar

---

### Jimmy Chu

**Contributors（貢献者）:**

- Jimmy Chu - @jimmychu0807

**Project Description（説明）:**
各ラウンドで 1〜100 の値にコミットし、全員が開示した後に平均に最も近い値を当てたプレイヤーが勝利するゲーム。コミットはクライアント側で zk-SNARK 回路を通して生成し、オンチェーンに保存。3 ラウンド先取で勝利。

**Technical Stack（技術）:**

- Circuit: Circom, circomkit, plonk
- Smart Contract: Hardhat
- Frontend: Next.js（viem, wagmi, web3modal）
- 全体: Semaphore boilerplate（https://github.com/semaphore-protocol/boilerplate）

**Project Goals（目標）:**
ZK 回路の Prover、コントラクト Verifier、フロントエンドを接続し、エンドツーエンドの zk dApp を構築する。

**GitHub Link:**
https://github.com/jimmychu0807/PSE-core-self-capstone

**Video Link:**
https://www.youtube.com/watch?v=MrhGMfzsAX0

---

### TW Group5

**Contributors（貢献者）:**

- JimmyLiu @csiejinmyliu
- Tim @timou0911

**Project Description（説明）:**
NOVA folding scheme の mopro-ffi 対応テスト。

**Technical Stack（技術）:**

- Rust

**Project Goals（目標）:**
mopro-ffi 上で NOVA folding scheme のテストを作成。

**GitHub Link:**
https://github.com/csiejimmyliu/mopro

---

### MPZ Optimize garbling control flow

**Contributors（貢献者）:**

- yawn（github: yawn-c111 / discord: yawnc_eth / twitter: yawnc_eth）

**Project Description（説明）:**
Rust 製 2PC ライブラリ mpz の garbling/evaluation におけるループ・分岐処理を最適化。

**Technical Stack（技術）:**

- Rust, Cargo, Criterion（ベンチマーク）, git

**Project Goals（目標）:**
関連コードの高速化。

**GitHub Link:**
https://github.com/privacy-scaling-explorations/mpz/pull/184

---

### Hiroshi Chiba

**Contributors（貢献者）:**

- @bati668

**Project Description（説明）:**
SwiftyPoseidon（iOS 向け Poseidon ハッシュライブラリとサンプル）。

**Technical Stack（技術）:**

- C++, Swift

**Project Goals（目標）:**
iOS 開発者向けに、より高速で構成可能な Poseidon ライブラリを提供。

**GitHub Link:**
https://github.com/bati668/SwiftyPoseidon  
https://github.com/bati668/SwiftyPoseidonExample

---

### MACI-platform issue 326

**Contributors（貢献者）:**

- Kota Urushigaki - @kota_price

**Project Description（説明）:**
MACI プラットフォームのアプリケーションページで Markdown をサポート。

**Technical Stack（技術）:**

- Markdown

**Project Goals（目標）:**
テキスト可読性とプラットフォーム UI の改善。

**GitHub Link:**
https://github.com/kota5140/maci-platform

---

### UPDATE Core-program week0 week4

**Contributors（貢献者）:**

- RYO KAJIWARA

**Project Description（説明）:**
初学者が Week4 の Rustlings を 1 週間で完了するのは大変なため、練習を Week0 に移す提案。

**Technical Stack（技術）:**

- N/A

**Project Goals（目標）:**
ZKP 学習ハードルの低減。

**GitHub Link:**
https://github.com/privacy-scaling-explorations/core-program/pull/47

---

### p0tion (issue #326)

**Contributors（貢献者）:**

- Nathalia Barreiros - @nathbarreiros

**Project Description（説明）:**
`/packages/api` モジュールの包括的なユニットテストを追加。NestJS ベースの API（zkSNARK Phase 2 Trusted Setup のコーディネータインフラ）で、Auth / Ceremonies / Circuits / Participants / Storage / Users を対象に、Entity / DTO / Service / Controller の正当性や並行リクエスト・データ連携を検証。

**Technical Stack（技術）:**

- NestJS, TypeScript, Jest

**Project Goals（目標）:**
単一サーバアーキテクチャへ移行する p0tion に対し、信頼性・保守性・品質を高める包括的テストを実装。

**GitHub Link:**
https://github.com/privacy-scaling-explorations/p0tion/pull/328

---

### Researching Curve Trees

**Contributors（貢献者）:**

- Ryunoshin（X / GitHub: noshin0061）

**Project Description（説明）:**
Curve Trees は既存の IMT/Merkle Tree より効率的な可能性。論文を調査し理論と効率を発表資料に整理。TypeScript 実装の検討へ着手。

**Technical Stack（技術）:**

- Rust, TypeScript

**Project Goals（目標）:**
TS 実装の実現可能性を調査し、他 IMT とのベンチマーク比較を目指す。

**GitHub Link:**
https://github.com/noshin0061/curve-trees-maci

---

### Bringing Membership Proof Onto Modular Smart Account

**Contributors（貢献者）:**

- Taehoon Lee

**Project Description（説明）:**
Semaphore のメンバーシップ証明を ERC-6900 の AA モジュールとして実装し、任意のウォレット開発者が一般用途のメンバーシップ証明機構を利用可能にする。

**Technical Stack（技術）:**

- Circom, Solidity, Account Abstraction

**Project Goals（目標）:**
モジュールコントラクトとリファレンスウォレットコントラクトを完成させる。

**GitHub Link:**
（準備中）

---

### ZK-LeeVM (Kanguk Lee)

**Contributors（貢献者）:**

- Kanguk Lee - @p51lee

**Project Description（説明）:**
Circom で書かれた簡易 VM。ZK を用いた VM 学習に適したシンプル設計。

**Technical Stack（技術）:**

- Zero-Knowledge Virtual Machine, Circom

**Project Goals（目標）:**
ZK と VM の接続を理解するための教材的 VM を提供。

**GitHub Link:**
https://github.com/p51lee/zkLeeVM

---

### Circom-intsafe

**Contributors（貢献者）:**

- Kanguk Lee - @p51lee

**Project Description（説明）:**
Circom DSL の静的解析ツール。テンプレート内の全 signal/変数が [-p/2, p/2] に収まることを保証する助けをする。

**Technical Stack（技術）:**

- 静的解析, Rust, Circom

**Project Goals（目標）:**
有限体を整数的に扱う際のオーバーフローや範囲超過を防止。

**GitHub Link:**
https://github.com/p51lee/circom-intsafe

---

### Understanding ZK Regex

**Contributors（貢献者）:**

- Lorenzo Ruiz Díaz - @lorenzord2003

**Project Description（説明）:**
ZK Regex のコード面の意思決定や実装部分をドキュメント化。文字の 8bit 表現から、正規表現／オートマトン／ゼロ知識／Circom 回路、そして本プロジェクトで用いる構造・関数まで、ゼロから分かるように解説。

**Technical Stack（技術）:**

- Markdown, Rust, Circom

**Project Goals（目標）:**
ZK Regex の仕組みを、背景知識が少ない読者にも届く形で説明する。

**GitHub Link:**
https://github.com/LorenzoRD2003/understanding-zk-regex

---

### OpenFlow

**Contributors（貢献者）:**

- @NicolasBiondini
- @yagopajarino
- @almaraz97
- @NicoAcosta
- @arturoBeccar

**Project Description（説明）:**
第三者送受信者のプライバシーを守りつつ、取引監査の透明性を確保する ZK ソリューション。

**Technical Stack（技術）:**

- zk-proofs, zkemail/proof-of-twitter, Circom, Foundry, Solidity, Next.js

**Project Goals（目標）:**
プライバシーを保ちながら取引監査を可能にする。

**GitHub Link:**
https://github.com/openflow-labs

**Video Link:**
https://www.youtube.com/watch?v=i-D_0pHmwQ8

---

### 10GO

**Contributors（貢献者）:**

- @NicolasBiondini
- @yagopajarino
- @almaraz97
- @NicoAcosta
- @arturoBeccar

**Project Description（説明）:**
アカウント抽象化と ZK を活用し、Mercado Pago と暗号資産をつなぐ分散プラットフォーム。新規ユーザのオンボーディングを容易にし、将来的な担保付き貸付・マイクロクレジット等の土台に。

**Technical Stack（技術）:**

- zk-proofs, zk-email, Solidity, Foundry, Next.js, Circom

**Project Goals（目標）:**
フィアットから暗号資産への遷移を簡素化しつつ、将来機能の礎を築く。

**GitHub Link:**
https://github.com/10GO-labs

---

### Manno, Hong group

**Contributors（貢献者）:**

- Tadashi Mannou - @yorozunouchu
- Ying Hong - @Ying

**Project Description（説明）:**
TLSNotary の設定ハンドリング改善（TLS と Authorization フィールドを任意化）。

**Technical Stack（技術）:**

- TLSNotary, Rust

**Project Goals（目標）:**
一部設定が欠けると起動失敗していた問題を修正。

**GitHub Link:**
https://github.com/tlsnotary/tlsn/pull/589

---

### ZK-Regex with Arkworks

**Contributors（貢献者）:**

- Seunghyun Cho / Junho Kim / Soyeon Park

**Project Description（説明）:**
内容を開示せず「パターンに一致すること」だけを証明する ZK-Regex を、Circom/Halo2 版に加え Rust + Arkworks で実装。

**Technical Stack（技術）:**

- Rust, Arkworks, Regex, regex_automata

**Project Goals（目標）:**
Circom の制約やデバッグ難を避け、Rust/Arkworks により実装上の課題を解決。

**GitHub Link:**
https://github.com/c0np4nn4/arkworks_zkregex_generator

**Additional links:**
発表スライド: https://docs.google.com/presentation/d/19s_z0qJoXJaS0S4fuoAdZCcBgXrUXG6aQyznsaQx6JE/edit#slide=id.g3031c1035c0_0_0

---

### Summa-solvency issue #299

**Contributors（貢献者）:**

- Park EuiHyuk - @2hyuk

**Project Description（説明）:**
検証鍵コントラクトに対する検証プロセスの導入（コミットメントや鍵ダイジェスト等を含む）。Summa コントラクトに登録された検証鍵コントラクト由来の `vk_digest` を、ユーザ側の生成値と比較検証できるようにする。

**Technical Stack（技術）:**

- Rust, Solidity

**Project Goals（目標）:**
検証鍵コントラクトのバリデーション導入。Issue の解決・PR・マージまで。

**GitHub Link:**
https://github.com/2hyuk/summa-solvency/commit/855937c2d9ff02f5b60ba0f1a6fbb1031a690750

---

### ZKP to build an on-chain zk-Auction system

**Contributors（貢献者）:**

- Ken / Wayne / Kevin

**Project Description（説明）:**
入札額を締切まで秘匿（コミットメントでオンチェーン送信）し、入札時にはリザーブ価格以上であることを ZK 証明。締切後に開示し、最高入札者を決定。以降の決済処理もスマートコントラクトで管理。

**Technical Stack（技術）:**

- Web: Next.js / React
- Smart Contract: Solidity / Hardhat

**Project Goals（目標）:**
入札額を明かさずに動作するオンチェーン zk オークションを実装。

**GitHub Link:**
https://github.com/kenlina/PSE_Group2_Project/tree/main

**Additional links:**
発表動画: https://drive.google.com/file/d/1OvZBtzL_DvI_qRtM6WNL0zM9DgUgGA_-/view?usp=sharing

---

### BK, HJ

**Contributors（貢献者）:**

- @NyeonJ2 / @SuperQ_16

**Project Description（説明）:**
ZKP を用いた投票システム。入金や Tally への情報開示を不要とし、Plonkish + KZG で証明検証。

**Technical Stack（技術）:**

- Rust（arkworks）, Solidity

**Project Goals（目標）:**
コントラクトでの検証関数の実装を完了する。

**GitHub Link:**
https://github.com/Han-16/PSE-Voting

---

### zkGrants

**Contributors（貢献者）:**

- @almarazETH

**Project Description（説明）:**
匿名グループを作成し、受領者へのトークン配分後、その解放をプライベートに投票！

**Technical Stack（技術）:**

- ScaffoldETH（NextJS, Tailwind）, Foundry, Semaphore

**Project Goals（目標）:**
オンチェーン組織における助成金の説明責任を高め、インパクト最大化を支援。

**GitHub Link:**
https://github.com/almaraz97/zkGrants

---

### Taketora

**Contributors（貢献者）:**

- @wasabi / @akafuda

**Project Description（説明）:**
ユーザー名の範囲チェックを回路側で強化し、252bit 超のオーバーフローを防止。Custodian 要件に応じて範囲を変更可能にする（Rust の feature flag で切替）。MST（Merkle Sum Tree）の信頼性向上にも寄与。

**Technical Stack（技術）:**

- Halo2

**Project Goals（目標）:**
堅牢な範囲チェック機構の実装・可変化・MST の安全性向上。

**GitHub Link:**
https://github.com/wasabijiro/summa-solvency

---

### Akafuda

**Contributors（貢献者）:**

- @uoooobtc

**Project Description（説明）:**
PSE の bandada への貢献。オフチェーングループページ（`/groups/off-chain/[]`）に、グループ ID・サイズ等の JSON ダウンロード機能を追加。

**Technical Stack（技術）:**

- Next.js

**Project Goals（目標）:**
API から取得したグループ情報を JSON 化してダウンロードできるようにする。

**GitHub Link:**
https://github.com/bandada-infra/bandada/pull/549

---

### Automatic Difference in Cairo

**Contributors（貢献者）:**

- Tanizaki Soma - @ili_illi_ili

**Project Description（説明）:**
Starknet 言語 Cairo による自動微分ライブラリ。

**Technical Stack（技術）:**

- Cairo

**Project Goals（目標）:**
ZK エコシステムで有用な解析ライブラリの作成。

**GitHub Link:**
https://github.com/rexumm/zkAnalysisLibrary

---

### PLONK

**Contributors（貢献者）:**

- @Jason / @Frank / @Alan / @Wias

**Project Description（説明）:**
ZKMopro への Binius 統合。

**Technical Stack（技術）:**

- Rust, Binius, Mopro

**Project Goals（目標）:**
ZKMopro へ Binius を統合する。

**GitHub Link:**
https://github.com/zkmopro/mopro/issues/238
 
