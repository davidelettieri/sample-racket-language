#lang racket/base

(require parser-tools/lex)

(define-tokens basic-tokens (NUM))
(define-empty-tokens punct-tokens (LPAREN RPAREN EOF ADD SUBTRACT DIVIDE MULTIPLY))

; In order to get the tokens from the sample-lexer we need a PORT and then call repeatedly the 
; sample-lexer function with that PORT has an input
; eg
; (define in (open-input-string "(1+2)"))
; (sample-lexer in) -> returns 'LPAREN
; (sample-lexer in) -> returns (token 'NUM 1)
(define sample-lexer
    (lexer-src-pos
      [(eof) (token-EOF)]
      ["(" (token-LPAREN)]
      [")" (token-RPAREN)]
      ["+" (token-ADD)]
      ["-" (token-SUBTRACT)]
      ["*" (token-MULTIPLY)]
      ["/" (token-DIVIDE)]
      [(repetition 1 +inf.0 numeric) (token-NUM (string->number lexeme))]
      ; invoke the lexer again to skip the current token
      ; the return-without-pos call is needed to avoid a "double" wrapping into a position token
      ; ref. https://github.com/racket/parser-tools/blob/b08f6137a3c067720c4b4723dd726652af288e97/parser-tools-lib/parser-tools/yacc.rkt#L247
      [whitespace (return-without-pos (sample-lexer input-port))]))

(provide sample-lexer basic-tokens punct-tokens)