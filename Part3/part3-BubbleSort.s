.global _start


Stuff:		.byte 3,1,-12,-8 // input array
			//.space 1	// to align next word
N: 			.word	4	// number of elements in Stuff
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

	PUSH {V1-V7, LR} 		// Push {V1-V7, LR} to the stack
	MOV V1, #0				// V1 (i) = 0				
	
loop1:

	SUB A3, A2, #1 			// A3 (n-1) = A2 (n) - 1
	CMP V1, A3 				// Compare V1 (i) and A3 (n-1)
	BGE end_loop			//End Loop if V1 (i) >= A3 (n-1)
	
	MOV V2, #0				// V2 (j) = 0

loop2:

	SUB V3, A3, V1			// V3 ( n-i-1 ) = A3 (n - 1) - V1 (i) 
	CMP V2, V3 				// Compare V2 (j) and V3 ( n - i - 1)
	BGE loop1_cont			// Branch back to loop1_cont if V2 (j) >= V3 ( n - i - 1)

if:
	LDRSB V4, [A1, V2] 		// key (V4) = arr[j] 
	
	ADD V5, V2, #1			// V5 (j+1) = V2 (j) + 1
	LDRSB V6, [A1, V5] 		// V6 = arr[j+1] 
	CMP V4, V6				// Compare V4 (arr[j]) and V6 (arr[j+1])
	BLE loop2_cont			// if V4 (arr[j]) <= V4 (arr[j+1]) branch to loop1_cont

	MOV V7, V4 				// tmp of arr[j]
	STRB V6, [A1, V2]		// Stores V6 (arr[j+1]) into arr[j]
	STRB V7, [A1, V5]		// Stores V7 (arr[j]) into arr[j+1]
	
	MOV A4, #1 				// Swapped = true

	ADD V2, V2, #1 			// V2 (j + 1) = V2 (j) + 1
	B loop2					// Loop back up to loop2

loop2_cont: 
	ADD V2, V2, #1 			// V2 (j+1) = A2 (j) + 1
	B loop2					// Loop back up to loop2
	
loop1_cont:
	CMP A4, #0				// Compare A4 (Swapped) with #0 (False)
	BEQ end_loop			// if A4 (Swapped) = #0 (false), end loop	
	ADD V1, V1, #1 			// V1 (i+1) = V1 (i) + 1
	B loop1					// branch back to loop1

end_loop:
	POP {V1-V7, LR}			// Reset {V1-V7, LR} from the stack
	BX LR					// return
