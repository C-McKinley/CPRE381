#
# Bubble sort for Proj-B
#

# data section
.data

array:		.word 82, 379, 390, 241, 319, 16, 228, 132, 50, 387, 214, 243, 46, 446, 59, 274, 63, 360, 141, 240, 161, 21, 208, 357, 377, 133, 3, 201, 492, 75, 341, 210, 301, 345, 438, 469, 485, 174, 426, 40, 83, 79, 370, 222, 272, 175, 166, 55, 324, 452, 32, 404, 424, 431, 356, 445, 238, 298, 248, 171, 305, 13, 108, 388, 227, 10, 39, 223, 287, 396, 261, 447, 500, 120, 411, 18, 350, 466, 45, 478, 43, 224, 347, 420, 282, 362, 453, 279, 41, 229, 325, 6, 481, 499, 286, 235, 440, 450, 283, 181
iterator:	.word 0  # start iterator at index = 0
size:		.word 99 # amount of values in the array - 1

prompt:		.asciiz "The bubble sorted array is:"
space:		.asciiz " "

.text

main:
la $t0, array
lw $t1, iterator
lw $t2, size

begin_loop:
nop
nop
nop
beq $t1, $t2, increment # increment when the iterator is equal to the size of array
			# Adding offset:
sll $t3, $t1, 2		# 4i
addu $t3, $t3, $t0	# 4i += 4
nop
nop
nop
lw $t6, 0($t3)		# load current value of the index
lw $t7, 4($t3)		# load next value of the index
nop
nop
nop

bgt $t6, $t7, swap	# if the current value is greater than the next value, swap

addi $t1, $t1, 1 	# increment the iterator

j begin_loop


swap:
addi $t5, $t6, 0	# store temp in temp register to preform swap	
sw $t6, 4($t3)		# swap current val with next val
sw $t7, 0($t3)

addi $t1, $t1, 1 	# increment the iterator

j begin_loop

increment:
beq $t2, $zero, exit_loop

lw $t1, iterator	# reset iterator to 0
subi $t2, $t2, 1	# subtract 1 from the size because value is in place on the right

j begin_loop

exit_loop:
li $v0, 4
la $a0, prompt		
syscall			# print "The bubble sorted array is:"	

j print_array

print_array:
lw $t2, size
nop
nop
nop
bgt $t1, $t2, exit 	# exit when the iterator is greater than size of array
			# Adding offset:
sll $t3, $t1, 2		# 4i
nop
nop
nop
addu $t3, $t3, $t0	# 4i += 4
nop
nop
nop
lw $t6, 0($t3) 		# load the value of current index

li $v0, 4
la $a0, space
syscall			# print a space

li $v0, 1
la $a0, ($t6)
syscall			# print the value

addi $t1, $t1, 1 	# increment the iterator

j print_array

exit:
li $v0, 10
syscall			# exit call
