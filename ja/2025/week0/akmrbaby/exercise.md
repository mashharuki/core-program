# week0

## 演習 1

### 1. 減算と除算の計算方法・逆元との関係

**減算**：加法逆元を用いて次のように定義される。

```math
a - b \equiv a + (-b) \mod p
```

**除算**：乗法逆元を用いて次のように定義される。

```math
a \div b \equiv a \times b^{-1} \mod p
```

### 2. 拡張ユークリッド法

拡張ユークリッド法とは、次式を満たす整数の組 $x, y$ を効率よく求める手法である。

```math
gcd(a, b) = xa + yb
```

TypeScript での実装例は以下のようになる。

```ts
function extendedGCD(
  a: number,
  b: number
): {
  gcd: number;
  x: number;
  y: number;
} {
  if (b === 0) {
    return { gcd: a, x: 1, y: 0 };
  } else {
    const { gcd, x: x1, y: y1 } = extendedGCD(b, a % b);
    const x = y1;
    const y = x1 - Math.floor(a / b) * y1;
    return { gcd, x, y };
  }
}
```

### 3. 計算問題

```math
3 - 2 = 3 + (-2) \equiv 3 + 3 = 6 \equiv 1 \mod 5
```

### 4. 計算問題

```math
3 \div 2 = 3 \times 2^{-1} \equiv 3 \times 3 = 9 \equiv 4 \mod 5
```

（mod5 における 2 の乗法逆元が 3 であることを利用）

### 5. 計算問題

```math
(7 \times 5)^{-1} = 35^{-1} \equiv 9^{-1} \equiv 3 \mod 13
```

（mod13 における 9 の乗法逆元が 3 であることを利用）

## 演習 2

### 1. $\mathbb{F}_2$ で 10110101-0110110 を計算

体 $\mathbb{F}_2$ の減算は各ビットの XOR で表現できるため **10000011**

### 2. $\mathbb{F}_{2^8}$ で 10110101-0110110 を計算

拡大体 $\mathbb{F}_{2^n}$ の減算は各ビットの XOR 演算で表現できるため **10000011**

### 3. $\mathbb{F}_{2^3}$ における $x^3+x+1$ 以外の既約多項式

```math
x^3 + x^2 + 1
```

（$\mathbb{F}_{2^3}$ 上の既約多項式は $x^3 + x + 1$ と $x^3 + x^2 + 1$ の 2 つのみ）

## 演習 3

### 1. 離散対数問題以外で安全性仮定になっている数学的問題(2 つ)

- **素因数分解問題**：大きな合成数
  $𝑁=𝑝𝑞$ の素因数 $p,q$ を求める問題。現時点で効率的な素因数分解アルゴリズムが存在しないことが安全性の根拠となっている。

- **格子問題**：格子問題の 1 つである SVP (Short Vector Problem) は、高次元格子上で最も短いベクトルを見つける問題である。この問題は NP 困難性を有することに加えて、現在知られている量子アルゴリズムを用いても多項式時間では解けないことから量子耐性を有することも安全性の根拠となっている。

### 2. 離散対数問題を効率的に説くアルゴリズム(1 つ)

- **Baby-Step Giant Step 法**：全探索と比較して、探索空間を $\sqrt n$ に分割することで計算量を $O(\sqrt n)$ まで削減している。

### 3. $5^x \equiv 8 \mod 23$ の離散対数 $x$ を求める

以下、Baby-Step Giant-Step 法を用いて解く。

群の位数は $n=22$、$m = \lceil\sqrt{22}\rceil = 5$。

**Baby-Step**：$j=0,1,\dots,4$ について $5^j \bmod 23$ を列挙。

| $j$ |       $5^j \bmod 23$       |
| :-: | :------------------------: |
|  0  |             1              |
|  1  |             5              |
|  2  |    $5^2 = 25 \equiv 2$     |
|  3  |      $2 \cdot 5 = 10$      |
|  4  | $10 \cdot 5 = 50 \equiv 4$ |

**Giant-Step**：$\alpha^{-m} = 5^{-5} \bmod 23$ を求める。

まず $5^5 \bmod 23 = 20$、その逆元は $20^{-1}\equiv15$ なので

$$
5^{-5}\equiv15\pmod{23}.
$$

次に $i=0,1,\dots,4$ について
$\gamma_i = 8\cdot(15)^i \bmod23$ を計算し、Baby-Step テーブルと照合。

| $i$ | $\gamma_i = 8 \cdot 15^i \bmod23$ | Baby-Step テーブルにあるか？ | 対応する $j$ |
| :-: | :-------------------------------: | :--------------------------: | :----------: |
|  0  |          $8 \cdot 1 = 8$          |             なし             |      -       |
|  1  |    $8 \cdot 15 = 120 \equiv 5$    |             あり             |    $j=1$     |

ここで衝突が見つかったので、

$$
5^j = \gamma_i = 8 \cdot 5^{-5i}
\quad\Longrightarrow\quad
5^{j + 5i} = 8.
$$

対応する指数は

$$
x = j + m\,i = 1 + 5\cdot1 = 6.
$$

(**検算**：$5^6 = (5^3)^2 = 10^2 = 100 \equiv 8 \pmod {23}$)

## 演習 4

### 1. ECDLP を効率的に計算するアルゴリズム

**Baby-Step Giant-Step (BSGS) 法**

（離散対数問題を定義できる任意の有限巡回群で適用可能な一般的なアルゴリズムであり、楕円曲線離散対数に対しても適用可能。）

### 2. スカラー倍散を効率的に計算するアルゴリズム

**バイナリ法**

> $n$ を 1 以上の整数として 2 進数展開します。
>
> $$
> n = [\,n_{L-1} : n_{L-2} : \dots : n_0\,]
>   = \sum_{i=0}^{L-1} n_i \,2^i,
> $$
>
> ここで $n_i\in\{0,1\}$ かつ $n_{L-1}=1$ とします。
>
> $T := P$ に対して、
>
> $$
> T := \mathrm{dbl}(T) = 2P
> $$
>
> $$
> T := \mathrm{dbl}(T) = 2^2P
> $$
>
> $$
> T := \mathrm{dbl}(T) = 2^3P
> $$
>
> $$
> ...
> $$
>
> と順次計算して $2^{L-1}P$ まで求めます。
>
> そのとき出力変数 $Q$ の初期値を 0 として、$n$ の下位ビットから $n_i = 1$ となるときの
>
> $$
> T = 2^iP
> $$
>
> を足していけば、最終的に $nP$ が求まります。

参考：https://zenn.dev/herumi/articles/ecc-binary-method

### 3. Circom で使われているデフォルトの楕円曲線

**bn128**

> Currently, it admits six different primes: bn128, bls12377, bls12381, goldilocks, grumpkin, pallas, secq256r1 and vesta. If not indicated, the default prime is bn128.

参考：https://docs.circom.io/getting-started/compilation-options/#other-flags-and-options

（`bn128` は `alt_bn128` `BN254` と同じ楕円曲線を指す。BN（Barreto–Naehrig）曲線型の楕円曲線であり、埋め込み次数 $k=12$ のペアリングフレンドリーな構造をもつ。Ethereum 上でプリコンパイル関数として実装されているため EVM との互換性が高い。）

### 4. BLS12-381 上の 2 点 $P(3, 5)$, $Q(5, 3)$ の加算をシミュレータを使って計算

楕円曲線 BLS12-381 の式とパラメータは以下の通りである。

$$
y^2 = x^3 + 4 \mod p \quad\text{where}\quad
p = 2^{381} - 19
$$

点 $P(3, 5)$ と $Q(5, 3)$ はこの楕円曲線上の点ではないので、加算できない。