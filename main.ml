#use "read_tools.ml";;
#use "print_tools.ml";;
#use "maths.ml"	


(* logistic regression *)

let predict indices weights = sigmoid (dot_product indices weights) in

let rec update indices weights p y alpha =  match indices with
	| [] -> ()
	| h::tail -> weights.(h) <- (weights.(h) +. (p -. y) *. alpha) ; update tail weights p y alpha in
	
() ;
