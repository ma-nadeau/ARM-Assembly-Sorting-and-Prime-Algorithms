#include <stdio.h>
int pell(int n)
{
    if (n == 2)
        return 1;
    if (n == 1)
        return 0;
    return 2 * pell(n - 1) + pell(n - 2);
} // pell

int main() {
    int n;
    printf("Enter the value of n: ");
    scanf("%d", &n);
    printf("The Pell number for n = %d is: %d\n", n, pell(n));
    return 0;
}