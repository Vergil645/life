%{
#define YYSTYPE void*
#include "lang.tab.h"
extern "C" int yylex();
%}

%option yylineno
%option noyywrap

%%

[/][/].*\n      ; // comment
[0-9]*          {
                  yylval = strdup(yytext);
                  return IntLiteral;
                }
"let"           { return LetToken; }
"if"            { return IfToken; }
"loop"          { return LoopToken; }
"continue"      { return ContinueToken; }
"break"         { return BreakToken; }
"fn"            { return FnToken; }
"RAND"          { return RandToken; }
"PUT"           { return PutToken; }
"FLUSH"         { return FlushToken; }
[A-Za-z_]+      { // identifier
                  yylval = strdup(yytext);
                  return Identifier;
                }
[ \t\r\n]      ; // whitespace
.              { return *yytext; }

%%