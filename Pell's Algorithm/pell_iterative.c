#include <stdio.h>

int pell(int n)
{
    if (n <= 2)
        return n;
 
    int a = 1;
    int b = 2;
    int c, i;
    for (i = 3; i <= n; i++) {
        c = 2 * b + a;
        a = b;
        b = c;
    }
    return b;
}

int main() {
    int n;
    printf("Enter the value of n: ");
    scanf("%d", &n);
    printf("The Pell number for n = %d is: %d\n", n, pell(n));
    return 0;
}