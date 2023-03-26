#!/bin/sh

#clang -Wall -Wextra main.c -o main -lraylib -lm || exit
#./main

cobc -Wall -Wextra -g -x game.cbl raylib.cbl rayglue.c -lraylib -lm || exit
./game || exit
