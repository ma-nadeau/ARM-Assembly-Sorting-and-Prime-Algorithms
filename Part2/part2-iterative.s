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
    PUSH {V1,V2, LR}
    CMP A1, #2                  // Compare A1 (N) with Imm 2
    BLE end_pell                // return A1 (N) when N <= 2  

    MOV A2, #1                  // Initialize A2 = 1
    MOV A3, #2                  // Initialize A3 = 2
    MOV A4, #3                  // Initialize A4 = 3 ==> i = 3  
    MOV V1, A1                  // Initialize V1 = N ==> A1 = SUM = 2 * P(n-1) + P(n-2) 
    MOV A1, #0                  // Set the SUM = 0

loop:    
    CMP A4, V1                  // Compare A4 (i) with V1 (n)
    BGT end_pell                // if i > n stop the loop

add: 
    //c = 2 * P( n - 1 ) + a ( P(n-2) );
    MOV V2, A3                  // Save A3 into V2
    LSL A3, A3, #1              // A3 = 2 * A3 
    ADD A3, A2, A3              // A3 (SUM) = A2 + 2 * A1 
    MOV A1, A3                  // A1 = A1 + A3 ( P(n-2) )
    
    MOV A2, V2                  // P(n-2) = P(n-1)
    MOV A3, A1                  // P(n-2) = A1 (c)

    ADD A4, A4, #1              // i++ 

    B loop                      // Branch back to loop

end_pell:
    POP {V1,V2, LR}
    BX LR                       // Return