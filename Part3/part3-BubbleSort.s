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
      // your code starts here