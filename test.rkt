#lang racket

(module+ test
  (require rackunit
           parser-tools/lex
           "lexer.rkt")
  (test-case
   "Tokens are recognized correctly"
   (let* ([in (open-input-string "()+- 123")])
     (check-eqv? (position-token-token (custom-lexer in)) 'LPAREN)
     (check-eqv? (position-token-token (custom-lexer in)) 'RPAREN)
     (check-eqv? (position-token-token (custom-lexer in)) 'ADD)
     (check-eqv? (position-token-token (custom-lexer in)) 'SUBTRACT)
     (let ([t (custom-lexer in)])
      (check-eqv? (token-name (position-token-token t)) 'NUM)
      (check-eqv? (token-value (position-token-token t)) 123)))))