.text

main:

addi $t0, $zero, 100
addiu $t1, $zero, 31



add $t2, $t0, $t1
addu $t3, $t0, $t1


sub $t2, $t3, $t2

and $t4, $t2, $zero

andi $t5, $t4, 1

lui $t4, 77

lw $t2, 199

nor $t4, $t4, $t2

xor $t2, $t3, $t4

xori $t2, 1

or $t2, $t2, $t3

ori $t1, 19


slt $t1, $t2, $t3

slti $t1, $t2, 11

sltiu $t1, $t2, 110

sltu, $t1, $t2, $t3

sll, $t1, $t2, 10

srl, $t1, $t2, 29

sra, $t1, $t3, 19

sllv $t1, $t2, $t3

srlv $t1, $t2, $t3

srav $t1, $t2, $t3

sw $t1, 100


sub