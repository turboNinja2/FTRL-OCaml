type 'a tree =
  | Node of ('a tree)*('a)*('a tree)
  | Leaf of 'a 
  
let draw_int_tree tree =
  let rec print indent tree =
    match tree with
     | Leaf n -> Printf.printf "%s%d\n" indent n
     | Node (left, n, right) ->
        Printf.printf "%s----\n" indent;
        print (indent ^ "| ") left;
        Printf.printf "%s%d\n" indent n;
        print (indent ^ "| ") right;
        Printf.printf "%s----\n" indent
  in print "" tree 