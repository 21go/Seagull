
# Seagull (海鸥)
Authors: Greg Ou, Charles Yoon, Jennifer Huang

## Build Instructions

1. Compile using one of two options: 

    1. [Dune](https://dune.readthedocs.io/en/stable/overview.html) 
        ```
        dune build
        ```
    2. ocamlbuild main.native


2. Run the executable
```
./_build/default/main.exe
```

### Files
Compiler
* `ast.ml`: abstract syntax tree (AST) definition
* `scanner.mll`: scanner
* `parser.mly`: parser
* `main.ml`: Ocaml compiler and AST pretty printing

Testing
* `fibonacci.ou`: a Seagull program calculating the n-th fibonacci number
* `gcd.ou`: a Seagull program calculating the greatest common denominator between two numbers
* `greg.ou`: our "Hello World" Seagull program!

## Progress

As of this submission, we have completed the scanner and parser, along with AST definitions and an AST pretty printer; our test files confirmed that the scanner and parser work properly. 

For our final project submission, we'll need to create a semantic checker, along with more programs in Seagull to test functionality; everything else so far seems to be working. We expect to be able to finish the semantic checker within a week, and the example programs should be able to be completed in a day; our demo should be ready and functioning for the final presentation.

## Author Notes

* The output of our parser main program shows the Chinese code translated into English, so that, at a glance, we can confirm that we have parsed correctly.

* We initially encountered challenges with lexing Chinese characters and punctuation. While we initially opted for Sedlex as a lexer generator, believing that Ocamllex lacked Unicode support, we later discovered that Ocamllex is indeed Unicode-compatible. Much effort was devoted to ensuring Ocamllex compatibility with Unicode, particularly in formatting Unicode codepoints. Ultimately, we streamlined our approach by incorporating only the 2500 most commonly used Chinese characters (from 0x4E00 to 0x9FFF), which may result in our programming language not recognizing some input characters.
