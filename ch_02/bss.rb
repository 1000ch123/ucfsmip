# Big Step Semantics


class Number < Struct.new(:value)
    def to_s
        value.to_s
    end

    def inspect
        "<<#{self}>>"
    end

    def evaluate(environment)
        self
    end
end

class Boolean < Struct.new(:value)
    def to_s
        value.to_s
    end

    def inspect
        "<<#{self}>>"
    end

    def evaluate(environment)
        self
    end
end

class Variable < Struct.new(:name)
    def to_s
        name.to_s
    end

    def inspect
        "<<#{self}>>"
    end

    def evaluate(environment)
        environment[name]
    end
end

class Add < Struct.new(:left, :right)
    def evaluate(environment)
        Number.new(left.evaluate(environment).value + right.evaluate(environment).value)
    end
end

class Multiply < Struct.new(:left, :right)
    def evaluate(environment)
        Number.new(left.evaluate(environment).value * right.evaluate(environment).value)
    end
end

class LessThan < Struct.new(:left, :right)
    def evaluate(environment)
        Boolean.new(left.evaluate(environment).value < right.evaluate(environment).value)
    end
end

# 実行してみよう
puts Number.new(23).evaluate({})
puts Variable.new(:x).evaluate({:x => Number.new(10)})
puts LessThan.new(Number.new(10), Number.new(20)).evaluate({})

# 文
class DoNothing
    def evaluate(environment)
        environment
    end
end

class Assign < Struct.new(:name, :expression)
    def evaluate(environment)
        environment.merge({ name => expression.evaluate(environment) })
    end
end

class If < Struct.new(:condition, :consequence, :alternative)
    def evaluate(environment)
        case condition.evaluate(environment)
        when Boolean.new(true)
            consequence.evaluate(environment)
        when Boolean.new(false)
            alternative.evaluate(environment)
        end
    end
end

class Sequence < Struct.new(:first, :second)
    def evaluate(environment)
        second.evaluate(first.evaluate(environment))
    end
end

class While < Struct.new(:condition, :body)
    def evaluate(environment)
        case condition.evaluate(environment)
        when Boolean.new(true)
            evaluate(body.evaluate(environment))
        when Boolean.new(false)
            environment
        end
    end
end

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

