#lang racket
 
(module reader racket
  (require syntax/strip-context "lexer.rkt" "parser.rkt")
 
  (provide (rename-out [my-read read]
                       [my-read-syntax read-syntax]))

  (define (my-read in)
    (syntax->datum
     (my-read-syntax #f in)))
 
  (define (my-read-syntax src in)
    (with-syntax ([result (sample-parser (lambda () (sample-lexer in)))])
      (strip-context
       #'(module anything racket
           (require sample-racket-language/semantics)
           result)))))