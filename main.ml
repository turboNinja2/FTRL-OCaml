open Maths
open Read_tools
open Train

(* data *)

let train_dict_stream = dict_reader "train_small.csv" ;;

(* parameters *)	

let n = pow 2 20 ;;
let weights = Array.make n 0. ;;
let refresh_loss = 50000 ;;
let alpha = 0.01

(* feature engineering *)

let _get_indices dict n = Hashtbl.fold (fun k v acc -> ((Hashtbl.hash k) lxor (Hashtbl.hash v) mod n)  :: acc) dict [] ;;

let feature_engineer dict =  _get_indices dict n ;;

(* logistic regression *)

let rec _update indices weights step =  match indices with
	| [] -> ()
	| h::tail -> weights.(h) <- (weights.(h) -. step) ; _update tail weights step ;;

let predict indices = sigmoid (dot_product indices weights) ;;

let update indices p y = _update indices weights ((p -. y) *. alpha) ;;

train train_dict_stream feature_engineer update predict log_loss refresh_loss "click";;
