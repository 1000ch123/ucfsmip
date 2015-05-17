require_relative 'bss'

# 式のテスト
puts Number.new(23).evaluate({})
puts Variable.new(:x).evaluate({:x => Number.new(10)})
puts LessThan.new(Number.new(10), Number.new(20)).evaluate({})


# 文のテスト
statement =
    Sequence.new(
        Assign.new(:x,Number.new(5)),
        Assign.new(:y,Number.new(8))
    )
puts statement.evaluate({})

statement =
    While.new(
        LessThan.new(Variable.new(:x),Number.new(5)),
        Assign.new(:x, Add.new(Variable.new(:x),Number.new(1)))
    )
puts statement.evaluate({:x => Number.new(0)})

