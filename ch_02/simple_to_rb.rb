
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
