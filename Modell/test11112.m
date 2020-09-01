clear
Matrix=[1 2 3 4; 5 6 7 8; 9 10 11 12]

booleanValue = any(any(Matrix>=10));

[y(1,:),x(1,:)] = find(Matrix>=15)


find((Matrix>=10)')