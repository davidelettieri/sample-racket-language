#lang racket

(require parser-tools/yacc
         "lexer.rkt")


(define the-parser
    (parser
      [start expr]
      [end EOF]
      [error void]
      [tokens basic-tokens punct-tokens]
      [grammar
       [expr [(LPAREN exprs RPAREN) $2]
             [(NUM) $1]
             [(expr SUBTRACT expr) (- $1 $3)]
             [(expr ADD expr) (+ $1 $3)]]
       [exprs [() '()]
              [(expr exprs) (cons $1 $2)]]]))

(provide the-parser)