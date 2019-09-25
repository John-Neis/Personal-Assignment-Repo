CC=g++
CFLAGS=-c -Wall

all: vector.o hw4-JohnNeis.o
	$(CC) vector.o hw4-JohnNeis.o -o hw4
hw4-JohnNeis.o: hw4-JohnNeis.c
	$(CC) $(CFLAGS) hw4-JohnNeis.c
vector.o: vector.c
	$(CC) $(CFLAGS) vector.c
clean:
	rm -rf *.o hw4
