#load "str.cma";;


let csv_separator = "," ;;


let try_read_line input_channel =
    try Some (input_line input_channel) with End_of_file -> None ;;

	
let read_lines file_path =
  let input_channel = open_in file_path in
  let rec loop acc = match try_read_line input_channel with
    | Some s -> loop (s :: acc)
    | None -> close_in input_channel; List.rev acc in
  loop [] ;;


let read_first_line file_path = 
    match (read_lines file_path) with
	| [] -> failwith "Failed to read first line !"
    | h::tail -> h ;;

	
let split_line line separator = Str.split (Str.regexp separator) line ;;


let concat_elements list1 list2 = 
	let rec aux list1 list2 acc = match list1,list2 with
	| [],[] -> acc
	| a,[] -> failwith "Incompatible line size"
	| [],a -> failwith "Incompatible line size"
	| h1::t1,h2::t2 -> aux t1 t2 ((h1^h2)::acc) in List.rev (aux list1 list2 []) ;;