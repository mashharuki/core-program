# モジュール7 - 回路実装クラッシュコース

ここからは自律的な学習色が強まります。

次の2週間で Circom 回路の読み書きに慣れ、翌週には自分の回路アイデアを形にしていきます。

理解度には個人差があって当然です。大切なのは自分のペースで楽しみながら学ぶことです。

まずは Circom / Halo2 / Noir の概観から：

スタート：A beginner’s intro to coding zero-knowledge proofs  
https://dev.to/spalladino/a-beginners-intro-to-coding-zero-knowledge-proofs-c56

## Halo2 についての注意

Circom の代わりに Halo2 にフォーカスしても構いません。  
ただし学習資料は少なく、Rust の素養や自力でドキュメントを探索する力が求められます。

以下の資料を参考に：

チュートリアル・講義：
1. Consensys Diligence: Halo2 入門記事
   https://consensys.io/diligence/blog/2023/07/endeavors-into-the-zero-knowledge-halo2-proving-system/
2. Axiom: Getting Started with Halo2
   https://docs.axiom.xyz/zero-knowledge-proofs/getting-started-with-halo2
3. Axiom: Halo2 Cheatsheet
   https://hackmd.io/@axiom/HyoXzD7Zh
4. 0xParc: Halo2 講義シリーズ
   https://learn.0xparc.org/materials/halo2/learning-group-1/introduction
5. （任意）An encyclopedia of halo2: https://halo2.club/

リファレンス：
1. Halo2 Book と Simple Example: https://zcash.github.io/halo2/
2. PLONKish と Halo2 のスライド: https://docs.google.com/presentation/d/1UpMo2Ze5iwzpwICPoKkeT04-xGFRp7ZzVPhgnidr-vs/edit#slide=id.p

# Week 1（1週目）

期日指定はありません。自分のペースで進め、スキップしたい項目はスキップして構いません。

## 1. 復習と基礎

学ぶ：
- 前段モジュール6の内容を復習
- Circom/zkSNARKs のフルスタック入門記事
- Circom 言語ドキュメント（signals など）
- 基本回路（公式）
- 0xParc Circom Workshop（第一回）
- 先のモジュールで扱った Sudoku 回路を読む

課題：
- ハッシュのプレイメージを知っていることの証明回路
- 公開鍵に対応する秘密鍵を知っていることの証明回路

## 2. 基本回路の構築

学ぶ：
- 0xParc Circom Workshop（第二回）
- ZKU Week2 / Week3 の課題（ゲストアクセスで閲覧可）

課題：
- メルクル木メンバーシップ証明
- グループ所属の証明（集合所属の方法を考える）

## 3. 貢献の練習（Day 1）

GitHub の Issue / PR 流れに慣れるため、以下を試してください：

1. https://github.com/adrianmcli/summer-contribution-program を確認
2. 改善点や気づきを Issue に記載
3. メンテナと議論
4. 取り組む Issue を宣言し PR を提出（fork/branch）
5. レビュー対応
6. マージ！

## Day 2–5：自由制作

学んだプロジェクトやアイデアをヒントに、独自の小プロジェクトを企画・実装しましょう：

1. これまでの学びと既存プロジェクトを分析
2. いくつかのアイデアを起案
3. メンター・仲間からフィードバック
4. 新規リポジトリを作成
5. タスクを Issue 化（TODO）
6. 実装開始（良い Git 衛生を！）

