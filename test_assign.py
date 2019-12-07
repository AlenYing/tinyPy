int a
int b
bool c
bool d
string s
list l
a = 1
b = 8
s = "Hello"
c = false
l = [1, 2, 3, 5]
d = true
a = a + b
b = b - 1
c = a > b || c
d = ~ d
print("Hello World")
print(a)
print(b)
print(c)
print(d)
print(s)
print(l[3])

print("Looping Test:")

while (b >= 0) do
    print(b)
    b = b-1
done

print("Branching Test:")

if (a > b) then
    print("a > b is true")
else
    print("a < b is true")
