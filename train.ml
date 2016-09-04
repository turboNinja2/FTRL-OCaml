(* training *)

let train updater dict_stream feature_engine predict loss_function refresh_loss target_name = 
	let rec aux updater dict_stream t loss = match (try Some(Stream.next dict_stream) 
								  with _ -> None) with
	| Some dict -> Hashtbl.remove dict "id"; 
			  let y = float_of_string (Hashtbl.find dict target_name) in
			  Hashtbl.remove dict target_name;
			  let indices = feature_engine dict in
			  let p = predict indices in
			  updater indices p y;
			  
			  if ((t mod refresh_loss) == 0) && t > 0 then begin 
				  print_float (loss /. float_of_int(t)); 
				  print_endline " "; 
			  end;
			  
			  aux updater dict_stream (t + 1) (loss +. (loss_function p y))
			  
	| None -> () in aux updater dict_stream 0 0. ;;	