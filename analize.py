import sys
from antlr4 import *
from MyGrammarLexer import MyGrammarLexer
from MyGrammarParser import MyGrammarParser

def main(argv):
    print "Parsing: " + argv[1] + "\n"
    input = FileStream(argv[1])
    lexer = MyGrammarLexer(input)
    stream = CommonTokenStream(lexer)
    parser = MyGrammarParser(stream)
    tree = parser.programa()
    #print(tree.toStringTree(recog=parser))

if __name__ == '__main__':
    main(sys.argv)