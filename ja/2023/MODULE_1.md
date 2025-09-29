# モジュール1 - ゼロ知識入門

ようこそ！ここからゼロ知識証明（ZKP）の世界への素晴らしい旅が始まります。

ゼロ知識証明はプライバシー保護技術の背骨であり、Ethereum をはじめとするブロックチェーンで広く活用されています。

本モジュールでは、ZKPの中核概念（健全性・完全性・ゼロ知識性）を紹介します。

さらに、後続モジュールで重要となるモジュラー算術を、手を動かしながら感覚的に理解していきます。

さあ、始めましょう！

## ゼロ知識を学ぶコツ

複雑さに圧倒されないための有用な心構えは、「まずはブラックボックス的に捉える」ことです。

細部を無視するという意味ではなく、高レベルな概念理解を先に作り、その後で詳細に潜っていく、という順番を意識しましょう。

最初に学ぶときは必須教材だけを読み、オプションは興味が湧いたときに後から。情報過多を避け、理解を積み上げるのに役立ちます。

## ゼロ知識証明の予備知識

本題に入る前に、ゼロ知識証明のハイレベルな全体像に目を通しておくと理解がスムーズです。以下は良い導入資料です：

- Zero-knowledge proofs | ethereum.org: https://ethereum.org/en/zero-knowledge-proofs/
- A Primer on Zero-Knowledge Proofs 🔏: https://medium.com/hackernoon/a-primer-on-zero-knowledge-proofs-892e6e277142
- Zero Knowledge Proofs: An illustrated primer [Part 1]: https://blog.cryptographyengineering.com/2014/11/27/zero-knowledge-proofs-illustrated-primer/
- Zero Knowledge Proofs: An illustrated primer [Part 2]: https://blog.cryptographyengineering.com/2017/01/21/zero-knowledge-proofs-an-illustrated-primer-part-2/

これらを全て読む必要はありません。コース全体を通じて、理解を確認するための振り返り質問を用意しています。

:::info
🤔 考えてみよう
1. ゼロ知識証明とは何ですか？
2. 健全性・完全性・ゼロ知識性とは何ですか？
3. 対話型と非対話型の証明の違いは何ですか？
:::

## 思考実験

以下の思考実験は、抽象的な概念を直感的に理解する助けになります：

- 例1: Where’s Waldo?（ウォーリーをさがせ）: https://medium.com/swlh/a-zero-knowledge-proof-for-wheres-wally-930c21e55399
- 例2: 色付きボール（対話型）: https://en.wikipedia.org/wiki/Zero-knowledge_proof#Two_balls_and_the_colour-blind_friend
- 例3: 数独（非対話型）: https://www.wisdom.weizmann.ac.il/~naor/PAPERS/SUDOKU_DEMO/

:::info
🤔 考えてみよう
1. 最も腑に落ちた例はどれでしたか？その理由は？
2. これらの例はどのようにゼロ知識性の原則を示していますか？
3. 日常のどんな場面に応用できそうですか？
:::

## ユースケースと応用

理論を実践に結びつけるため、ZKP がどのように実世界で使われているかを見てみましょう：

- Ethereum における ZKP のユースケース: https://ethereum.org/en/zero-knowledge-proofs/#use-cases-for-zero-knowledge-proofs
- その他の応用: https://link.springer.com/article/10.1007/s42452-019-0989-z#Sec4

:::info
🤔 考えてみよう
1. 最も興味深い応用は？その理由は？
2. 他にどんな応用を想像できますか？
:::

## 追加資料（任意）

動画を好む方は以下も参考にしてください：

- 『Introduction to Zero Knowledge Proofs』Elena Nadolinski [19:59]: https://www.youtube.com/watch?v=BT88s7_VtC8
- ZKP MOOC 講義1: ZKPの歴史と概要 [1:38:32]: https://www.youtube.com/watch?v=uchjTIlPzFo
- ZK Whiteboard Sessions - Module One: What is a SNARK?（Dan Boneh）[42:08]: https://youtu.be/h-94UhJLeck
- Detailed Explanation of Zero-Knowledge Proofs: https://youtu.be/9je336QIqAQ?t=650
- Thinking in Zero Knowledge: https://mirror.xyz/0x3FD6f213ae1B8a7B6bd8f14BE9BF316a5e5A5d28/VTGpmEYLKIslUPf66VQzHUneB0R7EhMpJJ_mGrMvTwY

ここまでで ZKP の多面的な理解ができたはずです。次は基礎数学を押さえます。

## 数論（自主学習）

今後に向けて、数論の基礎を固めましょう。以下は良い導入教材です：

- Khan Academy: モジュラー算術入門: https://www.khanacademy.org/computing/computer-science/cryptography/modarithmetic/a/what-is-modular-arithmetic

以下のトピックは自ら調べて学習してください（チームで行うのも可）：

### 学習トピック

- 基礎：
  - 素数・合成数
  - 最大公約数（GCD）

- モジュラー算術と合同：
  - モジュラー算術とは？
  - 合同類の考え方

- 群論：
  - 群構造とは？
  - 群演算とは？

- さらに深く：
  - 有限群とは？
  - 巡回群とは？
  - 生成元とは？
  - 有限体とは？

:::info
🤔 考えてみよう
1. 最も難しかった概念は？なぜ？
2. 自分の言葉で説明できますか？
:::

# 💪 演習

チームで協力して取り組み、互いに支え合いましょう！

## 理解度チェック

以下を数文で要約してください：

1. 帽子の三色塗り分け問題（グラフ三色問題）
2. アリババの洞窟のたとえ話
3. 対話型と非対話型の証明の違い

## モジュラー算術

以下を解いて、モジュラー算術の感覚をつかみましょう：

1. 7 mod 13
2. 15 mod 13
3. (7 + 15) mod 13
4. (7 mod 13 + 15 mod 13) mod 13

3と4の結果が一致するなら「群構造」に従っています。判定してみましょう。

## 生成元

巡回群 (Z_{12}, + mod 12)（12を法とする加法群）について：

1. 生成元とは何ですか？
2. この群の生成元を一つ挙げてください。
3. 他にも生成元はありますか？あれば挙げてください。

## モジュラー計算機の実装（JavaScript）

加算・減算・乗算をサポートする簡単なモジュラー計算機を作成してください。

関数 `modularCalculator` は次の4引数を取ります：
- 文字列 `op`（演算子: '+', '-', '*' のいずれか）
- 整数 `num1`, `num2`（オペランド）
- 整数 `mod`（法）

計算結果に対して mod を取った値を返してください。減算で負になることがある点に注意し、必要に応じて `mod` を足して正にしてください。

テンプレート：

```javascript
function modularCalculator(op, num1, num2, mod) {
    // Your code here
}

modularCalculator('+', 10, 15, 12); // 1 を返すべき
modularCalculator('-', 10, 15, 12); // 7 を返すべき
modularCalculator('*', 10, 15, 12); // 6 を返すべき
```

手元で `console.log` などを用いて動作確認してみましょう。オンラインREPL（例: https://repljs.com/）の利用も便利です。

## まとめ

本モジュールの終わりには、ZKP の基礎概念を理解できているはずです。これらは今後の高度なトピックを学ぶうえでの道標になります。

