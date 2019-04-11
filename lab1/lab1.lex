NUMBER [0-9]+
PLUS [+]
MINUS [-]
MULT [*]
DIV [/]
L_PAREN [(]
R_PAREN [)]
EQUAL [=]


%{
#include <unistd.h>
%}

%%
{NUMBER}	printf("NUMBER\t%s\n", yytext);
{PLUS}		printf("PLUS\t%s\n", yytext);
{MINUS}		printf("MINUS\t%s\n", yytext);
{MULT}		printf("MULT\t%s\n", yytext);
{DIV}		printf("DIV\t%s\n", yytext);
{L_PAREN}	printf("L_PAREN\t%s\n", yytext);
{R_PAREN}	printf("R_PAREN\t%s\n", yytext);
{EQUAL}		printf("EQUAL\t%s\n", yytext);
%%

main()
{
  yylex();
}

