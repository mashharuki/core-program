 # Week 5 - フロンティア技術
 
 最終週は、PLONK の継続学習に加えて、MPC / FHE、TLSNotary、ZKEmail といった最前線の話題を自律的に探索します。
 
 トピックは急速に進化しているため、ここでは基礎に留めます。
 
 ## MPC / FHE
 
 ZKP・MPC・FHE は相互に重なり合う分野です。  
 ZKP を学んだうえで MPC / FHE の視点を得ると理解が深まります。
 
 ### Multi-Party Computation（MPC）
 
 入力を秘匿したまま関数値を共同計算する枠組み。  
 古典例は Yao の百万長者問題。
 
 **Trusted Setup の CRS を分散生成する用途にも使われます**。
 
 - PSE ブログ（導入）: https://mirror.xyz/privacy-scaling-explorations.eth/v_KNOV_NwQwKV0tb81uBS4m-rbs-qJGvCx7WvwP4sDg
 - 動画（5:43）: https://www.youtube.com/watch?v=90jcXCHsBF0
 - 講演（32:08）: https://www.youtube.com/watch?v=P2MmO458xu4
 - 入口: https://multiparty.org/
 - JS チュートリアル: https://github.com/multiparty/jiff/blob/master/tutorials/0-intro-to-mpc.md
 - Crash Course: https://medium.com/applied-mpc/a-crash-course-on-mpc-part-0-311fae2ce184
 - 秘密分散型 MPC（論文）: https://eprint.iacr.org/2022/062.pdf
 - 実践的入門 PDF: https://securecomputation.org/docs/pragmaticmpc.pdf
 
 ### Fully Homomorphic Encryption（FHE）
 
 暗号文のまま任意計算を可能にする強力な枠組み（現状は実用性とのトレードオフあり）。
 
 - Zero to Start（Part 1）: https://mirror.xyz/privacy-scaling-explorations.eth/D8UHFW1t48x2liWb5wuP6LDdCRbgUH_8vOFvA0tNDJA
 - Zero to Start（Part 2）: https://mirror.xyz/privacy-scaling-explorations.eth/wQZqa9acMdGS7LTXmKX-fR05VHfkgFf9Wrjso7XxDzs
 
 チュートリアル：
 - Zama FHE Tutorials: https://github.com/zama-ai/awesome-zama?tab=readme-ov-file#tutorials
 - HElib examples: https://github.com/homenc/HElib/tree/master/examples
 - Microsoft SEAL examples: https://github.com/Microsoft/SEAL/tree/main/native/examples
 
 論文・記事：
 - Gentry（初の実用的 FHE）: https://eprint.iacr.org/2009/616.pdf
 - 標準化: https://homomorphicencryption.org/standard
 - Jeremy Kun の概観: https://www.jeremykun.com/2024/05/04/fhe-overview/
 - FHE.org コミュニティ: https://fhe.org
 - TII サーベイ: https://eprint.iacr.org/2022/1602.pdf
 
 ## TLSNotary
 
 Web サーバから受け取ったデータの「真正性（出所）」を、内容を第三者に見せることなく証明するプロトコル。
 
 MPC によりプライバシーを保ちながらデータ由来を証明します。
 
 - 概要動画: https://www.youtube.com/watch?v=SDjmjiqmUFw
 - ブログ: https://pluto.xyz/blog/web-proof-techniques-mpc-mode
 - GitHub: https://github.com/tlsnotary
 - 公式サイト: https://tlsnotary.org/
 
 ## ZKEmail
 
 メールと DKIM を ZK と組み合わせるプロジェクト。  
 メールをウォレットのように使う、P2P 的な転送など新しい応用が開けます。
 
 - 動画（11:40）: https://www.youtube.com/watch?v=3jCKdxQ9Pfw
 - 技術解説ブログ: https://blog.aayushg.com/zkemail/
 - GitHub: https://github.com/zkemail
 - 公式: https://prove.email/
 
