#include <getopt.h>
#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
  int e;
  int i;
  int v;
  int c;
  int l;
  int n;
  int h;
  int s;
  int f;
  int o;
  int files_count;
  int line_number;
  int number_of_similarities;
} flags;

int parse_arguments(int argc, char **argv, flags *FLAG, char **pattern);
void process_files(const char *filename, flags *FLAG, const char *pattern);
void process_line(char *line, flags *FLAG, const char *pattern,
                  const char *filename);
void print_additional_data(flags *FLAG, const char *filename);
void e_flag(flags *FLAG, char **pattern, const char *optarg);
void f_flag(flags *FLAG, char **pattern, char *optarg);
int make_pattern(char **dest_pattern, const char *new_piece);
void add_pattern(char **dest_pattern, const char *new_piece);
void *safe_realloc(void *ptr, size_t new_size);
char *read_line_dynamic(FILE *file);

void print_match_o(regex_t *regex, char *line, flags *FLAG,
                   const char *filename);

void usage_error() {
  fprintf(stderr, "Usage: s21_grep [FLAGS] PATTERN [FILE...]\n");
  exit(EXIT_FAILURE);
}

int main(int argc, char **argv) {
  if (argc > 1) {
    flags FLAG = {0};
    char *pattern = NULL;
    int current_index = parse_arguments(argc, argv, &FLAG, &pattern);

    for (int i = current_index; i < argc; i++) {
      process_files(argv[i], &FLAG, pattern);
    }

    if (pattern) {
      free(pattern);
      pattern = NULL;
    }
  } else {
    usage_error();
  }
  return 0;
}

int parse_arguments(int argc, char **argv, flags *FLAG, char **pattern) {
  int opt;
  while ((opt = getopt(argc, argv, "e:ivclnhsf:o")) != -1) {
    switch (opt) {
      case 'e':
        e_flag(FLAG, pattern, optarg);
        break;
      case 'i':
        FLAG->i = 1;
        break;
      case 'v':
        FLAG->v = 1;
        break;
      case 'c':
        FLAG->c = 1;
        break;
      case 'l':
        FLAG->l = 1;
        break;
      case 'n':
        FLAG->n = 1;
        break;
      case 'h':
        FLAG->h = 1;
        break;
      case 's':
        FLAG->s = 1;
        break;
      case 'f':
        f_flag(FLAG, pattern, optarg);
        break;
      case 'o':
        FLAG->o = 1;
        break;
      case '?':
      default:
        usage_error();
        break;
    }
  }

  if (!FLAG->e && !FLAG->f) {
    if (optind < argc) {
      if (!make_pattern(pattern, argv[optind])) {
        fprintf(stderr, "Failed to allocate memory for pattern.\n");
        exit(EXIT_FAILURE);
      }
      optind++;
    } else {
      usage_error();
    }
  }

  if (FLAG->o && (FLAG->l || FLAG->c)) {
    FLAG->o = 0;
  }

  FLAG->files_count = argc - optind;
  return optind;
}

void process_files(const char *filename, flags *FLAG, const char *pattern) {
  FILE *fp = fopen(filename, "r");
  if (!fp) {
    if (!FLAG->s) {
      fprintf(stderr, "s21_grep: %s: No such file or directory\n", filename);
    }
    return;
  }

  FLAG->line_number = 0;
  FLAG->number_of_similarities = 0;

  char *line = NULL;
  while ((line = read_line_dynamic(fp)) != NULL) {
    FLAG->line_number++;
    process_line(line, FLAG, pattern, filename);
    free(line);
    line = NULL;
  }

  print_additional_data(FLAG, filename);
  fclose(fp);
}

void process_line(char *line, flags *FLAG, const char *pattern,
                  const char *filename) {
  regex_t regex;
  int cflags = REG_EXTENDED;
  if (FLAG->i) {
    cflags |= REG_ICASE;
  }

  if (regcomp(&regex, pattern, cflags) != 0) {
    return;
  }

  int match_found = (regexec(&regex, line, 0, NULL, 0) == 0);
  int condition = (FLAG->v) ? !match_found : match_found;

  if (condition) {
    FLAG->number_of_similarities++;
    if (!FLAG->c && !FLAG->l) {
      if (FLAG->files_count > 1 && !FLAG->h && !FLAG->o) {
        printf("%s:", filename);
      }
      if (FLAG->n && !FLAG->o) {
        printf("%d:", FLAG->line_number);
      }
      if (FLAG->o) {
        print_match_o(&regex, line, FLAG, filename);
      } else {
        printf("%s\n", line);
      }
    }
  }

  regfree(&regex);
}

void print_additional_data(flags *FLAG, const char *filename) {
  if (FLAG->l && FLAG->number_of_similarities > 0) {
    printf("%s\n", filename);
  } else if (FLAG->c) {
    if (FLAG->files_count > 1 && !FLAG->h) {
      printf("%s:", filename);
    }
    printf("%d\n", FLAG->number_of_similarities);
  }
}

void e_flag(flags *FLAG, char **pattern, const char *optarg) {
  FLAG->e = 1;
  if (!(*pattern)) {
    make_pattern(pattern, optarg);
  } else {
    add_pattern(pattern, optarg);
  }
}

void f_flag(flags *FLAG, char **pattern, char *optarg) {
  FLAG->f = 1;
  FILE *fp = fopen(optarg, "r");
  if (!fp) {
    if (!FLAG->s) {
      fprintf(stderr, "s21_grep: %s: No such file or directory\n", optarg);
    }
    return;
  }
  char *line = NULL;
  while ((line = read_line_dynamic(fp)) != NULL) {
    if (strlen(line) > 0) {
      if (!(*pattern)) {
        make_pattern(pattern, line);
      } else {
        add_pattern(pattern, line);
      }
    }
    free(line);
  }
  fclose(fp);
}

void print_match_o(regex_t *regex, char *line, flags *FLAG,
                   const char *filename) {
  regmatch_t match;
  char *cursor = line;

  while (regexec(regex, cursor, 1, &match, 0) == 0) {
    if (FLAG->files_count > 1 && !FLAG->h) {
      printf("%s:", filename);
    }
    if (FLAG->n) {
      printf("%d:", FLAG->line_number);
    }
    fwrite(cursor + match.rm_so, 1, match.rm_eo - match.rm_so, stdout);
    putchar('\n');
    cursor += match.rm_eo;
  }
}

int make_pattern(char **dest_pattern, const char *new_piece) {
  *dest_pattern = (char *)calloc(strlen(new_piece) + 1, 1);
  if (!(*dest_pattern)) return 0;
  strcpy(*dest_pattern, new_piece);
  return 1;
}

void add_pattern(char **dest_pattern, const char *new_piece) {
  size_t old_len = strlen(*dest_pattern);
  size_t add_len = strlen(new_piece);
  *dest_pattern = (char *)safe_realloc(*dest_pattern, old_len + add_len + 2);
  if (*dest_pattern) {
    strcat(*dest_pattern, "|");
    strcat(*dest_pattern, new_piece);
  } else {
    fprintf(stderr, "Failed to reallocate memory for pattern.\n");
    exit(EXIT_FAILURE);
  }
}

void *safe_realloc(void *ptr, size_t new_size) {
  void *temp = realloc(ptr, new_size);
  if (!temp) {
    free(ptr);
    ptr = NULL;
  }
  return temp;
}

char *read_line_dynamic(FILE *file) {
  if (!file) return NULL;
  size_t buf_size = 256;
  size_t length = 0;
  char *buffer = (char *)calloc(buf_size, 1);
  if (!buffer) return NULL;

  int ch;
  while ((ch = fgetc(file)) != EOF) {
    if (ch == '\n') {
      break;
    }
    buffer[length++] = (char)ch;
    if (length + 1 >= buf_size) {
      buf_size += 256;
      char *new_buf = (char *)safe_realloc(buffer, buf_size);
      if (!new_buf) {
        free(buffer);
        return NULL;
      }
      buffer = new_buf;
    }
  }

  if (length == 0 && ch == EOF) {
    free(buffer);
    return NULL;
  }
  buffer[length] = '\0';
  return buffer;
}
