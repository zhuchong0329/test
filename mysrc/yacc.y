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
%token<optor> HIGHTOPT
%token<optor> LOWOPT
%token<optor> LEFTBRACKET
%token<optor> RIGHTBRACKET
%type<number> complete
%type<number> expression
%type<number> term
%type<number> foctor
%%

complete : expression OVER 
	{
		$$ = $1;
		printf("result:%d\n",$$);
		YYACCEPT;
	};

expression : term
		{
			$$ = $1;
		}
		|  expression LOWOPT term
		{
			if ($2 == "+") {
				$$ = $1 + $3;
			}
			else if ($2 == "-") {
				$$ = $1 - $3;
			}
		};
		
term : foctor
	{
		$$ = $1;
	}
	| term HIGHTOPT foctor
	{
		if ($2 == "*") {
			$$ = $1 * $3;
		}
		else if ($2 == "/") {
			$$ = $1 / $3;
		}
	};

foctor : LEFTBRACKET expression RIGHTBRACKET
	{
		$$ = $2;
		printf("(select)\n");
	}
	| INTEGER
	{
		$$ = $1;
	};


	
	
%%
int main( int argc, char **argv ) {
	while (yyparse() == 0);
	return 0;
}

void yyerror(const char *s)    //当yacc遇到语法错误时，会回调yyerror函数，并且把错误信息放在参数s中
{
    printf("errmsg:%s\n",s);//直接输出错误信息
}
