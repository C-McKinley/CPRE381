.data 
	size: .word 6
	numbers: .word 52 15 52 45 25 23
.text

main:
la $25, numbers
addi $3, $25, 0 # address offsetter #data hazard
lw $24, size 	# array size
subu $21, $24, 1 #get N-1 ... #data hazard
lw $4, 0($3) 
add $6, $4, $6 #data hazard


summation:
lw $5 4($3) #control hazard 
beq $2, $21, wrapUp #control hazard
addi $2, $2, 1 #index increase
add $6,$6,$5 
addi $3, $3, 4
j summation

wrapUp:
addiu $3, $3, 4 
sw $6, 0($3) #store the summation result to mem. data hazard
lw $4, 0($3)

mean:
slt $4, $6, $24 
bne $4, $0, resultZero #branch hazard
subu $6, $6, $24
addi $7, $7, 1
j mean
resultZero:
addi $3, $3, 4
sw $7, 0($3)

memSort:

and $2, $2, 0 #reset to 0. This will be a temp register
xor $4, $4, $4 #reset to 0, this will be an index
addi $3, $25, 0 # address offsetter reset
addi $21, $21, 2 #N-1 + 2 the data we added

j cond_check
loop:
#subu $7, $7,$7 #make sure $7 is zero initially 
lw $5, 0($3) #swappable i
lw $6, 4($3)  #swappable i+1
slt $7, $6, $5	#if (swappable i+1 < swappable 1) { $7 will be be 1 #hazard
beq $7, $0, increment
addi $2, $5, 0 #swaphold = swappable[i]
addi $5, $6, 0 #swappable[i] = swappable[i+1]
sw $5, 0($3) #hazard
addi $6, $2, 0 #swappable [i+1] = swaphold
addi $3, $3, 4 #move through memory
sw $6, 0($3) #hazard
lui $4, 0 #reset index
addi $3, $25, 0 #offset reset
j cond_check #go to start
increment:
addi $4,$4,1 #i++
addi $3, $3, 4 #move through memory
cond_check:
beq $4, $21 memShift #and while i doesn't equal N-1
j loop #while loop continuee

memShift:

lw $1, 28($25)
sw $1, 32($25)

lw $1, 24($25)
sw $1, 28($25)

lw $1, 20($25)
sw $1, 24($25)

lw $1, 16($25)
sw $1, 20($25)

lw $1, 12($25)
sw $1, 16($25)

lw $1, 8($25)
sw $1, 12($25)

lw $1, 4($25)
sw $1, 8($25)

lw $1, 0($25)
sw $1, 4($25)

sw $0, 0($25) 

#some extra stuff just running other instructions
#addi hazards
addiu $20, $0, 4
addiu $23, $25, 0
nor $5, $5, $5
addi $9, $0, 20
addiu $7, $7, 10
addiu $0, $2, 12 #hazard check for register 0
lui $3, 12
addu $2, $3, $3
lui $4, 11
and $2, $3, $4
add $3, $2, $3
subu $6, $2, $3
srl $6, $5, 5
addi $5, $5, 1
lw $5, 0($25)
xori $5, $5, 5

lui $4, 2
srl $2, $4, 10
sll $4, $2, 15
ori $4, $4, 4

sw $4, 0($25)
stuff:

add $7, $7, $7
sw $7, 0($23)
addi $23, $23, 4
add $10, $10, 1
bne $10, $9, stuff
addiu $1, $0, 5
addiu $1, $1, 5
and $1, $1, 10
addi $3, $0, 0

loop2:
addi $5, $5, -1 	
slt $6, $5, $1		
beq $6, $0, loop2	

addi $6, $0, 3
or $5, $5, $6		
andi $4, $4, 0
and $5, $5, $1		
add $4, $4, $1		
beq $4, $0, loop2	

subu $4, $4, $5
andi $4, $4, 23
addi $5, $0, 44
sll $5, $5, 2
subu $4, $4, $5
addu $6, $4, $5
xori $7, $0, 23
addu $8, $4, $4
addu $4, $8, 320
sll $5, $4, 6
andi $5, $4, 43
la $12 setLessThanUnit

jr $12
resume:
bne $10,$14, a
j b
setLessThanUnit:
slt $9, $4,$5
sltiu $10, $9, 1
sltu $11, $10, $9
slti $14, $11, 1
la $13, resume
jr $13

a:
addu $4,$5,$6
sra $4, $14, 10
or $4, $4, $5
la $13 skipb
jr $13
b:
sll $5,$10, 10
ori $4, $4, 8
skipb:
lui $4, 124
nor $5, $4, $6
ori $6, $5, 5
or $7, $6, $5
xori $0, $7, 24
sra $7, $7, 22


la $13, check_bne
addi $4,$0, 12
check_bne:
sltu $7, $4, $8
bne $7, $0, inc
 j d
inc:
addi $16, $16, 4
sra $8, $16, 4
xor $8, $8, 6
jr $13

d: 
and $8, $16, 4
nor $9, $8, $7
sltu $11, $8, $9
ori $10, $11, 8
slti $10, $10, 4

addi $1, $0, 5
andi $4, $1, 10
addi $2, $0, 15
andi $3, $2, 10
sltu $5, $4, $3
sra $6, $5, 10
bne $6, $0, e
la $7, f
jr $7
e:
slti $10, $6, -12
nor $11, $10, $6
xor $12, $10, $11
j f
f:
xor $10, $5, $3
nor $11, $10, $3
or $12, $11, $10
sltiu $13, $12, 15
addi $1, $0, 1
bne $13, $1, g
srl $12, $11, 3
sltiu $15, $12, 52
bne $15, $1, g
or $15, $12, $10

g:
andi $10, $11, 4
xori $11, $10, 6
sltiu $12, $11, 14
ori $13, $11, 135
slti $12, $13, 200
srl $14, $13, 19
sltu $15, $14, $10
xor $15, $14,$10

addi $1, $0, 1
xori $2, $0, 1
sltu $2, $1, $2
beq $1, $2, stuff
srl $3, $2, 2
sll $4, $2, 1
slti $5, $4, -12
sltiu $6, $4, 15
ori $7, $5, 3
slt $8, $7, $3
sra $2, $7, 12
exit:
addi  $2,  $0,  10              # Place "10" in $v0 to signal an "exit" or "halt"
syscall                         # Actually cause the halt
