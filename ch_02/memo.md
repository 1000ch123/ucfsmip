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

