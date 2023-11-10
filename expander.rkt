#lang racket

(provide #%module-begin ; required for a language module
         #%app ; required to have function call
         (rename-out [srl:datum #%datum])) ; required to have datum literal support

(require (for-syntax syntax/parse))


(define-syntax (srl:datum stx)
  (syntax-parse stx
    [(_ . s:number) #'(#%datum . s)]
    [(_ . other)
     (raise-syntax-error 'sample-racket-language
                         "only literal numbers are allowed"
                         #'other)]))

(define-syntax-rule (subtract a ...) (- a ...))
(define-syntax-rule (add a ...) (+ a ...))
(define-syntax-rule (multiply a ...) (* a ...))
(define-syntax-rule (divide a ...) (/ a ...))

(provide subtract
         add
         multiply
         divide)