%{

#include "main.h"

extern "C"
{
int yywrap(void);
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
	return INTEGER;
}

{opt} {
	yylval.optor=yytext;
	printf("operator:%s\n",yylval.optor.c_str());
	return OPT;
}

%%

int yywrap()//此函数必须由用户提供,或者声明 %option noyywrap
{
	printf("yywrap\n");
    return 1;
}

int
main( int argc, char **argv ) {
 
	yylex();
	//printf( "%8d%8d%8d\n", nline, nword, nchar );
 
	return 0;
}
