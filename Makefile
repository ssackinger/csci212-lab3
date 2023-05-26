CC=gcc
CFLAGS= -std=c99 -ggdb -Wall -I.
OBJ = main.o checkPrimeNumber.o
DEPS =

all: prime

prime: $(OBJ)
	gcc -o $@ $+

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

checkPrimeNumber.o : checkPrimeNumber.s
	as -o $@ $<

clean:
	rm -vf prime *.o
