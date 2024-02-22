.global _start


Stuff:		.byte 0,1,2 // input array
			.space 1	// to align next word
N: 			.word	3	// number of elements in Stuff
Sorted:		.space 3	// (optional) sorted output
			.space 1	// to align next word

_start:
	ldr		A1, =Stuff	// get the address of Stuff
	ldr		A2, N		// get the number of things in Stuff
	bl		sort		// go!
	
stop:
	b		stop

// Sorting algorithm
// pre-- A1: Address of array of signed bytes to be sorted
// pre-- A2: Number of elements in array
// post- A1: Address of sorted array
sort:
	PUSH {V1-V5, LR} 		

	MOV V1, #1				// V1 (i) = 1	
	
loop1:

	CMP V1, A2 				// Compare V1 (i) and A2 (n)
	BGE end_loop			//End Loop if V1 (i) >= A2 (n)

	LDRSB V3, [A1, V1] 		// key (V3) = arr[i] 
	SUB V2, V1, #1			// V2 (j) = V1 (i) - 1 

loop2: 
	CMP V2, #0 				// Compare V2 (j) and Imm 0
	BLT loop1_cont			// Branch back to loop1_cont if V2 (j) < 0

	LDRSB V4, [A1, V2] 		// key (V4) = arr[j] 

	CMP V3, V4				// Compare V3 (key) and V4 (arr[j])
	BGE loop1_cont			// if V3 (key) >= V4 (arr[j]) branch to loop1_cont

	ADD A3, V2, #1			// A3 (j+1) =  V3 (j) + 1
	STRB V4, [A1, A3]		// arr[j+1] (V5) 

	SUB V2, V2, #1 			// V2 (j - 1) = V2 (j) - 1
	B loop2

loop1_cont: 
	ADD V2, V2, #1			// A3 (j+1) = V3 (j) + 1

	STRB V3, [A1, V2]		// arr[j + 1] = key;

	ADD V1, V1, #1 			// V1 (i) = V1 (i) + 1
	B loop1					// branch back to loop1

end_loop:
	POP {V1-V5, LR}
	BX LR
