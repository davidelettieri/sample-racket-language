#lang racket

(module+ test
  (require rackunit
           parser-tools/lex
           "lexer.rkt"
           "parser.rkt"
           "semantics.rkt")

  (define (parse-string s)
    (let ([in (open-input-string s)])
      (sample-parser (lambda () (sample-lexer in)))))

  (test-case
   "Tokens are recognized correctly"
   (let ([in (open-input-string "()+-*/ 123")])
     (check-eqv? (position-token-token (sample-lexer in)) 'LPAREN)
     (check-eqv? (position-token-token (sample-lexer in)) 'RPAREN)
     (check-eqv? (position-token-token (sample-lexer in)) 'ADD)
     (check-eqv? (position-token-token (sample-lexer in)) 'SUBTRACT)
     (check-eqv? (position-token-token (sample-lexer in)) 'MULTIPLY)
     (check-eqv? (position-token-token (sample-lexer in)) 'DIVIDE)
     (let ([t (sample-lexer in)])
       (check-eqv? (token-name (position-token-token t)) 'NUM)
       (check-eqv? (token-value (position-token-token t)) 123))))
  (test-case
   "Simple expression are parsed correctly"
   (let ([sources (list 
                    '("2+2" . (add 2 2))
                    '("2-2" . (subtract 2 2))
                    '("2*3" . (multiply 2 3))
                    '("2/3" . (divide 2 3))
                    '("2+3*2" . (add 2 (multiply 3 2))))])
     (for-each
      (lambda (el) (check-equal? (syntax->datum (parse-string (car el))) (cdr el))) sources))))