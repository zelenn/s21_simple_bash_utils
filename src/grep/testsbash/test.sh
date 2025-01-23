#!/usr/bin/env bash

# Можно раскомментировать для вывода каждого шага:
#set -x

# Удалим предыдущие временные файлы
rm -f ../s21_grep_out.txt ../grep_out.txt shtestsbash/test_files/test.txt

########################################
#  Тест без флагов
########################################
echo "test no flag"
./s21_grep New testsbash/test_files/test.txt > s21_grep_out.txt
grep New testsbash/test_files/test.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

########################################
#  Тест -e flag (много паттернов)
########################################
echo "test -e"
./s21_grep -e New -e 123 testsbash/test_files/test.txt > s21_grep_out.txt
grep -e New -e 123 testsbash/test_files/test.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

########################################
#  Тест -i flag (игнорирование регистра)
########################################
echo "test -i"
./s21_grep -i NEW testsbash/test_files/test.txt > s21_grep_out.txt
grep -i NEW testsbash/test_files/test.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

########################################
#  Тест -v flag (инвертировать поиск)
########################################
echo "test -v"
./s21_grep -v 123 testsbash/test_files/test.txt > s21_grep_out.txt
grep -v 123 testsbash/test_files/test.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

########################################
#  Тест -c flag (подсчёт совпадений)
########################################
echo "test -c"
./s21_grep -c 123 testsbash/test_files/test.txt testsbash/test_files/test2.txt > s21_grep_out.txt
grep -c 123 testsbash/test_files/test.txt testsbash/test_files/test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

########################################
#  Тест -n flag (печатать номера строк)
########################################
echo "test -n"
./s21_grep -n 123 testsbash/test_files/test.txt > s21_grep_out.txt
grep -n 123 testsbash/test_files/test.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

########################################
#  Тест -l flag (печать только имён файлов)
########################################
echo "test -l"
./s21_grep -l 123 testsbash/test_files/test.txt testsbash/test_files/test2.txt  > s21_grep_out.txt
grep -l 123 testsbash/test_files/test.txt testsbash/test_files/test2.txt  > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

########################################
#  EXTRAS 
#  Тест -h flag (не печатать имя файла)
########################################
echo "EXTRA test -h"
./s21_grep -h 123 testsbash/test_files/test.txt testsbash/test_files/test2.txt  > s21_grep_out.txt
grep -h 123 testsbash/test_files/test.txt testsbash/test_files/test2.txt  > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

########################################
#  Тест -s flag (не выдавать ошибки о файлах)
########################################
echo "EXTRA test -s"
./s21_grep -s 123 testsbash/test_files/test.txt qwerty.txt  > s21_grep_out.txt
grep -s 123 testsbash/test_files/test.txt qwerty.txt  > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

########################################
#  Тест -o flag (выводить только совпадения)
########################################
echo "EXTRA test -o"
./s21_grep -o 123 testsbash/test_files/test.txt testsbash/test_files/test2.txt > s21_grep_out.txt
grep -o 123 testsbash/test_files/test.txt testsbash/test_files/test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

########################################
#  Тест -f flag (читать шаблоны из файла)
########################################
echo "EXTRA test -f"
./s21_grep -f testsbash/test_files/test_pattern.txt testsbash/test_files/test.txt testsbash/test_files/test2.txt > s21_grep_out.txt
grep -f testsbash/test_files/test_pattern.txt testsbash/test_files/test.txt testsbash/test_files/test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

########################################
#  Тесты на двойные флаги
########################################

# -e -v
echo "test -e -v"
./s21_grep -e New -e 123 -v testsbash/test_files/test.txt > s21_grep_out.txt
grep -e New -e 123 -v testsbash/test_files/test.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -e -i
echo "test -e -i"
./s21_grep -e NEW -i testsbash/test_files/test.txt > s21_grep_out.txt
grep -e NEW -i testsbash/test_files/test.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -i -v
echo "test -i -v"
./s21_grep -i NEW -v testsbash/test_files/test.txt > s21_grep_out.txt
grep -i NEW -v testsbash/test_files/test.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -n -e
echo "test -n -e"
./s21_grep -e new -e 123 -n testsbash/test_files/test.txt testsbash/test_files/test2.txt > s21_grep_out.txt
grep -e new -e 123 -n testsbash/test_files/test.txt testsbash/test_files/test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -n -i
echo "test -n -i"
./s21_grep -i NEW -n testsbash/test_files/test.txt > s21_grep_out.txt
grep -i NEW -n testsbash/test_files/test.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -n -v
echo "test -n -v"
./s21_grep -v 123 -n testsbash/test_files/test.txt > s21_grep_out.txt
grep -v 123 -n testsbash/test_files/test.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -n -c
echo "test -n -c"
./s21_grep -c 123 -n testsbash/test_files/test.txt testsbash/test_files/test2.txt> s21_grep_out.txt
grep -c 123 -n testsbash/test_files/test.txt testsbash/test_files/test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -i -c
echo "test -i -c"
./s21_grep -i NEW -c testsbash/test_files/test.txt testsbash/test_files/test2.txt> s21_grep_out.txt
grep -i NEW -c testsbash/test_files/test.txt testsbash/test_files/test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -v -c
echo "test -v -c"
./s21_grep -v 123 -c testsbash/test_files/test.txt testsbash/test_files/test2.txt> s21_grep_out.txt
grep -v 123 -c testsbash/test_files/test.txt testsbash/test_files/test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -e -c
echo "test -e -c"
./s21_grep -e 123 -e New -c testsbash/test_files/test.txt testsbash/test_files/test2.txt> s21_grep_out.txt
grep -e 123 -e New -c testsbash/test_files/test.txt testsbash/test_files/test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -l -e
echo "test -l -e"
./s21_grep -e 123 -e New -l testsbash/test_files/test.txt testsbash/test_files/test2.txt> s21_grep_out.txt
grep -e 123 -e New -l testsbash/test_files/test.txt testsbash/test_files/test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -l -i
echo "test -l -i"
./s21_grep -i NEW  -l testsbash/test_files/test.txt testsbash/test_files/test2.txt> s21_grep_out.txt
grep -i NEW -l testsbash/test_files/test.txt testsbash/test_files/test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -l -v
echo "test -l -v"
./s21_grep -v 123  -l testsbash/test_files/test.txt testsbash/test_files/test2.txt> s21_grep_out.txt
grep -v 123 -l testsbash/test_files/test.txt testsbash/test_files/test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -l -c
echo "test -l -c"
./s21_grep -c 123  -l testsbash/test_files/test.txt testsbash/test_files/test2.txt> s21_grep_out.txt
grep -c 123 -l testsbash/test_files/test.txt testsbash/test_files/test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -l -n
echo "test -l -n"
./s21_grep -n 123  -l testsbash/test_files/test.txt testsbash/test_files/test2.txt> s21_grep_out.txt
grep -n 123 -l testsbash/test_files/test.txt testsbash/test_files/test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -h -e
echo "test -h -e "
./s21_grep -e 123 -e new -h testsbash/test_files/test.txt testsbash/test_files/test2.txt> s21_grep_out.txt
grep -e 123 -e new -h testsbash/test_files/test.txt testsbash/test_files/test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -h -i
echo "test -h -i "
./s21_grep -i NEW -h testsbash/test_files/test.txt testsbash/test_files/test2.txt> s21_grep_out.txt
grep -i NEW -h testsbash/test_files/test.txt testsbash/test_files/test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -h -v
echo "test -h -v "
./s21_grep -v 123 -h testsbash/test_files/test.txt testsbash/test_files/test2.txt> s21_grep_out.txt
grep -v 123 -h testsbash/test_files/test.txt testsbash/test_files/test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -h -n
echo "test -h -n "
./s21_grep -n 123 -h testsbash/test_files/test.txt testsbash/test_files/test2.txt> s21_grep_out.txt
grep -n 123 -h testsbash/test_files/test.txt testsbash/test_files/test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -h -l
echo "test -h -l "
./s21_grep -l 123 -h testsbash/test_files/test.txt testsbash/test_files/test2.txt> s21_grep_out.txt
grep -l 123 -h testsbash/test_files/test.txt testsbash/test_files/test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

########################################
#  Исправленные тесты для -s (-e, -i, -v, -c, -n, -l, -h)
########################################

# -s -e
echo "test -s -e "
./s21_grep -e 123 -e new -s testsbash/test_files/test.txt qwerty.txt > s21_grep_out.txt
grep -e 123 -e new -s testsbash/test_files/test.txt qwerty.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -s -i
echo "test -s -i "
./s21_grep -i NEW -s testsbash/test_files/test.txt qwerty.txt > s21_grep_out.txt
grep -i NEW -s testsbash/test_files/test.txt qwerty.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -s -v
echo "test -s -v"
./s21_grep -v 123 -s testsbash/test_files/test.txt qwerty.txt > s21_grep_out.txt
grep -v 123 -s testsbash/test_files/test.txt qwerty.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -s -c
echo "test -s -c"
./s21_grep -c 123 -s testsbash/test_files/test.txt qwerty.txt > s21_grep_out.txt
grep -c 123 -s testsbash/test_files/test.txt qwerty.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -s -n
echo "test -s -n"
./s21_grep -n 123 -s testsbash/test_files/test.txt qwerty.txt > s21_grep_out.txt
grep -n 123 -s testsbash/test_files/test.txt qwerty.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -s -l
echo "test -s -l"
./s21_grep -l 123 -s testsbash/test_files/test.txt qwerty.txt > s21_grep_out.txt
grep -l 123 -s testsbash/test_files/test.txt qwerty.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -s -h
echo "test -s -h"
./s21_grep -h 123 -s testsbash/test_files/test.txt qwerty.txt > s21_grep_out.txt
grep -h 123 -s testsbash/test_files/test.txt qwerty.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

########################################
#  -f + другие флаги
########################################

# -f -e
echo "test -f -e"
./s21_grep -f testsbash/test_files/test_pattern.txt -e new -e 123 testsbash/test_files/test.txt testsbash/test_files/test2.txt > s21_grep_out.txt
grep -f testsbash/test_files/test_pattern.txt -e new -e 123 testsbash/test_files/test.txt testsbash/test_files/test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -f -i
echo "test -f -i"
./s21_grep -f testsbash/test_files/test_pattern.txt -i testsbash/test_files/test.txt testsbash/test_files/test2.txt > s21_grep_out.txt
grep -f testsbash/test_files/test_pattern.txt -i testsbash/test_files/test.txt testsbash/test_files/test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -f -v
echo "test -f -v"
./s21_grep -f testsbash/test_files/test_pattern.txt -v testsbash/test_files/test.txt testsbash/test_files/test2.txt > s21_grep_out.txt
grep -f testsbash/test_files/test_pattern.txt -v testsbash/test_files/test.txt testsbash/test_files/test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -f -c
echo "test -f -c"
./s21_grep -f testsbash/test_files/test_pattern.txt -c testsbash/test_files/test.txt testsbash/test_files/test2.txt > s21_grep_out.txt
grep -f testsbash/test_files/test_pattern.txt -c testsbash/test_files/test.txt testsbash/test_files/test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -f -n
echo "test -f -n"
./s21_grep -f testsbash/test_files/test_pattern.txt -n testsbash/test_files/test.txt testsbash/test_files/test2.txt > s21_grep_out.txt
grep -f testsbash/test_files/test_pattern.txt -n testsbash/test_files/test.txt testsbash/test_files/test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -f -l
echo "test -f -l"
./s21_grep -f testsbash/test_files/test_pattern.txt -l testsbash/test_files/test.txt testsbash/test_files/test2.txt > s21_grep_out.txt
grep -f testsbash/test_files/test_pattern.txt -l testsbash/test_files/test.txt testsbash/test_files/test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -f -h
echo "test -f -h"
./s21_grep -f testsbash/test_files/test_pattern.txt -h testsbash/test_files/test.txt testsbash/test_files/test2.txt > s21_grep_out.txt
grep -f testsbash/test_files/test_pattern.txt -h testsbash/test_files/test.txt testsbash/test_files/test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -f -s
echo "test -f -s"
./s21_grep -f testsbash/test_files/test_pattern.txt -s qwerty.txt testsbash/test_files/test.txt testsbash/test_files/test2.txt > s21_grep_out.txt
grep -f testsbash/test_files/test_pattern.txt -s qwerty.txt testsbash/test_files/test.txt testsbash/test_files/test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

########################################
#  -o + другие флаги
########################################

# -o -e
echo "test -o -e "
./s21_grep -e 123 -e new -o testsbash/test_files/test.txt > s21_grep_out.txt
grep -e 123 -e new -o testsbash/test_files/test.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -o -i
echo "test -o -i "
./s21_grep -i NeW -o testsbash/test_files/test.txt > s21_grep_out.txt
grep -i NeW -o testsbash/test_files/test.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -o -v
echo "test -o -v "
./s21_grep -v 123 -o testsbash/test_files/test.txt > s21_grep_out.txt
grep -v 123 -o testsbash/test_files/test.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -o -c
echo "test -o -c "
./s21_grep -c 123 -o testsbash/test_files/test.txt testsbash/test_files/test2.txt > s21_grep_out.txt
grep -c 123 -o testsbash/test_files/test.txt testsbash/test_files/test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -o -n
echo "test -o -n "
./s21_grep -n new -o testsbash/test_files/test.txt > s21_grep_out.txt
grep -n new -o testsbash/test_files/test.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -o -l
echo "test -o -l "
./s21_grep -l 123 -o testsbash/test_files/test.txt testsbash/test_files/test2.txt > s21_grep_out.txt
grep -l 123 -o testsbash/test_files/test.txt testsbash/test_files/test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -o -h
echo "test -o -h "
./s21_grep -h 123 -o testsbash/test_files/test.txt testsbash/test_files/test2.txt > s21_grep_out.txt
grep -h 123 -o testsbash/test_files/test.txt testsbash/test_files/test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -o -s
echo "test -o -s "
./s21_grep -s 123 -o testsbash/test_files/test.txt qwerty.txt > s21_grep_out.txt
grep -s 123 -o testsbash/test_files/test.txt qwerty.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

# -o -f
echo "test -o -f "
./s21_grep -f testsbash/test_files/test_pattern.txt -o testsbash/test_files/test.txt testsbash/test_files/test2.txt > s21_grep_out.txt
grep -f testsbash/test_files/test_pattern.txt -o testsbash/test_files/test.txt testsbash/test_files/test2.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt

########################################
#  Дополнительные тесты
########################################

# Тест пустого файла
echo "test empty file"
touch empty.txt
./s21_grep "pattern" empty.txt > s21_grep_out.txt
grep "pattern" empty.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt
rm -f empty.txt

# Тест специального символа (точка)
echo "test special characters"
echo "Hello.*world" > special.txt
./s21_grep "Hello\.\*w" special.txt > s21_grep_out.txt
grep "Hello\.\*w" special.txt > grep_out.txt
diff -q s21_grep_out.txt grep_out.txt
rm -f special.txt

########################################
#  Завершение. Записываем вывод
########################################
echo "All tests are done."


# echo "Current directory: $(pwd)"

rm -rf s21_grep_out.txt grep_out.txt