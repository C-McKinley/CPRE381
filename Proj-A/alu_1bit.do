vsim -gui work.tb_alu_1bit
add wave -position insertpoint sim:/tb_alu_1bit/*
add wave -position insertpoint sim:/tb_alu_1bit/alu/adder/*
run 3200