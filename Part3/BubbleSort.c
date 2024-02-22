#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void swap(char* xp, char* yp) {
    char temp = *xp;
    *xp = *yp;
    *yp = temp;
}

// An optimized version of Bubble Sort for sorting strings
char* sort(char *input, int n) {
    char *sorted = (char*)malloc((n + 1) * sizeof(char)); // Allocate memory for sorted string
    if (sorted == NULL) {
        printf("Memory allocation failed!\n");
        exit(1);
    }
    strcpy(sorted, input); // Copy input string to sorted string

    bool swapped;
    for (int i = 0; i < n - 1; i++) {
        swapped = false;
        for (int j = 0; j < n - i - 1; j++) {
            if (sorted[j] > sorted[j + 1]) {
                swap(&sorted[j], &sorted[j + 1]);
                swapped = true;
            }
        }
        // If no two elements were swapped by inner loop,
        // then break
        if (!swapped)
            break;
    }

    return sorted;
}

int main() {
    char input[] = "bubbleSort";
    int n = strlen(input);
    char *sorted = sort(input, n);
    printf("Sorted string: %s\n", sorted);
    free(sorted); // Freeing the memory allocated by sort function
    return 0;
}
