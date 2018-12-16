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
hightopt     ("*"|"/")
lowopt       ("+"|"-")
left         ("(")
right        (")")
over ("\n")

%%

{integer}  {
	yylval.number=atoi(yytext);
	//printf("int:%d\n",yylval.number);
	return INTEGER;
}

{hightopt}  {
	yylval.optor=yytext;
	return HIGHTOPT;
}

{lowopt} {
	yylval.optor=yytext;
	return LOWOPT;
}

{over} {
	return OVER;
}

{left} {
	return LEFTBRACKET;
}

{right} {
	return RIGHTBRACKET;
}

%%

int yywrap()//此函数必须由用户提供,或者声明 %option noyywrap
{
	printf("yywrap\n");
    return 1;
}
