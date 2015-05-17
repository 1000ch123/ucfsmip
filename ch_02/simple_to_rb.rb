
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
