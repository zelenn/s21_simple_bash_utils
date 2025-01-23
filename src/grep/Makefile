CC = gcc
CFLAGS = -Wall -Werror -Wextra

all: s21_grep

s21_grep: s21_grep.o
	$(CC) s21_grep.o -o s21_grep

s21_grep.o: s21_grep.c
	$(CC) $(CFLAGS) -c s21_grep.c -o s21_grep.o

clean:
	rm -f s21_grep *.o
	rm -f testsbash/s21_grep
	rm -f grep_out.txt s21_grep_out.txt

rebuild: clean all

format:
	clang-format --style=Google -i s21_grep.c

test: s21_grep
	bash testsbash/test.sh
	python3 testspy/TEST.py
