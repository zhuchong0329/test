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
number      ({digit}+)
set          ("set")
letter      ([a-zA-Z])
identifier  ({letter}+)
over ("\n")
other  (.)

%%

{number}  {
	yylval.number=atoi(yytext);
	return NUMBER;
}

{set}  {
	return SET;
}

{identifier} {
	yylval.indentifier = yytext;
	return IDENTIFY;
}

{over} {
	return OVER;
}

{other} {
	return (char)yytext[0];
}



%%

int yywrap()//此函数必须由用户提供,或者声明 %option noyywrap
{
	printf("yywrap\n");
    return 1;
}
