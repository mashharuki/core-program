# モジュール5 - PSEプロトコル

最初の4モジュールお疲れさまでした。ここからは理論よりも、実装・プロトコル読解に軸足を移します。

PSE（Privacy and Scaling Explorations）チームのいくつかのプロトコルを概観し、公式ドキュメント・リポジトリに自力で当たれるようにします。

詳細な内部まで踏み込むより、全体像→ドキュメントの当たり方に重点を置きます。

## 導入動画

EthGlobal Paris 向けの説明動画が良い導入です（Semaphore / UniRep / RLN の概要）。

👉 Semaphore, Unirep, RLN Explained [22:33]: https://drive.google.com/file/d/1JQKDRhGsgNDfRrzy86n6wSCc1Xo1-F1F/view

各プロトコルは YouTube・ブログに多数の資料があります。気になるものは自分でも調べてみましょう。

## Semaphore

GitHub: https://github.com/semaphore-protocol  
Website: https://semaphore.appliedzkp.org/

グループメンバーであることを示しつつ、匿名のままシグナル（投票・フィードバック等）を送れるプロトコルです。

多用途に応用でき、以下の多くのプロジェクトの土台になっています。

概説動画：

👉 Anonymous Signalling on Ethereum（Devcon Bogotá）[15:30]: https://www.youtube.com/watch?v=dxAfL91Sbw4

## UniRep

GitHub: https://github.com/Unirep  
Website: https://developer.unirep.io/

Semaphore の概念を拡張し、匿名ユーザに「小さなデータ（評判など）」を結び付けられます。

たとえば Twitter がユーザのフォロワー数をアテストし、ユーザは匿名のまま「一定以上のフォロワーがいる」ことを証明できます。

概説動画：

👉 Robust Anonymous UX with the UniRep Protocol [17:01]: https://www.youtube.com/watch?v=hGQlgS9s6P8

## Rate-Limiting Nullifier（RLN）

GitHub: https://github.com/Rate-Limiting-Nullifier  
Website: https://rate-limiting-nullifier.github.io/rln-docs/

匿名環境でのスパム対策問題に対し、レート超過者にペナルティ（ステーク没収や秘密の復元）を与える暗号的アプローチです。

概説動画：

👉 Rate Limiting Nullifier（Devcon Bogotá）[7:03]: https://www.youtube.com/watch?v=vrNiPBfbLw0

## 新しめのプロジェクト（参考）

ドキュメントやAPIが変化中のものもありますが、PSE で注目されているプロジェクトを挙げます。  
演習の必須範囲ではありませんが、時間があれば触れてみてください。

### Bandada

GitHub: https://github.com/privacy-scaling-explorations/bandada  
Website: https://bandada.pse.dev/

匿名 Semaphore グループの管理を支援するバックエンド・フロントエンド基盤。匿名投票やログイン等の匿名シグナリングを容易にします。

### CryptKeeper

GitHub: https://github.com/CryptKeeperZK

ブラウザ拡張。サイトに対して Semaphore / RLN 証明を生成し、匿名ID秘密を安全に持ち運べるようにします。  
暗号・回路・キャッシュ・ストレージ等の複雑さを吸収し、アプリ統合を容易にします。

### TLSNotary

GitHub: https://github.com/tlsnotary/tlsn  
Website: https://tlsnotary.org/

任意のWebアプリから取得したデータの「真正性」を、内容を明かさず第三者へ証明する仕組み。  
中間者的な盗聴を前提とせず、プライバシーを保ったままデータ由来を証明できます。

# 💪 演習

## 個別質問

1. nullifier は何をするもので、なぜ重要ですか？
2. trapdoor は何をするもので、なぜ重要ですか？
3. Semaphore / UniRep / RLN を比較してください。
4. これらのプロジェクトで使われる主要な暗号概念は何ですか？

## 一般質問（各プロジェクトごとに）

1. 動機と機能：何のために作られ、何を実現しますか？
2. ユースケース：非技術者にも説明できる実用例を挙げてください。
3. ハードル：採用に向けた課題や改善点は？
4. 回路の読み取り（任意）：可能であれば Circom 回路を読み、何をしているか説明してください。
5. 実装（任意）：簡単なデモを作り、機能を示してください。

新しめのプロジェクトについても、余力があれば同様に検討してみてください。

