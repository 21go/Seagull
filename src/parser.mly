%{ open Ast %}

%token SEMI LPAREN RPAREN LBRACE RBRACE
%token GEQ GT LEQ LT EQ NEQ
%token PLUS MINUS TIMES DIVIDE MODULO ASSIGN
%token IF ELSE WHILE INT STRING BOOL
%token PRINT
%token <int> INTLIT
%token <string> STRINGLIT
%token <bool> BOOLLIT
%token <string> VARIABLE
%token EOF

%left SEMI
%right ASSIGN

%left PLUS MINUS
%left TIMES DIVIDE MODULO

%start program
%type <Ast.program> program

%%

program:
  stmt_list EOF { {body=$1} }

typ:
    INT     { TypeInt }
  | STRING  { TypeString }
  | BOOL    { TypeBool }

stmt_list:
    /* nothing */     { []       }
    | stmt stmt_list  { $1 :: $2 }

stmt:
  PRINT LPAREN expr RPAREN SEMI { Print($3)        }
  | expr SEMI                   { Expr($1)         }
  | LBRACE stmt_list RBRACE     { Block($2)        }
  | IF LPAREN expr RPAREN stmt ELSE stmt { IfElse($3, $5, $7) }
  | IF LPAREN expr RPAREN stmt  { If($3, $5)       }
  | WHILE LPAREN expr RPAREN stmt { While($3, $5) }

expr:
  | BOOLLIT                    { BoolLit($1) }
  | INTLIT                     { IntLit($1) }
  | STRINGLIT                  { StringLit($1) }
  | VARIABLE                   { Var($1)    }
  | expr PLUS expr             { Binop($1, Add, $3)   }
  | expr MINUS expr            { Binop($1, Sub, $3)   }
  | expr TIMES expr            { Binop($1, Mul, $3)   }
  | expr DIVIDE expr           { Binop($1, Div, $3)   }
  | expr MODULO expr           { Binop($1, Mod, $3)   }
  | expr GEQ expr              { Binop($1, Geq, $3)   }
  | expr GT expr               { Binop($1, Gt, $3)    }
  | expr LEQ expr              { Binop($1, Leq, $3)   }
  | expr LT expr               { Binop($1, Lt, $3)    }
  | expr EQ expr               { Binop($1, Eq, $3)    }
  | expr NEQ expr              { Binop($1, Neq, $3)   }
  | VARIABLE ASSIGN expr       { Asn($1, $3)          }
  | typ VARIABLE ASSIGN expr   { Bind($1, $2, $4)     }
  | LPAREN expr RPAREN         { $2                   }