open Maths
open Read_tools
open Train

(* data *)

let train_dict_stream = dict_reader "train_small.csv" ;;

(* parameters *)	

let n = pow 2 20 ;;
let weights = Array.make n 0. ;;
let ns = Array.make n 0. ;;
let zs = Array.make n 0. ;;

let refresh_loss = 10000 ;;
let alpha = 0.005;;
let beta = 1.;;
let l1 = 0.;;
let l2 = 1.;;


(* feature engineering *)

let _get_indices dict n = Hashtbl.fold (fun k v acc -> ((Hashtbl.hash k) lxor (Hashtbl.hash v) mod n)  :: acc) dict [] ;;

let feature_engineer dict =  _get_indices dict n ;;

(* FTRL *)

let rec update indices x p y = match indices with
  |[]->()
  |h::tail -> let g = (p -. y) in
              let sigma = (sqrt(ns.(h) +. g *. g) -. sqrt(ns.(h))) /. alpha in
			  zs.(h) <- zs.(h) +. g -. sigma *. weights.(h);
			  ns.(h) <- ns.(h) +. g *. g ;
			  update tail x p y ;; 
		
let predict indices = 
	let rec aux indices acc = match indices with
	|[]-> acc
	|h::tail -> let s = sign_of_float (zs.(h)) in
				if (s *. zs.(h)) <= l1 then 
					weights.(h) <- 0.
				else 
					weights.(h) <- (s *. l1 -. zs.(h)) /. ((beta +. sqrt(ns.(h) ))/. alpha +. l2);
				aux tail (acc +. weights.(h)) in sigmoid (aux indices 0.) ;;
				
train train_dict_stream feature_engineer update predict log_loss refresh_loss "click";;
