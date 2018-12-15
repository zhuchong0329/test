%{

#include "main.h"

extern "C"
{
//int yywrap(void);
int yylex(void);
}

YYSTYPE yylval;

%}

digit        ([0-9])
integer      ({digit}+)
opt     ("+"|"-"|"*"|"/")

%%

{integer}  {
	yylval.number=atoi(yytext);
	printf("int:%d\n",yylval.number);
	//return "int";
}

{opt} {
	yylval.optor=yytext;
	printf("operator:%s\n",yylval.optor.c_str());
	//return "operator";
}

%%
int
main( int argc, char **argv ) {
 
	yylex();
	//printf( "%8d%8d%8d\n", nline, nword, nchar );
 
	return 0;
}
