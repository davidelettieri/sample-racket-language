#lang racket

(module+ test
  (require rackunit
           parser-tools/lex
           "lexer.rkt")
  (test-case
   "Tokens are recognized correctly"
   (let* ([in (open-input-string "()+- 123")])
     (check-eqv? (custom-lexer in) 'LPAREN)
     (check-eqv? (custom-lexer in) 'RPAREN)
     (check-eqv? (custom-lexer in) 'ADD)
     (check-eqv? (custom-lexer in) 'SUBTRACT)
     (let ([t (custom-lexer in)])
      (check-eqv? (token-name t) 'NUM)
      (check-eqv? (token-value t) 123)))))