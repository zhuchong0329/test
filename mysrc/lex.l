%{

#include "main.h"
#include "yacc.tab.h"

extern "C"
{
int yywrap(void);
int yylex(void);
}

%}

digit        ([0-9])
integer      ({digit}+)
opt     ("+"|"-"|"*"|"/")

%%

{integer}  {
	yylval.number=atoi(yytext);
	//printf("int:%d\n",yylval.number);
	return INTEGER;
}

{opt} {
	yylval.optor=yytext;
	//printf("operator:%s\n",yylval.optor.c_str());
	return OPT;
}

%%

int yywrap()//此函数必须由用户提供,或者声明 %option noyywrap
{
	printf("yywrap\n");
    return 1;
}
