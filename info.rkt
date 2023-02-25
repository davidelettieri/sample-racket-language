#lang info
(define collection "my-lang")
(define deps '("base"))
(define build-deps '("scribble-lib" "racket-doc" "rackunit-lib" "parser-tools-lib"))
(define scribblings '(("scribblings/my-lang.scrbl" ())))
(define pkg-desc "Description Here")
(define version "0.0")
(define pkg-authors '(davide))
