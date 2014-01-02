;; IScheme: A Scheme interpreter in Ioke
;;

System loadPath <<(System currentDirectory)

use("ischeme/eval.ik")
use("ischeme/parser.ik")
use("ischeme/env.ik")
use("ischeme/utils.ik")
use("ischeme/inport.ik")

;; setup the initial environment
global_env = Env mimic
global_env add_globals

;; set up the IO stream we get data from
i = InPort mimic(System in)

repl("ischeme> ", i)
