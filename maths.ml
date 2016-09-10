(** Various mathematical functions*)


(** Given a list of indices v  and a vector of weights *)
let dot_product indices weights =
    let rec aux indices weights acc = 
		match indices with
		| [] -> acc
		| h::tail -> aux tail weights (acc +. weights.(h)) in
	aux indices weights 0.

(** Evaluates {%latex: $s(x)=\frac{1}{1+\exp(-x)}$ %}*)	
let sigmoid x = 1. /. (1. +. exp(0. -. x))

(** Logarithmic loss, p (the first argument) is the predicted value, y (the second argument) is the actual value*)
let log_loss p y = match y with 1. -> -. log(p) | _ -> -. log(1. -. p)

(** Evaluates {%latex: $a^b$ %} where {%latex: $a$ %} is the first argument, {%latex: $b$ %} the second argument*)
let rec pow a = function
  | 0 -> 1
  | 1 -> a
  | n -> 
    let b = pow a (n / 2) in
    b * b * (if n mod 2 == 0 then 1 else a) 

(** Returns 1 if the input is nonnegative, -1 otherwise *)
let sign_of_int z = if z >= 0 then 1 else -1

(** Returns 1. if the input is nonnegative, -1. otherwise *)
let sign_of_float z = if z >= 0. then 1. else -1.
