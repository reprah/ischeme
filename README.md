# IScheme

This is a Scheme interpreter I'm writing in Ioke as I read through Peter Norvig's [two articles](http://norvig.com/lispy.html) about doing the same thing in Python. This is a personal project for myself and will never be a complete/standardized Scheme interpreter, but maybe you'll find it interesting anyway.

## REPL Example

It can do bare basics. Will add more soon.

```
$ ioke ~/Code/ischeme/main.ik
ischeme> (define fact (lambda (n) (if (<= n 1) 1 (* n (fact (- n 1))))))
#<LexicalBlock:147E0BA>
ischeme> (fact 10)
3628800
ischeme> (define my_list (list 1 2 3 4 5))
(1 2 3 4 5)
ischeme> (cons (cdr my_list) 6)
(2 3 4 5 6)
ischeme> (if (boolean? #t) "is a boolean" "not a boolean")
"is a boolean"
ischeme> (quit)
```

## To Do

* Add more data types, syntax, macros and recursion (as outlined in Norvig's second article)
* Test coverage with ISpec
* Figure out how to use Ioke's Java integration to circumvent the STDIN-reading issue I'm facing

## Installation

You'll need a Java runtime if you want to install Ioke. If you're on Linux/OSX you could use your package manager to install the openjdk-7-jre package. There are more instructions on [Ioke's website](https://ioke.org/download.html).

Once you have everything set up, you can just run the main.ik file to access the read-eval-print loop!

## License

See LICENSE
