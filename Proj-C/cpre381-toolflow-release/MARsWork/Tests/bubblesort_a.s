#this is the original tested and working bubblesort uncut
#loaded with a bunch of sll $0, $0, 0s to test the pipeline processor 

.data  #0x10001000
	size: .word 20
	arr: .word -102 3 0 1 2 4 9 3 -8 -29 21 -24 25 25 13 1 24 16 -18 29
.text

main:
	
	#loads first index
	lui $at, 4097 
	addi $s4, $0,1 #register with value 1 for beq check
	lui $s3, 4097 
	
	#done loading
	ori $a1, $at, 0
	addi $t0, $0, 0 #int counter 
	addi $t2, $0, 0 #index (i) =0
	lw $s3, 0 ($1)
	addi $a1, $a1, 4 #initial offset 4 #ok
	#lw $s3, size 	# array size #okay
	
	
	#la $a1, arr #loads first index of array address #ok
	
	#end is size/$s3 and is already initialized
outerloop:
	beq $t2, $s3, exit
	lui $s5, 0
	ori $1, $s5, 1 
	addi $t9, $0, 0 #both conditions checker
	addi $s2, $a1, 0 #copy original address
	subu $s1, $s3, 1 #get N-1
	addi $t3, $0, 0 #index (j)
	addi $t6, $0, 0 #flag for if conditional
	j innerloop
increment: 
	addi $t3, $t3, 1 #increment j
	#addi $a1, $a1, 4 #increment address by 4
offset:
	
	addi $a1, $a1, 4 #increment address by 4
innerloop:
	sll $0, $0, 0#needed
	sll $0, $0, 0#needed
	beq $t3, $s1, endouter #2nd for loop
	lw $t4,($a1) #load contents of swappable[i]
	lw $t5, 4($a1) #load contents of swappable[i+1]
	sll $0, $0, 0#needed
	sll $0, $0, 0#needed
	slt $t6, $t5, $t4 #if swappable[i+1] < swappable[i] set $t6 to 1
	sll $0, $0, 0#needed
	sll $0, $0, 0#needed
	sll $0, $0, 0#needed
	beq $t6, $0, increment #if $t6 = 1 (swappable[i+1] < swappable[i)] then fall through and execute
	addi $t1, $t4, 0 #swapHold = swappable[i]
	addi $t7, $t5 0 #load value of swappable[i+1] into a temp register to store into swappable[i] later
	sll $0, $0, 0 #needed 
	addi $t8, $t1, 0 #load value of swapHold (swappable[i]) into a register to store into swappable[i+1] later
	sw $t7, ($a1) #store swappable[i+1] into swappable[i] memory slot
	addi $t3, $t3, 1 #increment j
	sw $t8, 4($a1) #store swappable[i] into swappable [i+1] memory slot
	j offset
endouter:
	
	addi $t2, $t2, 1 #increment i
	sll $0, $0, 0
	addi $a1, $s2, 0 #reset to original address
	j outerloop
exit:

addi  $2,  $0,  10              # Place "10" in $v0 to signal an "exit" or "halt"
syscall                         # Actually cause the halt
