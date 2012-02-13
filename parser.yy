%token_prefix TOKEN_

%left ADD SUB.
%left MUL DIV.

%token_type { YYSTYPE }

%extra_argument { ParserState *state }

%include {
#include <iostream>
#include "scanner.def.h"
}

%syntax_error {
    fprintf(stderr, "Syntax error\n");
}

%parse_failure {
    fprintf(stderr,"Giving up.  Parser is hopelessly lost...\n");
}

%start_symbol program

program ::= expr(A). {
    state->result = A.int_value;
}

expr(A) ::= primary_expression(B). {
    A.int_value = B.int_value;
}
expr(A) ::= expr(B) SUB primary_expression(C). {
    A.int_value = B.int_value - C.int_value;
}
expr(A) ::= expr(B) ADD primary_expression(C). {
    A.int_value = B.int_value + C.int_value;
}
expr(A) ::= expr(B) DIV primary_expression(C). {
    A.int_value = B.int_value / C.int_value;
}
expr(A) ::= expr(B) MUL primary_expression(C). {
    A.int_value = B.int_value * C.int_value;
}

primary_expression(A) ::= INT(B). {
    A.int_value = B.int_value;
}

