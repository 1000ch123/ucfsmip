require_relative 'sss'


# 簡約計算
puts "1:加算"
exp = Add.new(
    Multiply.new(Number.new(1),Number.new(2)),
    Multiply.new(Number.new(3),Number.new(4))
)

env = {}
Machine.new(exp,env).run

puts "\n比較演算"
exp = LessThan.new(
    Number.new(5),
    Add.new(Number.new(2), Number.new(2))
)
Machine.new(exp,env).run


# 変数を使う
exp = Add.new(
    Variable.new(:x), Variable.new(:y)
)

env = {
    x: Number.new(3),
    y: Number.new(5)
}

puts "\n変数"
Machine.new(exp,env).run

# 文を扱う
puts "\n代入文"
state = Assign.new(
    :x, Add.new(Variable.new(:x), Number.new(1))
)

env = {
    x: Number.new(2)
}

StatementMachine.new(state, env).run

puts "\nif-else文"
state = If.new(
    Variable.new(:x),
    Assign.new(:y, Number.new(1)),
    Assign.new(:y, Number.new(2))
)

env = {
    x: Boolean.new(true)
}

StatementMachine.new(state, env).run

puts "\nif文"
state = If.new(
    Variable.new(:x),
    Assign.new(:y, Number.new(1)),
    DoNothing.new
)

env = {
    x: Boolean.new(false)
}

StatementMachine.new(state, env).run

puts "\nsequence文"
state = Sequence.new(
    Assign.new(:x, Number.new(1)),
    Assign.new(:y, Number.new(2)),
)

env = {
}

StatementMachine.new(state, env).run


