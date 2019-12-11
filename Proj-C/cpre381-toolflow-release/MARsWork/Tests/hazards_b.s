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
addi $3, $3, 4 
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
addi $0, $2, 12 #hazard check for register 0
lui $4, 220
srl $2, $4, 10
sll $4, $2, 10
ori $4, $4, 4


exit:
addi  $2,  $0,  10              # Place "10" in $v0 to signal an "exit" or "halt"
syscall                         # Actually cause the halt