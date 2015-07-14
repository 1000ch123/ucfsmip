require_relative 'LC'

# 6.2.1
one =
  LCFunction.new(:p,
    LCFunction.new(:x,
      LCCall.new(LCVariable.new(:p), LCVariable.new(:x))
    )
  )
puts one

increment =
  LCFunction.new(:n,
    LCFunction.new(:p,
      LCFunction.new(:x,
        LCCall.new(
          LCVariable.new(:p),
          LCCall.new(
            LCCall.new(LCVariable.new(:n), LCVariable.new(:p)),
            LCVariable.new(:x)
          )
        )
      )
    )
  )

puts increment

add =
  LCFunction.new(:m,
    LCFunction.new(:n,
      LCCall.new(LCCall.new(LCVariable.new(:n), increment), LCVariable.new(:m))
    )
  )
puts add
# 6.2.2
puts "-- Variable replace --"
puts expression = LCVariable.new(:x)
puts expression.replace(:x, LCFunction.new(:y, LCVariable.new(:y)))
puts expression.replace(:z, LCFunction.new(:y, LCVariable.new(:y)))


expression =
  LCCall.new(
    LCCall.new(
      LCCall.new(
        LCVariable.new(:a),
        LCVariable.new(:b)
      ),
      LCVariable.new(:c)
    ),
    LCVariable.new(:b)
  )
puts expression
puts expression.replace(:a, LCVariable.new(:x))
puts expression.replace(:b, LCFunction.new(:x,LCVariable.new(:x)))

puts "-- Function replace --"
expression =
  LCCall.new(
    LCCall.new(
      LCVariable.new(:x),
      LCVariable.new(:y)
    ),
    LCFunction.new(:y,
      LCCall.new(LCVariable.new(:y), LCVariable.new(:x))
    )
  )
puts expression
puts expression.replace(:x, LCVariable.new(:z))
puts expression.replace(:y, LCVariable.new(:z))

puts "-- Function call --"
function =
  LCFunction.new(:x,
    LCFunction.new(:y,
      LCCall.new(LCVariable.new(:x), LCVariable.new(:y))
    )
  )
puts function
puts argument = LCFunction.new(:z, LCVariable.new(:z))
puts function.call(argument)

puts "-- Function reduce --"
puts expression = LCCall.new(LCCall.new(add, one), one)
while expression.reducible?
  puts expression
  expression = expression.reduce
end
puts expression
# なんか期待した形式と違う..?

# 実際にexpressionにinc,zeroを渡してみる
inc, zero = LCVariable.new(:inc), LCVariable.new(:zero)
expression = LCCall.new(LCCall.new(expression, inc), zero)
while expression.reducible?
  puts expression
  expression = expression.reduce
end
puts expression

