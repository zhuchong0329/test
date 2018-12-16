%{

#include "store.h"
#include "main.h"
#include <stdio.h>
	
extern "C"
{    
	void yyerror(const char *s);
	extern int yylex(void);
}

%}

%token<number> NUMBER
%token OVER
%token SET
%token<indentifier> IDENTIFY
%type<number> complete
%type<number> expression
%type<number> term
%type<number> foctor
%type<number> assign
%%

complete : expression OVER 
	{
		$$ = $1;
		printf("result:%d\n",$$);
		YYACCEPT;
	}
	;

assign : SET IDENTIFY '=' expression OVER
	{
		$$ = 0;
		printf("assign %s = %d\n",$2.c_str(),$4);
		getIdentify($2,value)
		YYACCEPT;
	}

expression : term
		{
			$$ = $1;
		}
		|  expression '+' term
		{
			$$ = $1 + $3;
		}
		|  expression '-'  term
		{
			$$ = $1 - $3;
		}
		;
		
term : foctor
	{
		$$ = $1;
	}
	| term '*' foctor
	{
		$$ = $1 * $3;
	}
	| term '/' foctor
	{
		$$ = $1 / $3;
	}
	;

foctor : '(' expression ')'
	{
		$$ = $2;
	}
	| NUMBER
	{
		$$ = $1;
	}
	| IDENTIFY
	{
		int value;
		if (getIdentify($1,value) != 0) {
			printf("%s not set.\n",$1.c_str());
			YYABORT ;
		}
		$$ = value;
	}
	;


	
	
%%
int main( int argc, char **argv ) {
	while (yyparse() == 0);
	return 0;
}

void yyerror(const char *s)    //当yacc遇到语法错误时，会回调yyerror函数，并且把错误信息放在参数s中
{
    printf("errmsg:%s\n",s);//直接输出错误信息
}
