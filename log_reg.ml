open Maths
open Read_tools
open Train

(* data *)

let train_dict_stream = dict_reader "train_small.csv" 

(* parameters *)	

(** Number of slots to store the features*)
let n = 2 ** 20 

(** Vector of weights for the features *)
let weights = Array.make n 0. 

(** Print progress every refresh_loss lines *)
let refresh_loss = 1000000 

(** Parameter of the model *)
let alpha = 0.01

(* feature engineering *)

let _get_indices dict n = Hashtbl.fold (fun k v acc -> ((Hashtbl.hash k) lxor (Hashtbl.hash v) mod n)  :: acc) dict [] 

let feature_engineer dict =  _get_indices dict n 

(* logistic regression *)

let _update idxs ws step = 
   List.iter (fun idx -> ws.(idx) <- ws.(idx) -. step) idxs

let predict indices = sigmoid (dot_product indices weights) 

let update indices p y = _update indices weights ((p -. y) *. alpha) 

let () = train train_dict_stream feature_engineer update predict log_loss refresh_loss "click"
