;; Evaluate an expression in an environment
;;

eval = fn(x, env global_env,
  cond(
    x kind == "Symbol", env find(x)[x],
    x kind != "List", x,
    x[0] == :quote, x[1..-1],

    x[0] == :if,
    (_, test, t, f) = x
    eval(if(eval(test, env), t, f), env),

    x[0] == :"set!",
    (_, var, value) = x
    env find(x)[x] = eval(value, env),

    x[0] == :define,
    (_, var, value) = x
    env vars[var] = eval(value, env),

    x[0] == :lambda,
    (_, params, func_body) = x
    fn(+args, eval(func_body, Env mimic(params, args, env))),

    x[0] == :begin,
    val = nil
    x[1..-1] each(element, val = eval(element, env))
    val,

    ;; default: a function call
    expressions = x map(expr, eval(expr, env))
    function = expressions shift!
    function(*expressions)  
  )
)
