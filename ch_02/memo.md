# chapter 2

#### 2.3.1.3 正当性

SIMPLE言語を通じ，文法を定義してきた
一方で，意味論的正当性は言及していない
ex. x=true; x = x+1 など
これ実行するとプロセスが失敗する

これに対応するには，reducible?をより厳密にすればよい
(型とかそんな話かな)
で，falseの場合，評価(run)を停止する仕組みを作る
ex. (+) : 両辺にreducible?=trueを含む or 両辺Numberインスタンス のみreducible=true

これには，構文より上位の概念が必要
動的意味論: dynamic semantics
静的意味論: static semantics
このへんは9章にて．

#### 2.3.1.4 応用
SIMPLEにはまだ設計判断する要素がある

ex1.SIMPLEは式と文を区別
式:値を返す
文:環境を変える

ex2.SIMPLEは完全簡約されたもののみ代入可能
= 正格評価

これらの要素を変更すると，構文は同じで異なる振る舞いをするSIMPLEが出来る

スモールステップ意味論は，実際に言語の動作を曖昧さなく記述するに向いている
ex1.Scheme
ex2.OCaml

スモールステップ意味論を用い，式をラムダ計算で記述する手法 -> 6.2節にて

### 2.3.2 ビッグステップ意味論(Big Step Semantics)

以下
SSS : Small Step Semantics
BSS : Big Step Semantics

SSS:反復的(iterative)
iterationする抽象機械が必要
入力から新しい出力をひたすら繰り返している
「動作のルール」ではなく「簡約のルール」を定義しているのがSSS

もっと直接的に「動作のルール」を定義できないか?
-> BSS
BSS: 再帰的(recursive)

SSS
- 操作順が明確「この順でやっといて」
- 途中結果が取得しやすい
BSS
- 実行順序は曖昧「これやっといて」
- 結果があるのみ

BSSを実装してみよう
VMはいらない
AST(Abstract Syntax Tree)を走査するだけ
式/文にevaluateを実装するのみでok
まぁやってみましょう

#### 2.3.2.1 式

SSSでは式は簡約可能/不可能で分かれていた(reducible?
BSSではすべての式が評価可能

BSSのゴールはSSSでの動作をモデル化すること
BigStepかSmallStepかというだけで，やることは同じ

Number/Boolean : 自身と同じものと評価される
Variable : 対応する値として評価される

Add/Mul/LT : 部分式を再帰評価し，演算
（どうやるか，ではなくどうあるべきか．関数型っぽいね

#### 2.3.2.2 文
BSSは文記述につよい

SSS: state -> state',env
BSS: state -> env

中間文state'が存在しない!

assign:代入された環境を返す
donothing:与えられた環境を返す
if:conditionにより，cons/altを評価し，結果の環境を返す
sequence:fst評価した結果をもとにsnd評価し，結果の環境を返す
while:condの評価結果がtrueな限りbodyを評価しenv更新し続ける.false時のenvを返す

#### 2.3.2.3 応用

スタックがどれくらい使われるか
SSS:次どれを簡約するか覚えておくだけ
BSS:すべてスタックに積んでる

SICPでいう線形反復 <-> 線形再帰の話
SSSは状態と文を持っていれば再開可能だが，
BSSははじめからやらないとダメ(状態がstack内なので

動作記述にBSSを使った例
Standard ML
W3C - XQuery/XPath

数学的ではなく，Ruby使って手を動かしながらSSS/BSSを学んだよ
数学的だと曖昧さはないけど，抽象的すぎて実際のプログラムはわからない
言語ベースだと，実際の言語理解が必要だけど，そこさえわかれば具体的でわかりやすいよね

## 2.4 表示的意味論

操作的意味論:プログラムをどう動かすか
表示的意味論(denotational semantics):プログラムをどう表現するか？

興味: 言語Aを用いて言語Bを説明すること

ex.walkの意味を説明する
操作的:実際に歩く
表示的:「歩く」in 日本語

もともとはプログラムを数学的オブジェクトに変換するものだった
数学の世界で論証するイメージ
FFT-IFFT的な(時間軸<->周波数軸)

SIMPLE -> Ruby converterを作り，SIMPLEに表示的意味論を与える.
要するにRubyコードへ変換するってこと？
やってみればわかるんじゃない

### 2.4.1 式
SIMPLEにおける値を，Rubyにおけるobjectとして変換するメソッドをつくろう．
(SIMPLEを表現する言語としての)Rubyにおけるprocを用いればok

proc:いわゆるラムダ式(cf.1.2.3

SIMPLE:to_rubyメソッドでRubyにおけるオブジェクトを表すproc文字列を返す
Ruby:proc文字列をevalしてcallすればオブジェクトが得られる


