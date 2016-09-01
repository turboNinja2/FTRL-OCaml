(* indices is a list of int and weights is a float array *)

let dot_product indices weights =
    let rec aux indices weights acc = 
		match indices with
		| [] -> acc
		| h::tail -> aux tail weights (acc +. weights.(h)) in
	aux indices weights 0. ;;
	
let sigmoid x = 1. /. (1. +. exp(0. -. (max (min x 35.) (-35.)))) ;;

let log_loss p y = match y with 1. -> -. log(p) | _ -> -. log(1. -. p) ;;

let rec pow a = function
  | 0 -> 1
  | 1 -> a
  | n -> 
    let b = pow a (n / 2) in
    b * b * (if n mod 2 = 0 then 1 else a) ;;