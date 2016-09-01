#load "str.cma";;

let csv_separator = "," ;;

let line_stream_of_channel channel =
    Stream.from
      (fun _ ->
         try Some (input_line channel) with End_of_file -> None);;
	
let read_lines file_path = line_stream_of_channel (open_in file_path);;
	
let read_first_line file_path = Stream.next (read_lines file_path) ;;
	
let split_line line separator = Str.split (Str.regexp separator) line ;;

let concat_elements list1 list2 = 
	let rec aux list1 list2 acc = match list1,list2 with
	| [],[] -> acc
	| a,[] -> failwith "Incompatible line size"
	| [],a -> failwith "Incompatible line size"
	| h1::t1,h2::t2 -> aux t1 t2 ((h1^h2)::acc) in List.rev (aux list1 list2 []) ;;
	
