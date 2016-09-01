let rec print_list input_list print_function =	match input_list with
	[] -> ()
	| e::l -> print_function e ; print_string "\n" ; print_list l print_function ;;

let print_string_list input_list = print_list input_list print_string ;;

let print_float_list input_list = print_list input_list print_float ;;

let print_int_list input_list = print_list input_list print_int ;;

let print_hashtbl input_hashtbl print_function_key print_function_value =
	Hashtbl.iter (fun key value -> 
	print_function_key key; 
	print_string " -> "; 
	print_function_value value;
	print_string "\n") input_hashtbl ;;
	
let print_hashtbl_str_str input_hashtbl =
	print_hashtbl input_hashtbl print_string print_string ;;