%language "c++"
%locations
%define api.value.type variant

%code top {
using namespace std;
#include <iostream>
#include "implementation.hh"
#include <list>
}

%code provides {
int yylex(yy::parser::semantic_type* yylval, yy::parser::location_type* yylloc);
}

%token PRG
%token BEG
%token END
%token BOO
%token INT
%token STR
%token REA
%token WRI
%token IF
%token THE
%token ELS
%token EIF
%token WHI
%token DO
%token ARR
%token DON
%token TRU
%token FAL
%token ASN
%token OP
%token CL
%token LBRA
%token RBRA
%token COMMA
%token <std::string> ID
%token <std::string> NUM
%token QUO

%left OR
%left AND
%left EQ
%left LS GR LSE GRE
%left ADD SUB
%left MUL DIV MOD
%precedence NOT

%type <expression*> expression
%type <instruction*> command
%type <std::list<instruction*>* > commands
%type <std::string> string
%type <std::list<int>*> items

%%

start:
    declarations commands
    {
        cout << "miniPy>\n";
        type_check_commands($2);
        execute_commands($2);
        delete_commands($2);
    }
;

declarations:
    // empty
|
    declarations declaration
;

declaration:
    BOO ID
    {
        symbol(@1.begin.line, $2, boolean).declare();
    }
|
    INT ID
    {
        symbol(@1.begin.line, $2, natural).declare();
    }
|
    STR ID
    {
        symbol(@1.begin.line, $2, py_string).declare();
    }
|   
    ARR ID
    {
        symbol(@1.begin.line, $2, py_list).declare();
    }
;

commands:
    // empty
    {
        $$ = new std::list<instruction*>();
    }
|
    commands command
    {
        $1->push_back($2);
        $$ = $1;
    }
;

command:
    REA OP ID CL
    {
        $$ = new read_instruction(@1.begin.line, $3);
    }
|
    WRI OP expression CL
    {
        $$ = new write_instruction(@1.begin.line, $3);
    }
|
    ID ASN expression
    {
        $$ = new assign_instruction(@2.begin.line, $1, $3);
    }
|
    IF expression THE commands EIF
    {
        $$ = new if_instruction(@1.begin.line, $2, $4, 0);
    }
|
    IF expression THE commands ELS commands EIF
    {
        $$ = new if_instruction(@1.begin.line, $2, $4, $6);
    }
|
    WHI expression DO commands DON
    {
        $$ = new while_instruction(@1.begin.line, $2, $4);
    }
;

expression:
    NUM
    {
        $$ = new number_expression($1);
    }
|
    TRU
    {
        $$ = new boolean_expression(true);
    }
|
    FAL
    {
        $$ = new boolean_expression(false);
    }
|
    ID
    {
        $$ = new id_expression(@1.begin.line, $1);
    }
|
    string
    {
        $$ = new string_expression($1);
    }
|
    LBRA items RBRA 
    {
        $$ = new list_expression($2);
    }
|
    expression ADD expression
    {
        $$ = new binop_expression(@2.begin.line, "+", $1, $3);
    }
|
    expression SUB expression
    {
        $$ = new binop_expression(@2.begin.line, "-", $1, $3);
    }
|
    expression MUL expression
    {
        $$ = new binop_expression(@2.begin.line, "*", $1, $3);
    }
|
    expression DIV expression
    {
        $$ = new binop_expression(@2.begin.line, "/", $1, $3);
    }
|
    expression MOD expression
    {
        $$ = new binop_expression(@2.begin.line, "%", $1, $3);
    }
|
    expression LS expression
    {
        $$ = new binop_expression(@2.begin.line, "<", $1, $3);
    }
|
    expression GR expression
    {
        $$ = new binop_expression(@2.begin.line, ">", $1, $3);
    }
|
    expression LSE expression
    {
        $$ = new binop_expression(@2.begin.line, "<=", $1, $3);
    }
|
    expression GRE expression
    {
        $$ = new binop_expression(@2.begin.line, ">=", $1, $3);
    }
|
    expression AND expression
    {
        $$ = new binop_expression(@2.begin.line, "and", $1, $3);
    }
|
    expression OR expression
    {
        $$ = new binop_expression(@2.begin.line, "or", $1, $3);
    }
|
    expression EQ expression
    {
        $$ = new binop_expression(@2.begin.line, "=", $1, $3);
    }
|
    NOT expression
    {
        $$ = new not_expression(@1.begin.line, "not", $2);
    }
|
    OP expression CL
    {
        $$ = $2;
    }
;
string:
    QUO  ID   QUO
    {
        $$ = $2;
    }
;

items:
    NUM
    {
        $$ = new std::list<int>();
        $$->push_back(std::stoi($1));
    }
|
    items COMMA NUM
    {
        $1->push_back(std::stoi($3));
        $$ = $1;
    }
;

%%
