%{

#include "main.h"
	
extern "C"
{    
	void yyerror(const char *s);
	extern int yylex(void);
}

%}

%token <number> INTEGER
%token <optor> OPT
%type<number> expression
%%

expression : 
	{
	}
	| INTEGER
	{
		$$ = $1;
		printf("exp1:%d\n",$1);
	}
	| expression OPT INTEGER
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
		printf("exp2:%d ,%s,%d\n",$1,$2.c_str(),$3);
	};
	
%%
int main( int argc, char **argv ) {
 
	yyparse();
	return 0;
}

void yyerror(const char *s)    //当yacc遇到语法错误时，会回调yyerror函数，并且把错误信息放在参数s中
{
    cerr<<s<<endl;//直接输出错误信息
}