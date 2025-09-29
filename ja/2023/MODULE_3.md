# モジュール3 - 暗号の要点：楕円曲線ほか

モジュール3へようこそ。まず楕円曲線の基礎と、その暗号への応用（ECC）を学びます。

続いて、双線形写像（ペアリング）に基づく暗号、BLS 署名、KZG 多項式コミットメント、MPC などの発展的トピックへと進みます。

## 楕円曲線暗号（ECC）入門

楕円曲線上の演算を用いる暗号は、離散対数問題の楕円曲線版（ECDLP）に基づき、短い鍵長で強い安全性を得られるなどの利点があります。

- Elliptic Curves（Computerphile）[8:41]: https://www.youtube.com/watch?v=NF1pwjL9-DE
- Cloudflare の分かりやすい導入記事: https://blog.cloudflare.com/a-relatively-easy-to-understand-primer-on-elliptic-curve-cryptography/

ECDSA は DSA を楕円曲線に拡張したデジタル署名方式で、**短い鍵長・高効率**ゆえに広く使われています。

以下は各署名方式の違いを概観する参考：

- RSA / DSA / ECDSA の違い（StackExchange 回答）: https://askubuntu.com/a/1000928/733503

## Schnorr 署名と EdDSA（任意）

EdDSA を理解するには、まず Schnorr 署名の理解が役立ちます。  
楕円曲線版 Schnorr は線形性によりマルチシグ集約に適します。

- Introduction to Schnorr Signatures: https://www.youtube.com/watch?v=XKatSGCZ-gE
- What Is a Schnorr Signature?: https://blog.chain.link/schnorr-signature/
- What The Heck Is Schnorr: https://medium.com/bitbees/what-the-heck-is-schnorr-52ef5dba289f
- より技術的な導入: https://tlu.tarilabs.com/cryptography/introduction-schnorr-signatures

### EdDSA（Edwards-curve Digital Signature Algorithm）

Schnorr と異なり、**EdDSA は乱数生成を決定的（メッセージと秘密鍵から導出）にします**。  
署名は `(R, s)` の形で、検証では `s*G = R + H(R || A || m)*A` を確認します。

- EdDSA and Ed25519: https://cryptobook.nakov.com/digital-signatures/eddsa-and-ed25519
- What’s an EdDSA?: https://duo.com/labs/tech-notes/whats-an-eddsa
- ECDSA, EdDSA, Schnorr 比較動画 [19:50]: https://www.youtube.com/watch?v=S77ES52AGVg

## ペアリングベース暗号（PBC）

ペアリング（双線形写像）は、楕円曲線上の2点を有限体へ写す特別な写像で、BLS署名や KZG などの基盤になります。  
ZK でも検証段階で用いられることが多いです。

![Pairing](./assets/elliptic-curve-pairings.jpeg)
[出典](https://www.inevitableeth.com/home/concepts/elliptic-curve-pairings)

- Vitalik: Exploring Elliptic Curve Pairings（任意）: https://medium.com/@VitalikButerin/exploring-elliptic-curve-pairings-c73c1864e627
- Alin Tomescu: Pairings or Bilinear Maps: https://alinush.github.io/2022/12/31/pairings-or-bilinear-maps.html

## KZG 多項式コミットメントと信頼できるセットアップ

KZG は多項式にコミットし、特定点での評価値のみを開示して検証可能にする仕組みです。  
効率的かつ簡潔（定数サイズ）であることが特徴です。

KZG では **「信頼できるセットアップ（Trusted Setup）」** が重要になります。  
MPC を用いて安全に SRS を生成・貢献・破棄する流儀が一般的です。

（詳細資料はモジュール本文のリンク群を参照）

### オプション資料（Trusted Setup）

- Vitalik: How do trusted setups work?: https://vitalik.eth.limo/general/2022/03/14/trustedsetup.html
- a16zcrypto: On-Chain Trusted Setup Ceremony: https://a16zcrypto.com/posts/article/on-chain-trusted-setup-ceremony/
- KZG Ceremony（動画）[27:27]: https://www.youtube.com/watch?v=dTBy661ubgg
- 0xParc: Trusted Setup [48:42]: https://learn.0xparc.org/materials/circom/learning-group-1/trusted-setup/

### マルチパーティ計算（MPC）［任意］

MPC は複数参加者が入力を秘匿したまま関数値を共同計算する枠組みです。  
Yao の百万長者問題が古典例。Trusted Setup の分散生成にも使えます。

- Intro（動画）[5:43]: https://www.youtube.com/watch?v=90jcXCHsBF0
- Sharing Knowledge without Sharing Data [32:08]: https://www.youtube.com/watch?v=P2MmO458xu4
- multiparty.org: https://multiparty.org/
- JavaScript チュートリアル: https://github.com/multiparty/jiff/blob/master/tutorials/0-intro-to-mpc.md

# 💪 演習

以下に答えてください：

## 楕円曲線入門

1. 楕円曲線の一般式は？

2. 2点 P, Q の和 P+Q はどのように求めますか？

3. 加法における単位元は？

## ECC

1. ECC が RSA 等に対して持つ主な利点は？

2. ECC の公開鍵はどのように秘密鍵から導出しますか？

3. ECDLP とは？

## Schnorr と EdDSA

1. Schnorr 署名の利点は？

2. EdDSA は従来の Schnorr と何が異なりますか？

## ペアリングベース暗号

1. 楕円曲線暗号におけるペアリングとは？

2. 双線形写像の3つの性質は？

3. ペアリングで可能になる応用を1つ挙げてください。

## KZG 多項式コミットメント

1. 多項式コミットメントの目的は？

2. KZG で多項式と秘密値に対するコミットはどう計算しますか？

3. KZG が効率的・簡潔とされる理由は？

## Trusted Setup

1. なぜ Trusted Setup は重要ですか？

2. zk-SNARK と Trusted Setup の関係は？

3. Trusted Setup の課題は？

