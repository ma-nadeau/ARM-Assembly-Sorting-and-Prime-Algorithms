.global _start

N: .word 10         // input parameter n
P: .space 4         // Pell number result

_start:
    ldr A1, N       // get the input parameter
    bl pell         // go!
    str A1, P       // save the result

stop:
    b stop

    // Pell number calculation
    // pre-- A1: Pell number index i to calculate, n >= 0
    // post- A1: Pell number P = pell(n)

pell:
// your code starts here
    PUSH {LR}                   // Save the return address

    SUB A1, A1, #1
    CMP  A1, #2                 // compares A1 (n) with immediate 2
    BGT recursive_case          // If A1 (n) > 2 , go to recursive
    B end_pell

recursive_case:

    PUSH {A1, LR}                   // Push current value of N to the stack
    
    // Pell(n-1)
    SUB A1, A1, #1              // A1 (n-1) = A (n) - 1
    BL pell                     // Recursive Case1 ( Pell(n-1) )

    POP {A2, LR}                    // A2 now contains the original value of n
    PUSH {A1, LR}                   // Push  return value of BL pell to the stack
    
    // Pell(n-2)                
    SUB A1, A2, #2              // A1 (n-2) = A2 (n) - 2
    BL pell                     // Recursive Case1 ( Pell(n-2)) 

    POP {A2,LR}                    // Put Pell(n-1) into A2

    LSL A2, A2, #1              // 2 * Pell (n-1)
    
    ADD A1, A1, A2              // return 2 * pell(n - 1) + pell(n - 2);

end_pell:
    pop {PC}