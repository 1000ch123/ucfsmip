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
    def to_s
        "#{left} < #{right}"
    end

    def inspect
        "«#{self}»"
    end

    def evaluate(environment)
        Number.new(left.evaluate(environment).value + right.evaluate(environment).value)
    end
end

class Multiply < Struct.new(:left, :right)
    def to_s
        "#{left} < #{right}"
    end

    def inspect
        "«#{self}»"
    end

    def evaluate(environment)
        Number.new(left.evaluate(environment).value * right.evaluate(environment).value)
    end
end

class LessThan < Struct.new(:left, :right)
    def to_s
        "#{left} < #{right}"
    end

    def inspect
        "«#{self}»"
    end

    def evaluate(environment)
        Boolean.new(left.evaluate(environment).value < right.evaluate(environment).value)
    end
end

# 実行してみよう
puts Number.new(23).evaluate({})
puts Variable.new(:x).evaluate({:x => Number.new(10)})
puts LessThan.new(Number.new(10), Number.new(20)).evaluate({})
