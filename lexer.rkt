#lang racket

(require parser-tools/lex)

(define-tokens basic-tokens (NUM))
(define-empty-tokens punct-tokens (LPAREN RPAREN EOF ADD SUBTRACT))

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