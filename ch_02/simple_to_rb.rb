
class Number < Struct.new(:value)
    def to_ruby
        "-> e { #{value.inspect} }"
    end

end

class Boolean < Struct.new(:value)
    def to_ruby
        "-> e { #{value.inspect} }"
    end
end

# SIMPLEの世界から共通世界へ(stringを介している)
proc_str = Number.new(10).to_ruby
# 共通世界からRuby世界へ(stringをRuby世界のモノとしてeval)
proc = eval(proc_str)
# Ruby世界オブジェクトへ変換
puts proc.call({})


proc = eval(Boolean.new(true).to_ruby)
puts proc.call(0) # procはラムダ式.Number/Booleanでは引数なんでもok

class Variable < Struct.new(:name)
    def to_ruby
        "-> e { e[#{name.inspect}]}"
    end
end

exp = Variable.new(:x) # SIMPLE式
proc_str = exp.to_ruby # proc文字列
puts proc_str
proc = eval(proc_str)  # procオブジェクト
val = proc.call({:x => 8}) # 環境を与えcall
puts val


class Add < Struct.new(:left, :right)
    def to_ruby
        "-> e { (#{left.to_ruby}).call(e) + (#{right.to_ruby}).call(e) }"
    end
end

class Multiply < Struct.new(:left, :right)
    def to_ruby
        "-> e { (#{left.to_ruby}).call(e) * (#{right.to_ruby}).call(e) }"
    end
end

class LessThan < Struct.new(:left, :right)
    def to_ruby
        "-> e { (#{left.to_ruby}).call(e) > (#{right.to_ruby}).call(e) }"
    end
end

exp = Add.new(Number.new(3), Number.new(5))
proc_str = exp.to_ruby
puts proc_str
proc = eval(proc_str)
val = proc.call({})
puts val

class Assign < Struct.new(:name, :expression)
    def to_ruby
        "-> e { e.merge({ #{name.inspect} => (#{expression.to_ruby}).call(e) }) }"
    end
end

exp = Assign.new(:x, Number.new(4))
proc_str = exp.to_ruby
puts proc_str
proc = eval(proc_str)
val = proc.call({})
puts val

class DoNothing
    def to_ruby
        "-> e { e }"
    end
end
