#
# First part of the Lab 3 test program
#

# data section
.data 
	size: .word 6
	numbers: .word 52 15 52 45 25 23


# code/instruction section
.text
addi  $1,  $0,  1 		# Place “1” in $1
addi  $2,  $0,  2		# Place “2” in $2
addi  $3,  $0,  3		# Place “3” in $3
addi  $4,  $0,  4		# Place “4” in $4
addi  $5,  $0,  5		# Place “5” in $5
addi  $6,  $0,  6		# Place “6” in $6
addi  $7,  $0,  7		# Place “7” in $7
addi  $8,  $0,  8		# Place “8” in $8
addi  $9,  $0,  9		# Place “9” in $9
addi  $10, $0,  10		# Place “10” in $10

add  $1,  $2,  $3 		
add  $2,  $3,  $4		
add  $3,  $4,  $5		
add  $5,  $6,  $7		
add  $7,  $8,  $9	

addiu  $6,  $0,  6		# Place “6” in $6
addiu  $7,  $0,  7		# Place “7” in $7
addiu  $8,  $0,  8		# Place “8” in $8
addiu  $9,  $0,  9		# Place “9” in $9
addiu  $10, $0,  10		# Place “10” in $10
	
addu  $1,  $2,  $3 		
addu  $2,  $3,  $4		
addu  $3,  $4,  $5		
addu  $5,  $6,  $7		
addu  $7,  $8,  $9	

and  $1,  $2,  $3 		
and  $2,  $3,  $4		
and  $3,  $4,  $5		
and  $5,  $6,  $7		
and  $7,  $8,  $9	

andi  $6,  $0,  6		
andi  $7,  $0,  7		
andi  $8,  $0,  8		
andi  $9,  $0,  9		
andi  $10, $0,  10		

lui $1, 100
lui $2, 100
lui $3, 100
lui $4, 100
lui $5, 100

nor  $1,  $2,  $3 		
nor  $2,  $3,  $4		
nor  $3,  $4,  $5		
nor  $5,  $6,  $7		
nor  $7,  $8,  $9	

xor  $1,  $2,  $3 		
xor  $2,  $3,  $4		
xor  $3,  $4,  $5		
xor  $5,  $6,  $7		
xor  $7,  $8,  $9	

xori  $6,  $0,  6		
xori  $7,  $0,  7		
xori  $8,  $0,  8		
xori  $9,  $0,  9		
xori  $10, $0,  10	

or  $1,  $2,  $3 		
or  $2,  $3,  $4		
or  $3,  $4,  $5		
or  $5,  $6,  $7		
or  $7,  $8,  $9	

ori  $6,  $0,  6		
ori  $7,  $0,  7		
ori  $8,  $0,  8		
ori  $9,  $0,  9		
ori  $10, $0,  10

sub    $1,  $5,  $0 		
sub    $2,  $5,  $1		
sub    $3,  $3,  $2		
sub    $4,  $2,  $3		
sub    $5,  $1,  $4

subu   $1,  $5,  $0 		
subu   $2,  $5,  $1		
subu   $3,  $3,  $2		
subu   $4,  $2,  $3		
subu   $5,  $1,  $4

slt  $1,  $2,  $3 		
slt  $2,  $3,  $4		
slt  $3,  $4,  $5		
slt  $5,  $6,  $7		
slt  $7,  $8,  $9	
	
slti  $1,  $5,  0 		
slti  $2,  $5,  1		
slti  $3,  $3,  2		
slti  $4,  $2,  3		
slti  $5,  $1,  4

sltu   $1,  $5,  $0 		
sltu   $2,  $5,  $1		
sltu   $3,  $3,  $2		
sltu   $4,  $2,  $3		
sltu   $5,  $1,  $4

sltiu  $1,  $5,  0 		
sltiu  $2,  $5,  1		
sltiu  $3,  $3,  2		
sltiu  $4,  $2,  3		
sltiu  $5,  $1,  4

sll    $1,  $5,  10		
sll    $2,  $5,  10		
sll    $3,  $3,  10		
sll    $4,  $2,  10		
sll    $5,  $1,  10

srl    $1,  $5,  5		
srl    $2,  $5,  5		
srl    $3,  $3,  5		
srl    $4,  $2,  5		
srl    $5,  $1,  5

sra    $1,  $5,  6 		
sra    $2,  $5,  6		
sra    $3,  $3,  6		
sra    $4,  $2,  6		
sra    $5,  $1,  6


add $1, $0, $0
bne $0, $1, fail 	
add $2, $0, $1	
bne $1, $2, fail	
add $5, $0, $2		
bne $2, $5, fail	
add $8, $0, $5	
bne $5, $8, fail
add $13, $0, $8	
bne $8, $13, fail
add $20, $0, $13	
bne $13, $20, fail
add $25, $0, $20	
bne $20, $25, fail
add $27, $0, $25		
bne $25, $27, fail	
add $30, $0, $27		
bne $27, $30, fail	

addi $5, $0, 5 
addi $1, $0, -2 
addi $2, $0, 3 
beq  $1, $2, branch   
fail:
li $v0, 10
syscall

branch:
addi $5, $0, 10       
lui $1, 4097
sll $0,$0,0
sll $0,$0,0
sll $0,$0,0
ori $25, $1, 4
sll $0,$0,0
sll $0,$0,0
sll $0,$0,0
addi $3, $25, 0 
lw $24, size 	
sll $0,$0,0
sll $0,$0,0
lui $1, 0
sll $0,$0,0
sll $0,$0,0
ori $1, $1, 1
sll $0,$0,0
sll $0,$0,0
subu $21,$24, $1
sll $0,$0,0
sll $0,$0,0

lw $4, 0($3) 
sll $0,$0,0
sll $0,$0,0
add $6, $4, $6


summation:
sll $0,$0,0
sll $0,$0,0
lw $5 4($3) 
sll $0,$0,0
sll $0,$0,0
sll $0,$0, 0
beq $2, $21, wrapUp
sll $0,$0,0
sll $0,$0,0
addi $2, $2, 1
add $6,$6,$5 
addi $3, $3, 4
j summation

wrapUp:
addiu $3, $3, 4 
sll $0,$0,0
sll $0,$0,0
sw $6, 0($3)
lw $4, 0($3)




addi  $2,  $0,  10             # Place "10" in $v0 to signal an "exit" or "halt"
syscall                         # Actually cause the halt