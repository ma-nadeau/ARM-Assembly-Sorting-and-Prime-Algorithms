.global _start
N:			.word 12
Numbers:	.short 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 
Primes:		.space 24

_start: 

	MOV R1, #0 						// R1: num = 0
	MOV R2, #0 						// R2: pri = 0
	MOV R3, #1 						// R3: prime = 1
	MOV R4, #0						// R4: done = 0 (false)
	LDR R5, N 						// R5 = N (12)

loop1: 								// while(!done)

	CMP R4, #0 						// Compare R4 ( done = 0) to #0
	BNE end_loop1 					// branch to end_loop if not equal 
	SUB R1, R3, #1 					// R1 (num) =  R3 (prime) - 1
	 
non_zero_condition: 				// num < n
	
	CMP R1, R5 						// R1 (num) < 12 (N)
	BGE if_num_greater_n 			// Exit the loop if num >= n
  
	LDR R7, =Numbers 				// R7: Address of Numbers
	LSL R8, R1, #1 					// R8 (num) >> word length 
	LDRH R0, [R7, R8]  				// R0: R0 = Numbers[ R7 (address of Numbers + R8 (schifting) ]
	LSR R8, R1, #1 					// R8 (num) << word length  
	CMP R0, #0 						// compare curr number with 0
	BNE if_num_greater_n 			// branch to if_num_greater_n || R0 != #0 
	ADD R1, R1, #1 					// R1 (num) = R1 (num) + 1
	B non_zero_condition 			// Branch back to non-zero-condition
	
if_num_greater_n: 					// num >= n

	CMP R1, R5 						// R1 (num) <= 12 (N)
	BLT else_num_smaller_equal_n 	// Exit the loop if num >= n
	MOV R4, #1 						// R4: done = 1 (true) 
	B loop1 						// Branch back to loop 1

else_num_smaller_equal_n:			// else
	
	MOV R3, R0 						// R3 (prime) = R0 (numbers[num])  
	LDR R6, =Primes 				// R6 address Primes
	LSL R9, R2, #1 					// R9 (pri) >> word length
	STRH R3, [R6, R9]  				// store prime  || primes[pri] = prime
    LSR R9, R2, #1 					// R9 (pri) << word length
	ADD R2, R2, #1  			 	// R2 (pri) : R2 (pri) = R2 (pri) + 1

loop2: 								//while num < n

	CMP R1, R5 						// R1: num < n (R5: 12)
	BGE loop1 						// Loop back up
	MOV R12, #0 					// Places immediate 0 to R12
	LSL R10, R1, #1 				// R10 (num) >>  word length 
	STRH R12, [R7, R10]; 			// Stores halfword from R12 (0) to [R7 + R10] || numbers[num] = 0;
	LSR R10, R1, #1  				// R10 (num) << word length || resets it back
	ADD R1, R1, R3 					// num = num +prime  || R1 = R1 + R3
	B loop2 						// Branch back to loop 2
	
end_loop1:							// end in infinite loop
	B end_loop1						// infinite loop
	

 