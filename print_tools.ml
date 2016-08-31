let rec print_list input_list print_function =	match input_list with
	[] -> ()
	| e::l -> print_function e ; print_string "\n" ; print_list l print_function ;;

let print_string_list input_list = print_list input_list print_string ;;

let print_float_list input_list = print_list input_list print_float ;;

let print_int_list input_list = print_list input_list print_int ;;