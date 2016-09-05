(** Various print tools.*)

(** Generic print for lists.*)
let rec print_list input_list print_function =	match input_list with
	[] -> ()
	| e::l -> print_function e ; print_string "\n" ; print_list l print_function ;;

(** Prints a list of strings.*)
let print_string_list input_list = print_list input_list print_string ;;

(** Prints a list of floats.*)
let print_float_list input_list = print_list input_list print_float ;;

(** Prints a list of integers.*)
let print_int_list input_list = print_list input_list print_int ;;

(** Generic print for hashtables.*)
let print_hashtbl input_hashtbl print_function_key print_function_value =
	Hashtbl.iter (fun key value -> 
	print_function_key key; 
	print_string " -> "; 
	print_function_value value;
	print_string "\n") input_hashtbl ;;
	
(** Prints a hastable whose keys and values are strings.*)
let print_hashtbl_str_str input_hashtbl =
	print_hashtbl input_hashtbl print_string print_string ;;
	
