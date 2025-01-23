CC=gcc
CFLAGS = -Wall -Werror -Wextra -c

s21_cat:
	$(CC) $(CFLAGS) s21_cat.c
	$(CC) -o s21_cat s21_cat.o

clean:
	rm s21_cat *.o

rebuild:
	rm s21_cat s21_cat.o 
	make

test:
	./tests.sh