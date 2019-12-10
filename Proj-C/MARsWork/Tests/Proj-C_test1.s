.text

main:

addi $t0, $zero, 100
nop
nop
nop
nop
addiu $t1, $zero, 31
nop
nop
nop
nop
add $t2, $t0, $t1
nop
nop
nop
nop
addu $t3, $t0, $t1
nop
nop
nop
nop
sub $t2, $t3, $t2
nop
nop
nop
nop
and $t4, $t2, $zero
nop
nop
nop
nop
andi $t5, $t4, 1
nop
nop
nop
nop
lui $t4, 77
nop
nop
nop
nop
lw $t2, 199
nop
nop
nop
nop
nor $t4, $t4, $t2
nop
nop
nop
nop
xor $t2, $t3, $t4
nop
nop
nop
nop
xori $t2, 1
nop
nop
nop
nop
or $t2, $t2, $t3
nop
nop
nop
nop
ori $t1, 19
nop
nop
nop
nop
slt $t1, $t2, $t3
nop
nop
nop
nop
slti $t1, $t2, 11
nop
nop
nop
nop
sltiu $t1, $t2, 110
nop
nop
nop
nop
sltu, $t1, $t2, $t3
nop
nop
nop
nop
sll, $t1, $t2, 10
nop
nop
nop
nop
srl, $t1, $t2, 29
nop
nop
nop
nop
sra, $t1, $t3, 19
nop
nop
nop
nop
sllv $t1, $t2, $t3
nop
nop
nop
nop
srlv $t1, $t2, $t3
nop
nop
nop
nop
srav $t1, $t2, $t3
nop
nop
nop
nop
sw $t1, 100
nop
nop
nop
nop
sub $t2, $t0, $t1
nop
nop
nop
nop
beq $t0, $t1, nobranch
nop
nop
nop
nop
beq $zero, $zero, branch
 
nobranch:

branch:
nop
nop
nop
nop
bne $zero, $zero, nobranch
nop
nop
nop
nop
bne $t0, $t1, branch2

branch2:
nop
nop
nop
nop
j jump

jump:
nop
nop
nop
nop
jal jump2

jump2:
nop
nop
nop
nop
jr $t1

