.data  #0x10001000
	size: .word 7
	arr: .word -102 3 0 1 2 4 9 3 -8 -29 21 -24 25 25 13 1 24 16 -18 29 0
.text

main:
	addi $s3, $0, 20 	# array size
	la $a1, arr #loads first index of array address
	addi $a1, $a1, 4 #initial offset 4
	addi $s2, $a1, 0 #copy original address
	addi $s4, $0,1 #register with value 1 for beq checkk
	addi $t0, $0, 0 #int counter
	addi $t1, $0, 0 #swapHold spot for tmp switch holder
	#addi $t2, $0, 0 #index (i)
	
	#addi $s4, $s3, 0 #end loop condition for inner loop(N-1 at first -i later)
	addi $t6, $0, 0 #flag for if conditional
	addi $t9, $0, 0 #both conditions checker

	addi $t2, $0, 0 #index (i) =0
	#end is size/$s3 and is already initialized
outerloop:
	beq $t2, $s3, exit
	addi $t3, $0, 0 #index (j)
	subu $s1, $s3, 1 #get N-1
	j innerloop
increment: 
	addi $t3, $t3, 1 #increment j
	#addi $a1, $a1, 4 #increment address by 4
offset:
	addi $a1, $a1, 4 #increment address by 4
innerloop:
	beq $t3, $s1, endouter #2nd for loop
	#addi $a1, $a1, 4 #increment address by 4
	#fill here
	
	lw $t4,($a1) #load contents of swappable[i]
	lw $t5, 4($a1) #load contents of swappable[i+1]
	slt $t6, $t5, $t4 #if swappable[i+1] < swappable[i] set $t6 to 1
	beq $t6, $0, increment #if $t6 = 1 (swappable[i+1] < swappable[i)] then fall through and execute
	addi $t1, $t4, 0 #swapHold = swappable[i]
	addi $t7, $t5 0 #load value of swappable[i+1] into a temp register to store into swappable[i] later
	addi $t8, $t1, 0 #load value of swapHold (swappable[i]) into a register to store into swappable[i+1] later
	sw $t7, ($a1) #store swappable[i+1] into swappable[i] memory slot
	sw $t8, 4($a1) #store swappable[i] into swappable [i+1] memory slot
	addi $t3, $t3, 1 #increment j
	j offset
endouter:
	addi $t2, $t2, 1 #increment i
	addi $a1, $s2, 0 #reset to original address
	j outerloop
exit:

addi  $2,  $0,  10              # Place "10" in $v0 to signal an "exit" or "halt"
syscall                         # Actually cause the halt