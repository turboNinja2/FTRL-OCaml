open Maths
open Read_tools
open Train

(* parameters *)	

let n = int_of_float(2. ** 20.)

(** Vector of weights *)
let w = Array.make n 0.

let ns = Array.make n 0.

let zs = Array.make n 0.

(** Print information every refresh_loss lines*)
let refresh_loss = 1000000

(** Parameter of the model *)
let alpha = 0.005
(** Parameter of the model *)
let beta = 1.
(** Parameter of the model *)
let l1 = 0.
(** Parameter of the model *)
let l2 = 1.

(* feature engineering *)

let _get_indices dict n = Hashtbl.fold (fun k v acc -> ((Hashtbl.hash k) lxor (Hashtbl.hash v) mod n)  :: acc) dict [] 

let feature_engineer dict =  _get_indices dict n 

(* FTRL *)

let rec ftrl_update indices p y = match indices with
  | [] -> ()
  | h::tail -> let g = (p -. y) in
               let sigma = (sqrt(ns.(h) +. g *. g) -. sqrt(ns.(h))) /. alpha in
	       zs.(h) <- (zs.(h) +. g -. sigma *. w.(h));
               ns.(h) <- (ns.(h) +. g *. g) ;
	       ftrl_update tail p y 
		
let _ftrl_predict indices w zs ns alpha beta l1 l2 =
	let rec aux indices acc = match indices with
	| [] -> acc
	| h::tail -> let s = sign_of_float (zs.(h)) in
		     if (s *. zs.(h)) <= l1 then begin 
			w.(h) <- 0.
		     end
		     else begin
			w.(h) <- (s *. l1 -. zs.(h)) /. ((beta +. sqrt(ns.(h)))/. alpha +. l2) 
		     end;
	             aux tail (acc +. w.(h)) in sigmoid (aux indices 0.)

let ftrl_predict indices = _ftrl_predict indices w zs ns alpha beta l1 l2

let train_dict_stream = dict_reader "train_small.csv"
 				
let () = train train_dict_stream feature_engineer ftrl_update ftrl_predict log_loss refresh_loss "click"
