type 'a ring_buffer = {
  mutable pos : int;
  mutable count : int;
  data : 'a array;
  size : int;
}

let create size dummy = {
  pos = 0;
  count = 0;
  data = Array.make size dummy;
  size;
}

let push buffer elem =
  let k = buffer.pos + buffer.count in
  buffer.data.(if k < buffer.size then k else 0) <- elem;
  if buffer.count < buffer.size then
    buffer.count <- buffer.count + 1
  else
    buffer.pos <- buffer.pos + 1;
  ()

let pop buffer =
  if buffer.count = 0 then raise Not_found;
  let result = buffer.data.(buffer.pos) in
  (* if you want to free the buffer content, buffer.data.(pos) <- dummy *)
  let pos' = buffer.pos + 1 in
  buffer.pos <- (if pos' < buffer.size then pos' else 0);
  buffer.count <- buffer.count - 1;
  result

let element_at buffer t = buffer.data.(t mod buffer.size)

let element_from buffer t = buffer.data.((buffer.pos - t) mod buffer.size) 

