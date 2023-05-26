CC=gcc
CFLAGS= -std=c99 -ggdb -Wall -I.
OBJ = main_asm.o checkPrimeNumber_asm.o
DEPS =

all: prime

prime: $(OBJ)
	gcc -o $@ $+

#%.o: %.c $(DEPS)
#	$(CC) -c -o $@ $< $(CFLAGS)

main_asm.o: main_asm.s
	as -o $@ $<

checkPrimeNumber_asm.o : checkPrimeNumber_asm.s
	as -o $@ $<

clean:
	rm -vf prime *.o
