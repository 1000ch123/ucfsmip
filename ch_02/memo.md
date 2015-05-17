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

