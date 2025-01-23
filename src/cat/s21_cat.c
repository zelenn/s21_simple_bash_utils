#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

typedef struct {
  int b;
  int e;
  int n;
  int s;
  int t;
  int v;
  int new_line;
  int b_counter;
  int s_counter;
  int empty_printed;
  int numberFiles;
} flags;

int parse_arguments(int argc, char *argv[], flags *flag);
void process_files(int argc, char *argv[], flags *flag);
void printData(FILE *file, flags *flag);

int main(int argc, char *argv[]) {
  if (argc > 1) {
    flags flag = {0};
    if (parse_arguments(argc, argv, &flag)) {
      process_files(argc, argv, &flag);
    }
  }
  return 0;
}

int parse_arguments(int argc, char *argv[], flags *flag) {
  int opt;
  struct option long_options[] = {{"number-nonblank", no_argument, NULL, 'b'},
                                  {"number", no_argument, NULL, 'n'},
                                  {"squeeze-blank", no_argument, NULL, 's'},
                                  {NULL, 0, NULL, 0}};

  while ((opt = getopt_long(argc, argv, "benstv", long_options, NULL)) != -1) {
    switch (opt) {
      case 'b':
        flag->b = 1;
        break;
      case 'e':
        flag->e = 1;
        flag->v = 1;
        break;
      case 'n':
        flag->n = 1;
        break;
      case 's':
        flag->s = 1;
        break;
      case 't':
        flag->t = 1;
        flag->v = 1;
        break;
      case 'v':
        flag->v = 1;
        break;
      case '?':
        perror("getopt error");
        break;
      default:
        printf(
            "Usage: [--number-nonblank/b] [--number/n] [--squeeze-blank/s] "
            "[-t] [-e]\n");
        return 0;
    }
  }
  flag->numberFiles = argc - optind;
  return 1;
}

void process_files(int argc, char *argv[], flags *flag) {
  for (int x = (argc - flag->numberFiles); x < argc; x += 1) {
    FILE *file = fopen(argv[x], "r");
    if (file != NULL) {
      printData(file, flag);
      fclose(file);
    } else {
      perror("s21_cat");
    }
  }
}

void printData(FILE *file, flags *flag) {
  int prev;
  int tmp_b = flag->b;
  int tmp_n = flag->n;
  while ((prev = getc(file)) != EOF) {
    flag->empty_printed = 0;
    if (flag->s && flag->s_counter == 0 && prev == '\n') {
      flag->s_counter += 1;
    } else if (flag->s_counter != 0 && prev == '\n') {
      flag->s_counter += 1;
      flag->empty_printed = 1;
    } else if (flag->s_counter > 1 && prev != '\n') {
      flag->s_counter = 0;
      if (flag->e) {
        printf("$\n");
      } else {
        printf("\n");
      }
      if (flag->n != 0) printf("%6d\t", flag->n++);
    } else {
      flag->s_counter = 0;
    }
    if (flag->n != 0 || flag->b != 0) {
      if (flag->new_line == 1 && !(flag->new_line = 0)) {
        if (flag->b == 0) printf("%6d\t", flag->n++);
      }
      if (flag->n == 1) printf("%6d\t", flag->n++);
      if (flag->b == 1) printf("%6d\t", flag->b++);
      if (prev == '\n' && flag->n != 0 && flag->empty_printed == 0)
        flag->new_line = 1;
      if (prev == '\n' && flag->b != 0) flag->b_counter += 1;
      if (prev != '\n' && flag->b_counter != 0 && flag->s_counter == 0)
        if (!(flag->b_counter = 0)) printf("%6d\t", flag->b++);
    }
    if (prev == '\n' && flag->e && flag->empty_printed == 0) printf("$");
    if (flag->v) {
      if (prev < 32 && prev != 9 && prev != 10)
        if (prev += 64) printf("^");
      if (prev == 127)
        if ((prev = '?')) printf("^");
    }
    if (flag->t && prev == '\t')
      if ((prev = 'I')) printf("^");
    if (flag->empty_printed == 0) printf("%c", prev);
  }
  flag->n = tmp_n;
  flag->b = tmp_b;
}
