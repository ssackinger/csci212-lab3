all: prime

prime: main.o prime.o
	gcc -o $@ $+

main.o : main.c
	gcc -o $@ $+

prime.o : prime.s
	as -o $@ $<

clean:
	rm -vf prime *.o
