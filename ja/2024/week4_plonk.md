 # Week 4 - PLONK
 
 Week 0 で Rustlings を完了している前提です。 
 
 今週の必須課題は「PLONK についてのブログ記事を公開し、グループで発表する」ことです。
 
 ## 学習
 
 ZK を学ぶ際は、まず PLONK から入るのが推奨です。最初は Vitalik のブログを通読しましょう：
 - https://vitalik.eth.limo/general/2019/09/22/plonk.html
 
 ここで、広く使われる plonkish スタイルの算術化について大づかみに理解します。  
 全てを一度で理解する必要はありませんが、次の図の意味は把握しておきましょう：
 
 ![Vitalik's circuit](./assets/vitalik-circuit.png)
 
 俯瞰的な視点から PLONK を学ぶには：
 - ZKP MOOC Lec 5（動画）: https://www.youtube.com/watch?v=A0oZVEXav24
 
 実装リファレンス（Plonkathon 参照版）：
 - https://github.com/0xPARC/plonkathon/tree/reference
 
 ### 参考（任意）
 
 PLONKathon を深く理解するために役立つトピック（必要に応じて）：
 1. 公式サイト: https://plonkathon.com/
    - 必要に応じて Fiat–Shamir や FFT を事前に押さえる
    - 各ステージの解説動画: https://www.youtube.com/playlist?list=PLNK7oFq6eaEzHNYHpQ_zbgPEBDhLmyfFb
 2. Schwartz–Zippel 補題: https://brilliant.org/wiki/schwartz-zippel-lemma/
 3. ラグランジュ補間: https://en.wikipedia.org/wiki/Lagrange_polynomial
 4. FFT（直感的解説）: https://www.youtube.com/watch?v=h7apO7q16V0
 5. Fiat–Shamir ヒューリスティックの直感：対話型をハッシュで非対話化
 6. 本番実装：
    - Jellyfish: https://github.com/EspressoSystems/jellyfish
    - Dusk-network: https://github.com/dusk-network/plonk
 
