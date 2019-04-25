DIGIT [0-9]
PLUS +
MINUS -
MULT *
DIV /
L_PAREN (
R_PAREN )
EQUAL =
NEWLINE "\n"
TABS "\t"
OTHER .


%{
#include <unistd.h>

int currLine = 1;
int currPos = 1;
int numIntegers = 0;
int numOperators = 0;
int numParens = 0;
int numEquals = 0;

%}

%%
(\.{DIGIT}+)|({DIGIT}+(\.{DIGIT}*)?([eE][+-]?[0-9]+)?)   {printf("NUMBER %s\n", yytext); currPos += yyleng; numNumbers++;}

{PLUS}		{printf("PLUS\t%s\n", yytext); currPos += yyleng; numOperators++;}
{MINUS}		{printf("MINUS\t%s\n", yytext); currPos += yyleng; numOperators++;}
{MULT}		{printf("MULT\t%s\n", yytext); currPos += yyleng; numOperators++;}
{DIV}		{printf("DIV\t%s\n", yytext); currPos += yyleng; numOperators++;}

{L_PAREN}	{printf("L_PAREN\t%s\n", yytext); currPos += yyleng; numParens++;}
{R_PAREN}	{printf("R_PAREN\t%s\n", yytext); currPos += yyleng; numParens++;}

{EQUAL}		{printf("EQUAL\t%s\n", yytext); currPos += yyleng; numEquals++;}

{NEWLINE}	{currLine++; currPos = 0;}
{TABS}		{currPos += yyleng;}

{OTHER}		{{printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", currLine, currPos, yytext); exit(0);}}
%%

main(int args, char *argv[])
{
	if(args > 1) {
		yyin = fopen(argv[1], "r");
		if(yyin == NULL) {
			yyin = stdin;
		}
	}
	else {
		yyin = stdin;
	}
	
	yylex();
	
	printf("# Integers: %d\n", numIntegers);
	printf("# Operators: %d\n", numOperators);
	printf("# Parentheses: %d\n", numParens);
	printf("# Equal Signs: %d\n", numEquals);
	
	
}

