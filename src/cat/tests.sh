#!/bin/bash

SUCCESS=0
FAIL=0
COUNTER=0
DIFF=""

s21_command=(
    "./s21_cat"
    )
sys_command=(
    "cat"
    )

tests=(
"OPTIONS test_files/test_1.txt"
"OPTIONS test_files/test_1.txt test_files/test_2.txt"
)
flags=(
    "b"
    "e"
    "n"
    "s"
    "t"
    "v"
)
manual=(
"-b test_files/test_1.txt"
"-b test_files/test_1.txt nofile.txt"
"-e test_files/test_1.txt"
"-e test_files/test_1.txt nofile.txt"
"-n test_files/test_2.txt"
"-n test_files/test_2.txt nofile.txt"
"-s test_files/test_3.txt"
"-s test_files/test_3.txt nofile.txt"
"-t test_files/test_3.txt"
"-t test_files/test_3.txt nofile.txt"
"-n test_files/test_4.txt"
"-n test_files/test_4.txt test_files/test_5.txt"
"-v test_files/test_5.txt"
"-- test_files/test_5.txt"
"no_file.txt"
)

gnu=(
"-T test_files/test_1.txt"
"-E test_files/test_1.txt"
"-vT test_files/test_3.txt"
"--number test_files/test_2.txt"
"--squeeze-blank test_files/test_1.txt"
"--number-nonblank test_files/test_4.txt"
"test_files/test_1.txt --number --number"
)

run_test() {
    param=$(echo "$@" | sed "s/OPTIONS/$var/")
    "${s21_command[@]}" $param > "${s21_command[@]}".log
    "${sys_command[@]}" $param > "${sys_command[@]}".log
    DIFF="$(diff -s "${s21_command[@]}".log "${sys_command[@]}".log)"
    let "COUNTER++"
    if [ "$DIFF" == "Files "${s21_command[@]}".log and "${sys_command[@]}".log are identical" ]
    then
        let "SUCCESS++"
        echo "\033[31m$FAIL\033[0m/\033[32m$SUCCESS\033[0m/$COUNTER \033[32mSuccess\033[0m  $param"
    else
        let "FAIL++"
        echo "\033[31m$FAIL\033[0m/\033[32m$SUCCESS\033[0m/$COUNTER \033[31mFail\033[0m  $param"
    fi
    rm -f "${s21_command[@]}".log "${sys_command[@]}".log
}

echo "#######################"
echo "MANUAL TESTS"
echo "#######################"
printf "\n"

for i in "${manual[@]}"
do
    var="-"
    run_test "$i"
done
printf "\n"
echo "#######################"
echo "AUTOTESTS"
echo "#######################"
printf "\n"

for var1 in "${flags[@]}"
do
    for i in "${tests[@]}"
    do
        var="-$var1"
        run_test "$i"
    done
done
printf "\n"
echo "\033[31mFAILED: $FAIL\033[0m"
echo "\033[32mSUCCESS: $SUCCESS\033[0m"
echo "ALL: $COUNTER"
printf "\n"
