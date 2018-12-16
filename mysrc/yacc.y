%{

#include "main.h"
#include <stdio.h>
	
extern "C"
{    
	void yyerror(const char *s);
	extern int yylex(void);
}

%}

%token<number> INTEGER
%token OVER
%type<number> expression
%type<number> term
%type<number> foctor
%%

complete : expression OVER 
	{
		$$ = $1;
		printf("result:%d\n",$$);
		YYACCEPT;
	}

expression : INTEGER ("+" | "-") INTEGER
		{
			$$ = $1;
			printf("operator:%s",$2);
		}
	
	
%%
int main( int argc, char **argv ) {
	while (yyparse() == 0);
	return 0;
}

void yyerror(const char *s)    //当yacc遇到语法错误时，会回调yyerror函数，并且把错误信息放在参数s中
{
    printf("er:%s\n",s);//直接输出错误信息
}