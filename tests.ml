#use "read_tools.ml";;
#use "print_tools.ml";;
#use "maths.ml";;

print_string_list (split_line (read_first_line "train.csv"));
print_string_list (split_line (read_first_line "train.csv"));
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
print_int (Hashtbl.hash "lol") ;
print_string "\n";
print_string_list (concat_elements ("a"::"b"::[]) ("c"::"d"::[]));
print_string "\n";
print_int (Hashtbl.length (to_dict ("a"::"b"::[]) ("c"::"d"::[])));
print_string "\n";
print_hashtbl_str_str (to_dict ("a"::"b"::[]) ("c"::"d"::[]));
print_string "\n";

let dict_stream = dict_reader "train.csv" in

print_hashtbl_str_str (Stream.next dict_stream);
print_string "\n";
print_hashtbl_str_str (Stream.next dict_stream);
print_string "\n";
print_hashtbl_str_str (Stream.next dict_stream);

print_string "\n";
 