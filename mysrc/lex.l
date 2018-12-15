%{

#include "main.h"

extern "C"
{
int yywrap(void);
int yylex(void);
}

%}

digit        ([0-9])
integer      ({digit}+)
operator     ("+"|"-"|"*"|"/")

%%

integer  {
	yylval.number=atoi(yytext);
	printf("int:%d\n",yylval.number);
	//return "int";
}

operator {
	yylval.operator=yytext;
	printf("operator:%s\n",yylval.operator.c_str());
	//return "operator";
}

%%
int
main( int argc, char **argv ) {
 
	yylex();
	//printf( "%8d%8d%8d\n", nline, nword, nchar );
 
	return 0;
}
