
class LCVariable < Struct.new(:name)
  def to_s
    name.to_s
  end

  def inspect
    to_s
  end

  def replace(name, replacement)
    if self.name == name
      replacement
    else
      self
    end
  end

  def callable?
    false
  end

  def reducible?
    false
  end
end

class LCFunction < Struct.new(:parameter, :body)
  def to_s
    "-> #{parameter} { #{body}}"
  end

  def inspect
    to_s
  end

  def replace(name, replacement)
    if parameter == name
      self
    else
      LCFunction.new(parameter, body.replace(name, replacement))
    end
  end

  def call(argument)
    body.replace(parameter, argument)
  end

  def callable?
    true
  end

  def reducible?
    false
  end

end

class LCCall < Struct.new(:left, :right)
  def to_s
    "#{left}[#{right}]"
  end

  def inspect
    to_s
  end

  def replace(name, replacement)
    LCCall.new(left.replace(name, replacement), right.replace(name, replacement))
  end

  def callable?
    false
  end

  def reducible?
    left.reducible? || right.reducible? || left.callable?
  end

  def reduce
    if left.reducible?
      LCCall.new(left.reduce, right)
    elsif right.reducible?
      LCCall.new(left, right.reduce)
    else
      left.call(right)
    end
  end
end

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

