open Maths
open Read_tools
open Train

(* data *)

let train_dict_stream = dict_reader "train_small.csv" ;;

(* parameters *)	

let n = pow 2 20 ;;
let weights = Array.make n 0. ;;
let ns = Array.make n 0. ;;

let refresh_loss = 10000 ;;
let alpha = 0.005;;
let beta = 1.;;
let l1 = 0.;;
let l2 = 1.;;
