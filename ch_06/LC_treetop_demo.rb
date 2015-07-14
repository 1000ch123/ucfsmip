require 'rubygems'
require 'treetop'
Treetop.load('LC')

statement = "-> x { x[x] }[-> y { y }]"
parser =  LambdaCalculusParser.new
puts tree = parser.parse(statement)
puts tree.to_ast
puts tree.to_ast.reduce
puts tree.to_ast.reduce.reduce
