;; Read-Eval-Print Loop
;;
repl = fn(prompt,
  prompt print
  until((input = sanitize(System in read asText())) == "(quit)",
    val = eval(Parser parse(input))
    to_lisp(val) println
    prompt print
  )
)

;; Turn result back into a Lisp expression
;;
to_lisp = fn(expr,
  if(expr kind == "List",
    "(" + expr map!(x, to_lisp(x)) join(" ") + ")",
    expr asText()
  )
)

;; PROBLEM: Ioke's only function for reading from the STDIN
;; stream doesn't return raw input; it interprets it as
;; Ioke code and adds parens around operands
;;
;; Example: (* 3 3) becomes (*(3 3))
;;
;; See if string contains "<operator>(" pattern, then remove it
;;
sanitize = fn(string,
  pattern = #/([-\*\+=><%\/]{1,2})\(/
  while(m = pattern match(string),
    op = m captures[0]
    matched = m match
    split = string split(matched)
    if(split length > 1,
      ;; remove one set of parens at a time, starting from the left
      ;;
      start = split[0] length
      sanitized = string[start..-1] replace(matched, op + " ") replace(")", "")
      string = split[0] + sanitized,
      ;; else
      ;;
      string = string replace(op + "(", op + " ") replace(")", "")
    )
  )
  string
)
