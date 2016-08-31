#use "read_tools.ml";;
#use "print_tools.ml";;
#load "str.cma";;
	
(* indices is a list of int and weights is a float array *)

let dot_product indices weights =
    let rec aux indices weights acc = 
		match indices with
		| [] -> acc
		| h::tail -> aux tail weights (acc +. weights.(h)) in
	aux indices weights 0. in
	
let sigmoid x = 1. /. (1. +. exp(0. -. (max (min x 35.) (-35.)))) in 

let log_loss p y = match y with 1. -> -. log(p) | _ -> -. log(1. -. p) in

(* logistic regression *)

let predict indices weights = sigmoid (dot_product indices weights) in

let rec update indices weights p y alpha =  match indices with
	| [] -> ()
	| h::tail -> weights.(h) <- (weights.(h) +. (p -. y) *. alpha) ; update tail weights p y alpha in

let split_line line separator = Str.split (Str.regexp separator) line in 

print_string_list (split_line (read_first_line "train.csv") csv_separator);

print_float (dot_product (1::[])[|3.;2.;1.|]);
print_string "\n";
print_float (dot_product (0::1::[])[|3.;2.;1.|]);
print_string "\n";
print_float (sigmoid 0.);
print_string "\n";
print_float (sigmoid 100.);
print_string "\n";
print_float (sigmoid (-100.));
print_string "\n";
print_float (log_loss 0.5 1.);
print_string "\n";
print_float (log_loss 0.5 0.);
print_string "\n";
print_int (Hashtbl.hash "lol") ;; 


