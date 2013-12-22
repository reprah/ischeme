;; IScheme: A Scheme interpreter in Ioke
;;

System loadPath <<(System currentDirectory)

use("lib/eval.ik")
use("lib/parser.ik")
use("lib/env.ik")
use("lib/utils.ik")

;; setup the initial environment
global_env = Env mimic
global_env add_globals

repl("ischeme> ")
