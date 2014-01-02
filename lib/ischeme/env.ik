;; Env is an object representing the program's environment/scoping
;;

Env = Origin mimic

Env do(
  ;; a dictionary of key-value pairs, the environment
  ;;
  initialize = method(params [], args [], outer_env nil,
    self vars = {}
    self outer = outer_env
    self vars addKeysAndValues(params, args)
  )

  ;; return the innermost scope where a variable is defined
  ;;
  find = method(var,
    if(self vars key?(var),
      self vars,
      bind(
        rescue(fn(c, error!("Undefined local variable or method: #{var}"))),
        self outer find(var)
      )
    )
  )

  add_globals = method(
    self vars += {
      :"+" => fn(x,y, x+y),
      :"-" => fn(x,y, x-y),
      :"*" => fn(x,y, x*y),
      :"/" => fn(x,y, x/y),
      :"<=" => fn(x,y, x <= y),
      :">=" => fn(x,y, x >= y),
      :">" => fn(x,y, x > y),
      :"<" => fn(x,y, x < y),
      :"%" => fn(x,y, x % y),
      :"modulo" => fn(x,y, x % y),
      :"not" => fn(x,y, x != y),
      :"eq" => fn(x,y, x kind == y kind),
      :"car" => fn(x, x[0]),
      :"cdr" => fn(x, x[1..-1]),
      :"cons" => fn(x,y, x push!(y)),
      :"length" => fn(x, x length),
      :"list" => fn(+x, x),
      :"list?" => fn(x, x kind == "List"),
      :"equal?" => fn(x,y, x == y)
      :"boolean?" => fn(x, x == false || x == true)
    }
  )
)
