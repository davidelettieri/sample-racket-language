[![CI](https://github.com/davidelettieri/sample-racket-language/actions/workflows/ci.yml/badge.svg)](https://github.com/davidelettieri/sample-racket-language/actions/workflows/ci.yml)

# Minimal setup for a racket language with custom syntax

This repo serves as a start project for a new racket language with a custom surface syntax. A parser generator is used to parse a very simple language of aritmetic expression only integers, `+`, `-` and grouping `(..)`. Our sample language supports multiple aritmetic expressions defined on different lines.

Valid expressions in the language are:
```
1+2-(10-2)
```
and
```
4-5
```
and
```
1+2
6+7+9
```
but not
```
1.5-1
```

# How to use it

Run in the root directory of the project

```bash
raco pkg install
```

After that you will be able to use
```
#lang sample-racket-language
```

at the top of your racket files. The `use-language.rkt` file contains a minimal example using the language defined in the repo.

Please note that the language name `sample-racket-language` is defined into the `info.rkt` file with the syntax
```scheme
(define collection "sample-racket-language")
```

The folder structure has been created using 

```bash
raco pkg new sample-racket-language
```

and then customizing the collection name.

## Running the test suite

```
raco test -x -p sample-racket-language
```

## How it works

The project leverages the [parser-tools-lib](https://pkgs.racket-lang.org/package/parser-tools-lib) package to create a parser for the sample language.
The language project is built around three files:
- `lexer.rkt`
- `parser.rkt`
- `main.rkt`

In the `lexer.rkt` file we define the tokens of the language differentiating between tokens that are carrying a value with them (for example number literals), using `define-tokens`, and tokens that have no value (for example parenthesis), using `define-empty-tokens`.

In the `parser.rkt` we use the tokens defined in the `lexer.rkt` file to define our parser. The parser will return a tree describing the expression using custom functions `add`,`multiply`,`subtract`,`divide` where by custom I mean that racket doesn't provide functions nor macros with these names by default. 

The `main.rkt` contains the required macros, the required exports and brings everything together defining the language module with a reader submodule.

```scheme
(module reader racket 
    ...)
```

where we provide the `read` and `read-syntax` functions as required when creating a language with a custom surface syntax. The module definition part is sourced from the [racket official documentation](https://docs.racket-lang.org/guide/language-collection.html).

# Resources

[This](https://school.racket-lang.org/2019/plan/index.html) is an awesome resource about macros and languages.
