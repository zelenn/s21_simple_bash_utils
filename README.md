# Простые Bash Утилиты

Этот репозиторий содержит реализацию утилит `cat` и `grep`. Проект написан на языке Си и разделён на несколько частей. В проекте присутствует тестирование утилит с помощью тестов на языке Python и баш-скриптов.

---

## Часть 1: Работа с утилитой `cat`

### Описание

Утилита `s21_cat` повторяет поведение стандартной команды `cat` с поддержкой всех стандартных и GNU-специфичных флагов.

### Возможности

* Полная поддержка всех флагов `cat`, включая расширения GNU.
* Исходные файлы, заголовки и файлы сборки находятся в каталоге `src/cat/`.
* Исполняемый файл называется `s21_cat` и создается в каталоге `src/cat/`.

---

## Часть 2: Работа с утилитой `grep`

### Описание

Утилита `s21_grep` повторяет поведение стандартной команды `grep` с поддержкой базовых функций.

### Поддерживаемые флаги

* `-e`: Указание шаблона для поиска.
* `-i`: Игнорирование регистра.
* `-v`: Инверсия результата поиска.
* `-c`: Вывод только количества строк, соответствующих шаблону.
* `-l`: Вывод только имен файлов с совпадениями.
* `-n`: Добавление номера строки к результатам поиска.

### Дополнительно поддерживаемые флаги

* `-h`: Подавляет вывод имени файла в результатах.
* `-s`: Подавляет сообщения об ошибках.
* `-f`: Чтение шаблонов из файла.
* `-o`: Выводит только совпадающие части строк.

---

## Часть 3: Комбинации флагов для `grep`

### Описание

Бонусное задание добавляет поддержку комбинаций флагов в утилите `s21_grep`.

### Поддерживаемые комбинации

* Реализована поддержка таких комбинаций флагов, как `-iv`, `-in` и других, с корректным взаимодействием.

---

## Как собрать и запустить

### Требования

Убедитесь, что у вас установлены следующие инструменты:

* `gcc` или совместимый C-компилятор.
* `make`.

### Инструкции по сборке

Чтобы собрать утилиты, перейдите в соответствующие каталоги и выполните сборку с помощью `make`.

#### Сборка `s21_cat`

1. Перейдите в каталог `src/cat/`:
   ```bash
   cd src/cat
   ```
2. Выполните сборку:
   ```bash
   make
   ```
3. Исполняемый файл `s21_cat` будет создан в этом же каталоге.

#### Сборка `s21_grep`

1. Перейдите в каталог `src/grep/`:
   ```bash
   cd src/grep
   ```
2. Выполните сборку:
   ```bash
   make
   ```
3. Исполняемый файл `s21_grep` будет создан в этом же каталоге.

---

### Запуск тестов

Каждая утилита включает тесты для проверки функциональности.

#### Тестирование `s21_cat`

1. В каталоге `src/cat/` выполните:
   ```bash
   make test
   ```

#### Тестирование `s21_grep`

1. В каталоге `src/grep/` выполните:
   ```bash
   make test
   ```

---

### Очистка файлов сборки

Для удаления временных файлов и исполняемых файлов используйте цель `clean`.

#### Очистка для `s21_cat`

1. В каталоге `src/cat/` выполните:
   ```bash
   make clean
   ```

#### Очистка для `s21_grep`

1. В каталоге `src/grep/` выполните:
   ```bash
   make clean
   ```

---

## Примечания

* Обе утилиты соответствуют стандартам GNU для CLI-инструментов.
* Реализована обработка ошибок и учет граничных случаев для обеих утилит.

Модифицируйте или улучшайте функционал по мере необходимости. Удачи в разработке! 🚀
