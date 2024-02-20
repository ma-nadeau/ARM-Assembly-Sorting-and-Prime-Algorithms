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
    // if (n != 1) || (n != 2)
    PUSH {V1,LR}
    CMP  A1, #2 // compares A1 (n) with immediate 2
    BGT recursive_case // If A1 (n) > 2 , go to recursive
    B end_pell               // Return from function

recursive_case:
    MOV V1, A1 
    SUB A1, V1, #1 // A2 (n - 1) = A1 (n) - 1 
    BL pell // recursive -> pell(n-1)

    PUSH {A1, LR} // Saves A1 on the stack

    // pell(n-2)
    SUB A1, V1, #2   // A1 (n-2) = A1 (n-1) - 1
    BL pell          // recursive call for pell(n-2)

    
    POP {A1, LR} // Restore pell(n-1) from the stack
    // Calculate pell(n) = pell(n-1) + 2 * pell(n-2)

    LSL A1, A1, #1     // A1 = 2 * (pell(n-1)

    ADD A1, A3, A1     // A1 = pell(n-1) + pell(n-2)


    // Restore LR from the stack
    POP {LR}
    POP {V1}

    // Return to the calling function
    BX LR
end_pell:
    POP {V1, PC}