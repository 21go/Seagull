open Sedlexing

let chinese_char = [%sedlex.regexp? 0x4E00 .. 0x9FFF]
let digit = ['0'-'9']
let letter = ['a'-'z' 'A'-'Z']

(* Unicode 0xFF08:（ *)
let lparen = [%sedlex.regexp? Uchar(0xFF08)]

(* Unicode 0xFF08:（ *)
let rparen = [%sedlex.regexp? Uchar(0xFF09)]


let lbrace = [%sedlex.regexp? Uchar(0x300C)]
let rbrace = [%sedlex.regexp? Uchar(0x300D)]
let semi = [%sedlex.regexp? Uchar(0x3001)]
let comma = [%sedlex.regexp? Uchar(0xFF0C)]
let plus = [%sedlex.regexp? Uchar(0x002B)]
let minus = [%sedlex.regexp? Uchar(0x002D)]
let assign = [%sedlex.regexp? Uchar(0x003D)]
let eq = [%sedlex.regexp? Uchar(0xFF1D)]
let neq = [%sedlex.regexp? Uchar(0xFF01); Uchar(0x003D)]
let lt = [%sedlex.regexp? Uchar(0x5C0F)]
let and_token = [%sedlex.regexp? Uchar(0x548C)]
let or_token = [%sedlex.regexp? Uchar(0x6216)]
let if_token = [%sedlex.regexp? Uchar(0x5982); Uchar(0x679C)]
let else_token = [%sedlex.regexp? Uchar(0x5426); Uchar(0x5219)]
let while_token = [%sedlex.regexp? Uchar(0x5F53)]
let return_token = [%sedlex.regexp? Uchar(0x56DE)]
let int_token = [%sedlex.regexp? Uchar(0x6574); Uchar(0x6570)]
let bool_token = [%sedlex.regexp? Uchar(0x5E03); Uchar(0x5C14)]
let true_token = [%sedlex.regexp? Uchar(0x771F)]
let false_token = [%sedlex.regexp? Uchar(0x5047)]

let rec token lexbuf =
  match%sedlex lexbuf with
  | chinese_char -> print_endline (Utf8.lexeme lexbuf); token lexbuf
  | lparen -> LPAREN
  | rparen -> RPAREN
  | lbrace -> LBRACE
  | rbrace -> RBRACE
  | semi -> SEMI
  | comma -> COMMA
  | plus -> PLUS
  | minus -> MINUS
  | assign -> ASSIGN
  | eq -> EQ
  | neq -> NEQ
  | lt -> LT
  | and_token -> AND
  | or_token -> OR
  | if_token -> IF
  | else_token -> ELSE
  | while_token -> WHILE
  | return_token -> RETURN
  | int_token -> INT
  | bool_token -> BOOL
  | true_token -> BLIT(true)
  | false_token -> BLIT(false)
  | digit+ as lem -> LITERAL(int_of_string (Utf8.lexeme lexbuf))
  | letter (digit | letter | '_')* as lem -> ID(Utf8.lexeme lexbuf)
  | eof -> EOF
  | _ -> failwith "Unrecognized character"

and comment lexbuf =
  match%sedlex lexbuf with
  | "*/" -> token lexbuf
  | _ -> comment lexbuf


  (* 
| '（'      { LPAREN }
| '）'      { RPAREN }
| '「'      { LBRACE }
| '」'      { RBRACE }
| '；'      { SEMI }
| '，'      { COMMA }
| '+'      { PLUS }
| '-'      { MINUS }
| '='      { ASSIGN }
| "=="     { EQ }
| "！="     { NEQ }
| '小'      { LT }
| "和"     { AND }
| "或"     { OR }
| "如果"     { IF }
| "否则"   { ELSE }
| "当"  { WHILE }
| "回" { RETURN }
| "整数"    { INT }
| "布尔"   { BOOL }
| "真"   { BLIT(true)  }
| "假"  { BLIT(false) } *)