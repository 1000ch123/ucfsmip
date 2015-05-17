require_relative 'ds'

# Number
# SIMPLEの世界から共通世界へ(stringを介している)
proc_str = Number.new(10).to_ruby
# 共通世界からRuby世界へ(stringをRuby世界のモノとしてeval)
proc = eval(proc_str)
# Ruby世界オブジェクトへ変換
puts proc.call({})

# Boolean
proc = eval(Boolean.new(true).to_ruby)
puts proc.call(0) # procはラムダ式.Number/Booleanでは引数なんでもok


# Variable
exp = Variable.new(:x) # SIMPLE式
proc_str = exp.to_ruby # proc文字列
puts proc_str
proc = eval(proc_str)  # procオブジェクト
val = proc.call({:x => 8}) # 環境を与えcall
puts val

# Add
exp = Add.new(Number.new(3), Number.new(5))
proc_str = exp.to_ruby
puts proc_str
proc = eval(proc_str)
val = proc.call({})
puts val

# Assign
exp = Assign.new(:x, Number.new(4))
proc_str = exp.to_ruby
puts proc_str
proc = eval(proc_str)
val = proc.call({})
puts val

# while
statement = While.new(
    LessThan.new(Variable.new(:x),Number.new(5)),
    Assign.new(:x, Add.new(Variable.new(:x), Number.new(1)))
)
proc_str = statement.to_ruby
puts proc_str
proc = eval(proc_str)
val = proc.call({:x => 1})
puts val


