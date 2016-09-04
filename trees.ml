type 'a tree =
  | Node of ('a tree)*('a)*('a tree)
  | Leaf of 'a
  
let draw_tree tree to_string =
  let rec print indent tree =
    match tree with
     | Leaf n -> Printf.printf "%s%s\n" indent (to_string(n))
     | Node (left, n, right) ->
        Printf.printf "%s--------\n" indent;
        print (indent ^ "|      ") left;
        Printf.printf "%s%s\n" indent (to_string(n));
        print (indent ^ "|      ") right;
        Printf.printf "%s--------\n" indent
  in print "" tree 
  
let draw_int_tree tree = draw_tree tree string_of_int