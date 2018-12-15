%{

#include "main.h"
#include <stdio.h>
	
extern "C"
{    
	void yyerror(const char *s);
	extern int yylex(void);
}

%}

%token <number> INTEGER
%token <optor> OPT
%token OVER
%type<number> expression
%type<number> complete
%%

complete : expression OVER 
		{
			$$ = $1;
			printf("result:%d\n",$$);
			YYACCEPT;
		}

expression :  expression OPT INTEGER
	{
		if ($2 == "+") {
			$$ = $1 + $3;
		}
		else if ($2 == "-") {
			$$ = $1 - $3;
		}
		else if ($2 == "*") {
			$$ = $1 * $3;
		}
		else if ($2 == "/") {
			$$ = $1 / $3;
		}
		
	}
	| INTEGER
	{
		$$ = $1;
		//printf("exp1:%d\n",$1);
	};
	
%%
int main( int argc, char **argv ) {
	while (yyparse() == 0);
	return 0;
}

void yyerror(const char *s)    //当yacc遇到语法错误时，会回调yyerror函数，并且把错误信息放在参数s中
{
    printf("er:%s\n",s);//直接输出错误信息
}