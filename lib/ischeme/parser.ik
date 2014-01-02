;; Parser is an object that reads input, extracts tokens, and builds
;; an internal representation of the program that can be evaluated
;;

Parser = Origin mimic

Parser do(
  ;; turn a program-string into a structure we can eval
  ;;
  parse = method(inport,
    t = next_token(inport)
    if(t === EOFObject, t, build_token_list(t, inport))
  )

  ;; supported atoms: booleans, string literals,
  ;; integers, floats, and symbols
  ;;
  atomize = method(token,
    if(token == "#t", return true)
    if(token == "#f", return false)
    if(token[0..0] == "\"", return token)
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
  build_token_list = method(token, inport,
    if(token == "(",
      list = []
      loop(
        t = next_token(inport)
        if(t == ")", break, list push!(build_token_list(t, inport)))
      )
      return list
    )

    cond(
      token == ")",
      error!("Syntax error, unexpected ')'"),

      token === EOFObject,
      error!("Unexpected end of input."),

      ;; default: turn token into an atom
      atomize(token)
    )
  )

  ;; return the next token, and load a new line if the
  ;; current one is empty
  ;;
  next_token = method(inport,
    loop(
      if(inport line == "", inport line = inport file readLine)
      if(inport line == ".\n", return EOFObject)
      c = tokenizer match(inport line) captures
      token = c[0]
      inport line = c[1]
      if(token == "" nand token startsWith?(";"), break)
    )
    token
  )

  ;; regexp for extracting tokens from a string
  ;;
  tokenizer = #/\s*(,@|[('`,)]|"(?:[\\].|[^\\"])*"|;.*|[^\s('"`,;)]*)(.*)/
)
