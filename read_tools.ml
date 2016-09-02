open Str

let csv_separator = "," ;;

let err_lists_sizes = "Incompatible lists size"

let line_stream_of_channel channel =
    Stream.from (fun _ -> try Some (input_line channel) with End_of_file -> None) ;;
	
let read_lines file_path = line_stream_of_channel (open_in file_path);;
	
let read_first_line file_path = Stream.next (read_lines file_path) ;;
	
let split_line line = Str.split (Str.regexp csv_separator) line ;;

let concat_elements list1 list2 = 
	let rec aux list1 list2 acc = match list1,list2 with
	| [],[] -> acc
	| a,[] -> failwith err_lists_sizes
	| [],a -> failwith err_lists_sizes
	| h1::t1,h2::t2 -> aux t1 t2 ((h1^h2)::acc) in List.rev (aux list1 list2 []) ;;
	
let to_dict list1 list2 =
	let rec aux list1 list2 my_hash = match list1,list2 with
	| [],[] -> my_hash
	| a,[] -> failwith err_lists_sizes
	| [],a -> failwith err_lists_sizes
	| h1::t1,h2::t2 -> Hashtbl.add my_hash h1 h2; aux t1 t2 my_hash in aux list1 list2 (Hashtbl.create 20) ;;
	
let dict_reader file_path = 
	let line_stream = read_lines file_path in
	let header = split_line (Stream.next line_stream) in
	Stream.from
      (fun _ ->
         try Some (to_dict header (split_line (Stream.next line_stream))) with End_of_file -> None);;
