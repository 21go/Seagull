open Sedlexing

let chinese = [%sedlex.regexp? 0x4E00 .. 0x9FFF]

let rec token lexbuf =
  match%sedlex lexbuf with
  | chinese -> print_endline (Utf8.lexeme lexbuf); token lexbuf
  | any -> token lexbuf
  | eof -> ()
  | _ -> failwith "Unrecognized character"

let () =
  let lexbuf = Utf8.from_channel stdin in
  token lexbuf
