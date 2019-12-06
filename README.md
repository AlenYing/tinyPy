# MiniPy
A interpreter of a toy language. Using *C++*, *Flex* and *Bison*.

## Features
MiniPy supports three types of variables, including **int**, **bool**, **string**. You can assign them and print them through standard output.
Branching and looping are also implemented.

## Build

### Prequisites

MiniPy use `g++` to compile cpp code and `flex` and `bison` to do lexeme and grammer analysis. `make` is also needed for build reason. You should have them installed on your machine. Linux distributions are prefered.

## Make

Use the following command to build the project:
```
make
```
Use the following command to cleanup all generated target files:
```
make clean
```

## Using the interpreter
The following command interpretes a miniPy program immediately:
```
./miniPy path/to/your/miniPy.program
```