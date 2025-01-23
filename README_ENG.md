# Simple Bash Utils

This repository contains implementations of custom `cat` and `grep` utilities as part of the project. The project is divided into several parts with additional bonus tasks to extend functionality.

---

## Part 1: Working with the `cat` Utility

### Description

The `s21_cat` utility replicates the behavior of the standard `cat` command with support for all standard and GNU-specific flags.

### Features

* Full support for all `cat` flags, including GNU extensions.
* The source, header, and build files are located in the `src/cat/` directory.
* The resulting executable is named `s21_cat` and is placed in the `src/cat/` directory.

---

## Part 2: Working with the `grep` Utility

### Description

The `s21_grep` utility replicates the behavior of the standard `grep` command with the following core functionality.

### Supported Flags

* `-e`: Specify a pattern for matching.
* `-i`: Perform case-insensitive matching.
* `-v`: Invert the sense of matching.
* `-c`: Output only the count of matching lines.
* `-l`: List only filenames that contain matches.
* `-n`: Prefix each line of output with its line number.

### Additional Supported Flags

* `-h`: Suppress the filename prefix on output.
* `-s`: Suppress error messages.
* `-f`: Obtain patterns from a file.
* `-o`: Print only the matching part of the lines.

---

## Part 3: Flag Combinations for `grep`

### Description

This bonus task implements support for combined flags in the `s21_grep` utility.

### Supported Combinations

* Support for combinations such as `-iv`, `-in`, and others, ensuring proper flag interaction.

---

## How to Build and Run

### Prerequisites

Ensure you have the following tools installed:

* `gcc` or any compatible C compiler
* `make`

### Build Instructions

To build the utilities, navigate to the respective directories and use the `make` utility.

#### Building `s21_cat`

1. Navigate to the `src/cat/` directory:
   ```bash
   cd src/cat
   ```
2. Build the project:
   ```bash
   make
   ```
3. The executable `s21_cat` will be generated in the same directory.

#### Building `s21_grep`

1. Navigate to the `src/grep/` directory:
   ```bash
   cd src/grep
   ```
2. Build the project:
   ```bash
   make
   ```
3. The executable `s21_grep` will be generated in the same directory.

---

### Running Tests

Each utility includes tests to verify its functionality.

#### Testing `s21_cat`

1. From the `src/cat/` directory:
   ```bash
   make test
   ```

#### Testing `s21_grep`

1. From the `src/grep/` directory:
   ```bash
   make test
   ```

---

### Cleaning Up

To clean up build files and binaries, use the `clean` target.

#### Cleaning `s21_cat`

1. From the `src/cat/` directory:
   ```bash
   make clean
   ```

#### Cleaning `s21_grep`

1. From the `src/grep/` directory:
   ```bash
   make clean
   ```

---

## Notes

* Both utilities follow the GNU coding standards for CLI tools.
* Proper error handling and edge case coverage are implemented in both `s21_cat` and `s21_grep`.

Feel free to modify or extend the functionality as needed. Happy coding! 🚀
