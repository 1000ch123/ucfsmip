require 'rubygems'
require 'treetop'
Treetop.load('simple')

statement = 'while (x < 5) { x = x * 3 }'
parser =  SimpleParser.new
puts parser
puts p = parser.parse(statement)
puts p.to_ast
