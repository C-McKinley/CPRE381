vsim -gui work.tb_processor
mem load -infile dmem.hex -format hex /tb_processor/p/mem_file/ram
add wave -position insertpoint sim:/tb_processor/*
add wave -position end  sim:/tb_processor/p/mem_file/ram(64)
add wave -position end  sim:/tb_processor/p/mem_file/ram(65)
add wave -position end  sim:/tb_processor/p/mem_file/ram(66)
add wave -position end 	sim:/tb_processor/p/reg_file/registers
