LEX=flex
YACC=bison
CC=g++
OBJECT=main #生成的目标文件

$(OBJECT): lex.yy.o  yacc.tab.o store.o
	$(CC) lex.yy.o yacc.tab.o store.o -o $(OBJECT)

lex.yy.o: lex.yy.c  yacc.tab.h  main.h
	$(CC) -c lex.yy.c

yacc.tab.o: yacc.tab.c  main.h
	$(CC) -c yacc.tab.c 

store.o : store.cpp 
	$(CC) -c store.cpp

# bison使用-d参数编译.y文件
yacc.tab.c  yacc.tab.h: yacc.y
	$(YACC) -d yacc.y

lex.yy.c: lex.l
	$(LEX) lex.l

clean:
	rm -f $(OBJECT)  *.o lex.yy.c yacc.tab.c yacc.tab.h
