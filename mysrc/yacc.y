%{

#include "main.h"
	
extern "C"
{    
	void yyerror(const char *s);
	extern int yylex(void);
}

%}

%token INTEGER
%token<optor> OPT
%type expression
%%

expression : 
	{
	}
	| integer
	{
		$$.number = $1.number;
		printf("exp1:%d\n",$1.number);
	}
	| expression opt integer
	{
		if ($2 == "+") {
			$$.number = $1.number + $3.number;
		}
		else if ($2 == "-") {
			$$.number = $1.number - $3.number;
		}
		else if ($2 == "*") {
			$$.number = $1.number * $3.number;
		}
		else if ($2 == "/") {
			$$.number = $1.number / $3.number;
		}
		printf("exp2:%d ,%s,%d\n",$1.number,$2.c_str(),$3.number);
	}
	
%%
int main( int argc, char **argv ) {
 
	yyparse();
	return 0;
}

void yyerror(const char *s)    //当yacc遇到语法错误时，会回调yyerror函数，并且把错误信息放在参数s中
{
    cerr<<s<<endl;//直接输出错误信息
}