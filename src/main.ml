open Ast

(* Pretty-printing functions *)
let string_of_op = (function
    Add -> "+"
  | Sub -> "-"
  | Mul -> "*"
  | Div -> "/"
  | Mod -> "%"
  | Geq -> ">="
  | Gt -> ">"
  | Leq -> "<="
  | Lt -> "<"
  | Eq -> "=="
  | Neq -> "!=")

let string_of_typ = (function
    TypeInt -> "int"
  | TypeBool -> "bool"
  | TypeString -> "string")

let rec string_of_expr = (function
    IntLit(l) -> string_of_int l
  | BoolLit(true) -> "true"
  | BoolLit(false) -> "false"
  | StringLit(s) -> s
  | Var(s) -> s
  | Binop(e1, o, e2) ->
    string_of_expr e1 ^ " " ^ string_of_op o ^ " " ^ string_of_expr e2
  | Asn(v, e) -> v ^ " = " ^ string_of_expr e
  | Bind(t, v, e) -> string_of_typ t ^ " " ^ v ^ " = " ^ string_of_expr e)

let rec string_of_stmt = (function
    Block(stmts) ->
    "{\n" ^ String.concat "" (List.map string_of_stmt stmts) ^ "}\n"
  | Expr(expr) -> string_of_expr expr ^ ";\n";
  | Print(expr) -> "print(" ^ string_of_expr expr ^ ");\n";
  | If(expr, stmt) -> "if (" ^ string_of_expr expr ^ ") " ^ string_of_stmt stmt ^ "\n";
  | IfElse(expr, stmt1, stmt2) -> "if (" ^ string_of_expr expr ^ ") " ^ string_of_stmt stmt1 ^ "\nelse" ^ string_of_stmt stmt2 ^ "\n";
  | While(expr, stmt) -> "while (" ^ string_of_expr expr ^ ") " ^ string_of_stmt stmt ^ "\n";)

let string_of_program fdecl =
  "\n\nParsed program: \n\n" ^
  String.concat "" (List.map string_of_stmt fdecl.body) ^
  "\n"

let _ =
  let lexbuf = Lexing.from_channel stdin in
  let program = Parser.program Scanner.token lexbuf in
  print_endline (string_of_program program)