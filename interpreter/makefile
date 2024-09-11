all: interpreter

interpreter: parser.tab.o lex.yy.o
	gcc -o interpreter parser.tab.o lex.yy.o -lfl

parser.tab.o: parser.tab.c
	gcc -c -o parser.tab.o parser.tab.c

lex.yy.o: lex.yy.c
	gcc -c -o lex.yy.o lex.yy.c

parser.tab.c parser.tab.h: inventory.y
	bison -d inventory.y -o parser.tab.c

lex.yy.c: inventory.l parser.tab.h
	flex -o lex.yy.c inventory.l

clean:
	rm -f interpreter parser.tab.c parser.tab.h lex.yy.c *.o
