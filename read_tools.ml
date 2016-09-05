open Str

let csv_separator = ","

let err_lists_sizes = "Incompatible lists size"

(** Streams the lines of a channel.*)
let line_stream_of_channel channel =
    Stream.from (fun _ -> try Some (input_line channel) with End_of_file -> None)

(** Streams the lines of a file.*)	
let read_lines file_path = line_stream_of_channel (open_in file_path)
	
(** Reads the first line of a file.*)
let read_first_line file_path = Stream.next (read_lines file_path)

(** Splits a line according the separator.*)	
let split_line line = Str.split (Str.regexp csv_separator) line

(** Given two lists, returns a hashtable whose keys are the elements of the first list and the values are the elements of the second list. *)
let to_dict list1 list2 =
	let rec aux list1 list2 my_hash = match list1,list2 with
	| [],[] -> my_hash
	| a,[] -> failwith err_lists_sizes
	| [],a -> failwith err_lists_sizes
	| h1::t1,h2::t2 -> Hashtbl.add my_hash h1 h2; aux t1 t2 my_hash in aux list1 list2 (Hashtbl.create 15)
	
(** Given a file path to a csv file, reads it as a stream of hashtable whose keys are the header of the file *)
let dict_reader file_path = 
	let line_stream = read_lines file_path in
	let header = split_line (Stream.next line_stream) in
	Stream.from
      (fun _ ->
         try Some (to_dict header (split_line (Stream.next line_stream))) with End_of_file -> None)
