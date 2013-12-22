;; Parser is an object that reads input, extracts tokens, and builds
;; an internal representation of the program that can be evaluated
;;

Parser = Origin mimic

Parser do(
  ;; turn a program-string into a structure we can eval
  ;;
  parse = method(string,
    build_token_list(tokenize(string))
  )

  ;; turn a program-string into a list of tokens
  ;;
  tokenize = method(string,
  	string replaceAll(#/\(/, " ( ") replaceAll(#/\)/, " ) ") split
  )

  ;; turn every token except numbers into symbols
  ;;
  atomize = method(token,
    atom = bind(
      rescue(fn(c, nil)),
      token toRational()
    )
    if(atom, return atom)
    atom = bind(
      rescue(fn(c, nil)),
      token toDecimal()
    )
    if(atom, return atom)
    atom = :(token)
  )

  ;; recursively build a structure from a list of tokens
  ;;
  build_token_list = method(tokens,
    if(tokens length == 0, error!("Unexpected end of input."))
    t = tokens shift!
    ;; recursive case
    if(t == "(",
      list = []
      while(tokens[0] != ")",
        list push!(build_token_list(tokens))
      )
      tokens shift!
      return list
    )
    ;; base case
    if(t == ")",
      error!("Syntax error, unexpected ')'"),
      atomize(t)
    )
  )
)
