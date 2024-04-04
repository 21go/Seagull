type binop = Add | Sub | Mul | Div | Mod | Leq | Lt | Geq | Gt | Eq | Neq

type type_expr = 
   TypeInt
  (* | TypeDecimal *)
  | TypeBool
  | TypeString
  (* | TypeVoid *)
  (* | TypeArray of type_expr * int
  | TypeTuple of type_expr * type_expr *)

type expr =
  | Binop of expr * binop * expr
  | IntLit of int
  | BoolLit of bool
  | StringLit of string
  | Var of string
  | Asn of string * expr
  | Bind of type_expr * string * expr

type stmt =
  | Block of stmt list
  | Expr of expr
  | Print of expr
  | If of expr * stmt
  | IfElse of expr * stmt * stmt
  | While of expr * stmt

type program = {
  body: stmt list;
}