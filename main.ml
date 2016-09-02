open Maths
open Read_tools

(* feature engineering *)

let get_indices dict n = Hashtbl.fold (fun k v acc -> ((Hashtbl.hash k) lxor (Hashtbl.hash v) mod n)  :: acc) dict [] ;;

(* logistic regression *)

let predict indices weights = sigmoid (dot_product indices weights) ;;

let rec update indices weights p y alpha =  match indices with
	| [] -> ()
	| h::tail -> weights.(h) <- (weights.(h) -. (p -. y) *. alpha) ; update tail weights p y alpha ;;
	
(* parameters *)	

let n = pow 2 20 ;;
let weights = Array.make n 0. ;;
let dict_stream = dict_reader "train_small.csv" ;;
let updater indices weights p y = update indices weights p y 0.01 ;;
let refresh_loss = 1000000 ;;

(* training *)

let train weights updater dict_stream = 
	let rec aux weights updater dict_stream t loss n = match (try Some( Stream.next dict_stream) 
								  with _ -> None) with
	| Some dict -> Hashtbl.remove dict "id"; 
			  let y = float_of_string (Hashtbl.find dict "click") in
			  Hashtbl.remove dict "click";
			  let indices = get_indices dict n in
			  let p = predict indices weights in
			  updater indices weights p y;
			  
			  if ((t mod refresh_loss) == 0) && t > 0 then begin 
				  print_float (loss /. float_of_int(t)); 
				  print_endline " "; 
			  end;
			  
			  aux weights updater dict_stream (t + 1) (loss +. (log_loss p y)) n
			  
	| None -> () in aux weights updater dict_stream 0 0. (Array.length weights);;	

train weights updater dict_stream;
