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
    PUSH {LR} // Push registers used for recursion onto the stack

    CMP  A1, #2 // compares A1 (n) == immediate 2
    BEQ base_case1 // If equal, go to base_case1

    CMP A1, #0 // compares A1 (n) =  immediate 0
    BEQ base_case2 // If equal, go to base_case2

    // 2* pell(n-1)

    SUB A1, A1, #1 // A2 (n - 1) = A1 (n) - 1 
    BL pell // recursive -> pell(n-1)

    // !TODO: Add saving
    PUSH {A1, LR} // Saves A1 on the stack

    // MOV A2, A1 // resets A1 to n  || A1 = A2 (n)

    // pell(n-2)
    SUB A3, A1, #2   // A3 (n-2) = A1 (n) - 2
    BL pell          // recursive call for pell(n-2)

    
    POP {A1, LR} // Restore pell(n-1) from the stack
    // Calculate pell(n) = pell(n-1) + 2 * pell(n-2)
    ADD A1, A3, A1     // A1 = pell(n-1) + pell(n-2)
    LSL A1, A1, #1     // A1 = 2 * (pell(n-1) + pell(n-2))

    // Restore LR from the stack
    POP {LR}

    // Return to the calling function
    BX LR

// if (n == 2)
base_case1: 
    MOV A1, #1 // R0 = 1
    B end_pell       // Go to end of pell function

    // BX LR // return 1 || PC <-- LR

// if (n == 1)
base_case2: 
    MOV A1, #0 // R0 = 0
    //BX LR // return 0 || PC <-- LR
    B end_pell

end_pell:
    // Return to the calling function
    BX LR




