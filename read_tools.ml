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