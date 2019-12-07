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

## Basic Syntax

### Declaration

```python
int a
bool b
string c
list d
```

### Assignment

```python
a = 3
b = 4
c = "Hello World"
d = [1, 34, 2]
```

### Arithmetic Expression

MiniPy supports **Addition**, **Modulo**, **Subtraction**, **Divistion**, **Multiplication** operations for integer variables:

```python
a = a + b 
a = a * b
c = a - b
a = a / b
a = a % b
```

### Boolean Expression

MiniPy supports **Negation**, **And**, **Or** for bool variables:

```python
bool a
bool b
a = true
b = false
a = a && b
a = ~b
b = a || b
```

## Looping Expression

```python
while (b >= 0) do
    print(b)
    b = b-1
done
```

## Branching Expression

```python

