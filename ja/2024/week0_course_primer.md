 # Week 0 - コース準備（Primer）
 
 このモジュールは、プログラムが始まる前に完了しておくべき前提モジュールです。外部メンターに大きく依存せずに自学できるよう設計されています。必要であれば、遠慮なく助けを求めてください。
 
 このモジュールは必ず開始前に完了してください！⚠️📚⚠️
 
 ## 助けを得る
 
 複雑なトピックが多いので、早め・頻繁に質問することが大切です。異なる視点からの意見は理解を助けます。以下に、質問の仕方と場所をまとめます。
 
 ### 良い質問の仕方
 
 - 読み手に配慮した構造化: 📋 箇条書き・見出しなどで分かりやすく。
 - 問題の記述: 🛠️ いま直面している問題・エラーを明確に。
 - 試したこと: 🔍 既に試した手順・結果を列挙。
 - 文脈の共有: 🌐 再現に必要な最小限のコード・手順・環境など。
 - 環境の明記: 💻 OS・言語・ライブラリ・ツールのバージョンなど。
 - 礼儀と忍耐: 🙏 丁寧に、返信を待つ間も落ち着いて。
 
 ### どこで質問するか
 
 - Core Program Discord: https://discord.gg/Xd6wdU2QJg
 - PSE Discord（#❓ask-any-question 推奨）: https://discord.com/invite/sF5CT5rzrR
 - Core Program Telegram: https://t.me/+h6P9q5Ia0vdlMDYx
 
 ### GitHub PR ワークフローの理解
 
 3分動画で概要を掴みましょう: https://youtu.be/jRLGobWwA3Y?si=6uZrn8mrd30QnUtW
 
 ```mermaid
 sequenceDiagram
     participant Developer
     participant GitHub
     participant Reviewer
     participant Maintainer
 
     Developer->>GitHub: Create branch and make changes
     Developer->>GitHub: Push branch to repository
     Developer->>GitHub: Open a pull request (PR)
     GitHub->>Reviewer: Notify reviewer of PR
     Reviewer->>GitHub: Review code and leave comments
     Developer->>GitHub: Address comments and push updates
     Reviewer->>GitHub: Approve changes
     GitHub->>Maintainer: Notify maintainer of approved PR
     Maintainer->>GitHub: Merge PR into main branch
     GitHub->>Developer: Notify developer of merged PR
     GitHub->>Team: Update branch status and notify team
 ```
 
 ## コース情報
 
 本コースは当初、ZKP の次世代 OSS 貢献者育成を目的に設計されました。現在は MPC や FHE も含む「プログラマブル暗号（ProgCrypto）」全般を対象とします。技術基礎に加え、OSS 文化・パブリックグッズ・Git/GitHub の運用も重視します。
 
 ### OSS 文化・Git・GitHub
 
 Adrian Li による概要：
 
 - 動画（The Way of Open Source）[18:28]: https://drive.google.com/file/d/1T7ACbYl4joqrJg6dRxHaIYNNhWrftamB/view?usp=drive_link
 - スライド: https://docs.google.com/presentation/d/1wqyn6FnyINulTSEIWwZaVYak3ONbjTUi9shBOhAZkd8/edit?usp=sharing
 
 参考：
 - Git チートシート（GitHub）: https://education.github.com/git-cheat-sheet-education.pdf
 - Git ワークフロー比較（Atlassian）: https://www.atlassian.com/git/tutorials/comparing-workflows
 
 ## 事前知識
 
 複雑な話題は「まずブラックボックス化」で全体像から。詳細は後で掘り下げる方針が、挫折を避ける助けになります。最初は必須教材のみ、好奇心が湧いたら任意教材へ。
 
 ### ZKP の応用
 
 - Ethereum の ZKP ユースケース: https://ethereum.org/en/zero-knowledge-proofs/#use-cases-for-zero-knowledge-proofs
 - その他の応用: https://link.springer.com/article/10.1007/s42452-019-0989-z#Sec4
 
 :::info
 🤔 考えてみよう
 1. 最も興味深い応用は？その理由は？
 2. 他に想像できる応用は？
 :::
 
 ### 追加資料（任意）
 
 - 動画：
   - Introduction to ZKPs（Elena Nadolinski）[19:59]: https://www.youtube.com/watch?v=BT88s7_VtC8
   - ZKP MOOC Lecture 1 [1:38:32]: https://www.youtube.com/watch?v=uchjTIlPzFo
   - ZK Whiteboard - What is a SNARK?（Dan Boneh）[42:08]: https://youtu.be/h-94UhJLeck
   - Detailed Explanation of ZKPs: https://youtu.be/9je336QIqAQ?t=650
 - Thinking in Zero Knowledge: https://mirror.xyz/0x3FD6f213ae1B8a7B6bd8f14BE9BF316a5e5A5d28/VTGpmEYLKIslUPf66VQzHUneB0R7EhMpJJ_mGrMvTwY
 - LambdaWorks（実装リーディング向け）: https://github.com/lambdaclass/lambdaworks
 
 ### 数論
 
 - Khan Academy: モジュラー算術入門: https://www.khanacademy.org/computing/computer-science/cryptography/modarithmetic/a/what-is-modular-arithmetic
 
 自主学習トピック：
 
 - 基礎
   - 素数・合成数
   - 最大公約数（GCD）
 - モジュラー算術と合同
   - モジュラー算術とは？
   - 合同類
 - 群論
   - 群構造とは？
   - 群演算とは？
 - 深掘り
   - 有限群・巡回群・生成元
   - 有限体
 
 :::info
 🤔 考えてみよう
 1. 最も難しかった概念は？
 2. 自分の言葉で説明できますか？
 :::
 
 ## 💪 演習
 
 ### 理解度
 
 1. 帽子の三色問題
 2. アリババの洞窟のたとえ
 3. 対話型と非対話型の違い
 
 ### モジュラー算術
 
 1. 7 mod 13
 2. 15 mod 13
 3. (7 + 15) mod 13
 4. (7 mod 13 + 15 mod 13) mod 13
 
 3 と 4 の結果が一致するか？一致するなら「群構造」に従っています。
 
 ### 生成元
 
 巡回群 (Z_{12}, + mod 12) について：
 
 1. 生成元とは？
 2. 生成元を1つ挙げる。
 3. 他にもあるか？
 
 ### モジュラー計算機の実装
 
 JavaScript などで、加算・減算・乗算をサポートする簡単な関数 `modularCalculator(op, num1, num2, mod)` を実装。負の結果は mod を加えて正に補正。
 
 ```javascript
 function modularCalculator(op, num1, num2, mod) {
     // Your code here
 }
 
 modularCalculator('+', 10, 15, 12); // -> 1
 modularCalculator('-', 10, 15, 12); // -> 7
 modularCalculator('*', 10, 15, 12); // -> 6
 ```
 
 https://repljs.com/ などで動作確認しても良いでしょう。
 
 ## まとめ
 
 Week 0 の完了おめでとうございます。ここで学んだ基礎を土台に、ZKP と関連技術をさらに深めていきましょう。好奇心を保ち、協働し、練習し、焦らずに。必要なときはいつでも助けを求めてください！
 
