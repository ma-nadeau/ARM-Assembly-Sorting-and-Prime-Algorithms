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

