# モジュール4 - zkSNARKs

本モジュールでは zkSNARK の「中身」を覗き、どのように構成されるかを学びます。

まず**準同型隠蔽（homomorphic hiding）**や**盲検評価（blind evaluation）**の概念に触れ、その後、計算を算術回路→R1CS→QAPへと変換するパイプラインを辿ります。最後に Groth16 と PLONK といった代表的な証明系を概観します。

## 1. 計算から QAP へ

### 1.1 算術回路

計算（式）を「平坦化」し、加算・乗算ゲートのネットワークとして表します。参考：

- Electric Coin の記事（Arithmetic Circuits セクション）: https://electriccoin.co/blog/snark-explain5/
- 0xParc の記事（Flattening セクション）: https://learn.0xparc.org/materials/circom/additional-learning-resources/R1CS%20Explainer#step-1-flattening
- Maurizio Binello の連載：
  - From Theory to Practice: https://www.zeroknowledgeblog.com/index.php/the-pinocchio-protocol/from-theory-to-practice
  - One line, one operation: https://www.zeroknowledgeblog.com/index.php/the-pinocchio-protocol/one-line-one-operation

### 1.2 R1CS（Rank-1 Constraint System）

**回路を行列・ベクトルの制約へ**。  
以下を熟読：

- R1CS: A Day in the Life...（0xParc）: https://learn.0xparc.org/materials/circom/additional-learning-resources/r1cs%20explainer/
- R1CS（Binello）: https://www.zeroknowledgeblog.com/index.php/the-pinocchio-protocol/r1cs

### 1.3 QAP（二次算術プログラム）

R1CS を多項式の世界へ写像します：

- Electric Coin: Explaining SNARKs Part V: https://electriccoin.co/blog/snark-explain5/
- QAP（Binello）: https://www.zeroknowledgeblog.com/index.php/the-pinocchio-protocol/qap
- Vitalik: QAP from zero to hero: https://medium.com/@VitalikButerin/quadratic-arithmetic-programs-from-zero-to-hero-f6d558cea649

## 2. 証明系

zkSNARK の代表的な証明系として **Groth16** と **PLONK** を知っておきましょう。  
軽い比較表: https://docs.gnark.consensys.net/Concepts/schemes_curves

### 2.1 Groth16

非常に高効率で、多くのプロジェクトで標準の一つ。  
ただし回路固有の **Trusted Setup が必要** という欠点があります。

概要理解のための資料：

- Remco Bloemen: https://xn--2-umb.com/22/groth16/
- Binello: http://www.zeroknowledgeblog.com/index.php/groth16

### 2.2 PLONK

「ユニバーサルかつ更新可能」な Trusted Setup により、回路ごとの個別セットアップを不要にした点が大きな魅力です。

参考：

- Vitalik: https://vitalik.eth.limo/general/2019/09/22/plonk.html
- David Wong: https://cryptologie.net/article/529/how-does-plonk-work-part-1-whats-plonk/
- How PLONK Works:（続きの資料は原文リンク群参照）

（以降の設問などは原文の流れに従ってください）

