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
 
swap: 
	MOV V7, V4 				// tmp of arr[j]
	STRB V6, [A1, V2]		// Stores V6 (arr[j+1]) into arr[j]
	STRB V7, [A1, V5]		// Stores V7 (arr[j]) into arr[j+1]
	
	MOV A4, #1 				// Swapped = true

	ADD V2, V2, #1 			// V2 (j + 1) = V2 (j) + 1
	B loop2					// Loop back up to loop2

partition:

loop1:

    LDRSB V4, [A2] 		    // key (V4) = arr[j]
    MOV V2, A2              // tmp low
    MOV V3, A3              // tmp high
    

    CMP V2, V3
    BGT endloop1



endloop1:
    
	
	CMP V1, A3 				// Compare V1 (i) and A3 (n-1)
	BGE end_loop			//End Loop if V1 (i) >= A3 (n-1)

    BX LR;                 // return to sort at PC after partition

sort:
                            // A1 = arr
                            // A2 = high
    LDR A3, #0              // A3 = Low
    CMP A2, A3              // Compares low (A2) with high (A3)
    BGT stop                // if low (A2) >= high (A3), stop

    PUSH {A1-A3, LR}        // preserve high, low, arr, LR to the stack
    BL partition            // else we partition the array

    MOV V1, A1              // MOV return value of partition to V1 (partitionIndex)

    POP {A1-A3, LR}         // restores high, low, arr, LR to the stack

    PUSH {A1-A3,V1, LR}     // preserve high, low, arr, LR to the stack
    SUB A3, V1, #1          // A3 <- PartitionIndex - 1
    BL sort                 // recursive call
    POP {A1-A3,V1, LR}      // restores high, low, arr, LR to the stack

    PUSH {A1-A3,V1, LR}     // preserve high, low, arr, LR to the stack
    ADD A2, V1, #1          // low (A2) <- PartitionIndex + 1
    BL sort
    POP {A1-A3,V1, LR}      // restores high, low, arr, LR to the stack

    BX LR                   // return





    



