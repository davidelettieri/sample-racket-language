#lang racket/base

(require parser-tools/yacc
         parser-tools/lex
         "lexer.rkt")


; (struct srcloc (source line column position span))
(define (positions->srcloc start-pos end-pos)
  (srcloc #f
          (position-line start-pos)
          (position-col start-pos)
          (position-offset start-pos)
          (- (position-offset end-pos) (position-offset start-pos))))

; docs for datum->syntax
; https://docs.racket-lang.org/reference/stxops.html#%28def._%28%28quote._~23~25kernel%29._datum-~3esyntax%29%29
(define (position-token->syntax val start-pos end-pos)
  (datum->syntax #f val (positions->srcloc start-pos end-pos)))

(define the-parser
  (parser
   [start expr]
   [end EOF]
   [error void]
   [src-pos]
   [tokens basic-tokens punct-tokens]
   [precs (left SUBTRACT ADD)]
   [grammar
          ; the start position of a parenthesized expression is the start position of the open '('
    [expr [(LPAREN expr RPAREN) (position-token->syntax $2 $1-start-pos $3-end-pos)] 
          ; the start position of a number is the start position of the number token
          [(NUM) (position-token->syntax $1 $1-start-pos $1-end-pos)]
          ; the start position of a subtract expression is the start position of the first expression
          [(expr SUBTRACT expr) (position-token->syntax `(subtract ,$1 ,$3) $1-start-pos $3-end-pos)]
          ; the start position of an add expression is the start position of the first expression 
          [(expr ADD expr) (position-token->syntax `(add ,$1 ,$3) $1-start-pos $3-end-pos)]]
    ]))

(provide the-parser)