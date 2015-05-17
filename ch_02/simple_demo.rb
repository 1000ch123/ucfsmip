require 'rubygems'
require 'treetop'
Treetop.load('simple')

statement = 'while (x < 5) { x = x * 3 }'
parser =  SimpleParser.new
puts tree = parser.parse(statement)
puts tree.to_ast
