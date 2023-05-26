CC=gcc
CFLAGS= -std=c99 -ggdb -Wall -I.
OBJ = main.o prime.o
DEPS =

all: prime

prime: main.o prime.o
	gcc -o $@ $+

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

prime.o : prime.s
	as -o $@ $<

clean:
	rm -vf prime *.o
