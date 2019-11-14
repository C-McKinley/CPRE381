	.data
Space:		.asciiz		" "
c: 	.word 0:100 #int c[100] is global
array:	.word 42,12,13,82,10000,1,12,0,-1,60,32,3,4,5,6,7
	.text

Main:	
	la $a0, array	
	li $sp, 2147479548
	addi $a1, $zero, 0 	
	addi $a2, $zero, 15 	
	jal mergesort		
	jal print		
	li  $v0, 10		
	syscall
	
mergesort: 
	slt $t0, $a1, $a2 	
	beq $t0, $zero, Exit	
	
	addi, $sp, $sp, -16 	
	sw, $ra, 12($sp)	
	sw, $a1, 8($sp)	       
	sw, $a2, 4($sp)        

	add $s0, $a1, $a2	
	sra $s0, $s0, 1		
	sw $s0, 0($sp) 		
				
	add $a2, $s0, $zero 	
	jal mergesort		
	
	lw $s0, 0($sp)		
	addi $s1, $s0, 1	
	add $a1, $s1, $zero 	
	lw $a2, 4($sp) 		
	jal mergesort 		
	
	lw, $a1, 8($sp) 	
	lw, $a2, 4($sp)  	
	lw, $a3, 0($sp) 	
	jal merge			
				
	lw $ra, 12($sp)		
	addi $sp, $sp, 16 	
	jr  $ra

	
merge:
	add  $s0, $a1, $zero 	
	add  $s1, $a1, $zero 	
	addi $s2, $a3, 1  	

while_Loop: 				
	blt  $a3,  $s0, while_Loop1	
	blt  $a2,  $s2, while_Loop1
	j  if				
	
if:
	sll  $t0, $s0, 2	
	add  $t0, $t0, $a0	
	lw   $t1, 0($t0)	
	sll  $t2, $s2, 2	
	add  $t2, $t2, $a0	
	lw   $t3, 0($t2)		
	blt  $t3, $t1, els	
	la   $t4, c		
	sll  $t5, $s1, 2	
	add  $t4, $t4, $t5	
	sw   $t1, 0($t4)	
	addi $s1, $s1, 1	
	addi $s0, $s0, 1	
	j    while_Loop		
	
els:
	sll  $t2, $s2, 2	
	add  $t2, $t2, $a0	
	lw   $t3, 0($t2)	
	la   $t4, c		
	sll  $t5, $s1, 2	
	add  $t4, $t4, $t5	
	sw   $t3, 0($t4)	
	addi $s1, $s1, 1	
	addi $s2, $s2, 1	
	j    while_Loop		
	
while_Loop1:
	blt  $a3, $s0, while_Loop2
	sll $t0, $s0, 2		
	add $t0, $a0, $t0	
	lw $t1, 0($t0)		
	la  $t2, c		
	sll $t3, $s1, 2        
	add $t3, $t3, $t2	
	sw $t1, 0($t3) 		
	addi $s1, $s1, 1   	
	addi $s0, $s0, 1   	
	j while_Loop1		
	

while_Loop2:
	blt  $a2,  $s1, for_Begin
	sll $t2, $s2, 2    	
	add $t2, $t2, $a0  	
	lw $t3, 0($t2)     	
	
	la  $t4, c		
	sll $t5, $s1, 2	   	
	add $t4, $t4, $t5  	
	sw $t3, 0($t4)     	
	addi $s1, $s1, 1   	
	addi $s2, $s2, 1   	
	j while_Loop2		

for_Begin:
	add  $t0, $a1, $zero	
	addi $t1, $a2, 1 	
	la   $t4, c		
	j    for
for:
	slt $t7, $t0, $t1  	
	beq $t7, $zero, Exit	
	sll $t2, $t0, 2   	
	add $t3, $t2, $a0	
	add $t5, $t2, $t4	
	lw  $t6, 0($t5)		
	sw $t6, 0($t3)   	
	addi $t0, $t0, 1 	
	j for 			
	
print:
	add $t0, $a1, $zero 	
	add $t1, $a2, $zero	
	la  $t4, array		
	
print_Loop:
	blt  $t1, $t0, Exit	
	sll  $t3, $t0, 2	
	add  $t3, $t3, $t4	
	lw   $t2, 0($t3)	
	move $a0, $t2		
	li   $v0, 1		
	syscall
	
	addi $t0, $t0, 1	
	la   $a0, Space		
	li   $v0, 4		
	syscall
	j    print_Loop		
	
Exit:
	jr $ra			
