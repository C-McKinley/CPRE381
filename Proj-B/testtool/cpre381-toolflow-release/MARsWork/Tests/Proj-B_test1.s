#
# First part of the Lab 3 test program
#

# data section
.data

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
	
addi  $2,  $0,  10             # Place "10" in $v0 to signal an "exit" or "halt"
syscall                         # Actually cause the halt