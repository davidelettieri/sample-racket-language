#lang racket

(require parser-tools/lex)

(define-tokens basic-tokens (NUM))
(define-empty-tokens punct-tokens (LPAREN RPAREN EOF ADD SUBTRACT))

; In order to get the tokens from the custom-lexer we need a PORT and then call repeatedly the 
; custom-lexer function with that PORT has an input
; eg
; (define in (open-input-string "(1+2)"))
; (custom-lexer in) -> returns 'LPAREN
; (custom-lexer in) -> returns (token 'NUM 1)
(define custom-lexer
    (lexer
      [(eof) (token-EOF)]
      ["(" (token-LPAREN)]
      [")" (token-RPAREN)]
      ["+" (token-ADD)]
      ["-" (token-SUBTRACT)]
      [(repetition 1 +inf.0 numeric) (token-NUM (string->number lexeme))]
      ; invoke the lexer again to skip the current token
      [whitespace (custom-lexer input-port)]))

(provide custom-lexer basic-tokens punct-tokens)