%option c++ noyywrap yylineno

%{
#include <iostream>
#include <cstdlib>
#include <list>
#include "implementation.hh"
#include "while.tab.hh"

using namespace yy;
%}

%%

program                     return parser::token::PRG;
begin                       return parser::token::BEG;
end                         return parser::token::END;
bool                        return parser::token::BOO;
int                         return parser::token::INT;
string                      return parser::token::STR;
read                        return parser::token::REA;
print                       return parser::token::WRI;
if                          return parser::token::IF;
then                        return parser::token::THE;
else                        return parser::token::ELS;
endif                       return parser::token::EIF;
while                       return parser::token::WHI;
do                          return parser::token::DO;
done                        return parser::token::DON;
true                        return parser::token::TRU;
false                       return parser::token::FAL;
"="                        return parser::token::ASN;
"+"                         return parser::token::ADD;
"-"                         return parser::token::SUB;
"*"                         return parser::token::MUL;
"/"                         return parser::token::DIV;
"%"                         return parser::token::MOD;
"<"                         return parser::token::LS;
">"                         return parser::token::GR;
"<="                        return parser::token::LSE;
">="                        return parser::token::GRE;
"=="                         return parser::token::EQ;
"&&"                        return parser::token::AND;
"||"                        return parser::token::OR;
"~"                         return parser::token::NOT;
"("                         return parser::token::OP;
")"                         return parser::token::CL;
[a-zA-Z_][a-zA-Z0-9_]*      return parser::token::ID;
[0-9]+                      return parser::token::NUM;
[ \t\n]+                    // Whitespaces skipped.
#.*                         // Commens skipped.
.                           { std::cerr << "Line " << lineno() << ": Unexpected character: '" << YYText() << "'." << std::endl; exit(1); }
