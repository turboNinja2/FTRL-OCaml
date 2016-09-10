open Maths
open Read_tools
open Print_tools
open Trees
open Splitter

let dict_stream = dict_reader "train.csv" ;;

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
print_int (Hashtbl.length (to_dict ("a"::"b"::[]) ("c"::"d"::[])));
print_string "\n";
print_hashtbl_str_str (to_dict ("a"::"b"::[]) ("c"::"d"::[]));
print_string "\n";


print_hashtbl_str_str (Stream.next dict_stream);
print_string "\n";
print_hashtbl_str_str (Stream.next dict_stream);
print_string "\n";
print_hashtbl_str_str (Stream.next dict_stream);

print_string "\n";


draw_int_tree (Node(Leaf(1),0,Node(Node(Leaf(4),5,Leaf(6)),2,Leaf(3))));

print_string "\n";
print_int (sign_of_int 100);
print_string "\n";
print_int (sign_of_int (-100));
print_string "\n";
print_int (sign_of_int 0);
print_string "\n";
print_float (sign_of_float 0.);
