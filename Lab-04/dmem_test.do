vsim -gui work.tb_dmem
mem load -infile dmem.hex -format hex /tb_dmem/dmem/ram
add wave -position insertpoint sim:/tb_dmem/*
add wave -position end  sim:/tb_dmem/dmem/ram(0)
add wave -position end  sim:/tb_dmem/dmem/ram(1)
add wave -position end  sim:/tb_dmem/dmem/ram(2)
add wave -position end  sim:/tb_dmem/dmem/ram(3)
add wave -position end  sim:/tb_dmem/dmem/ram(4)
add wave -position end  sim:/tb_dmem/dmem/ram(5)
add wave -position end  sim:/tb_dmem/dmem/ram(6)
add wave -position end  sim:/tb_dmem/dmem/ram(7)
add wave -position end  sim:/tb_dmem/dmem/ram(8)
add wave -position end  sim:/tb_dmem/dmem/ram(9)
add wave -position end  sim:/tb_dmem/dmem/ram(10)
add wave -position end  sim:/tb_dmem/dmem/ram(255)
add wave -position end  sim:/tb_dmem/dmem/ram(256)
add wave -position end  sim:/tb_dmem/dmem/ram(257)
add wave -position end  sim:/tb_dmem/dmem/ram(258)
add wave -position end  sim:/tb_dmem/dmem/ram(259)
add wave -position end  sim:/tb_dmem/dmem/ram(260)
add wave -position end  sim:/tb_dmem/dmem/ram(261)
add wave -position end  sim:/tb_dmem/dmem/ram(262)
add wave -position end  sim:/tb_dmem/dmem/ram(263)
add wave -position end  sim:/tb_dmem/dmem/ram(264)
add wave -position end  sim:/tb_dmem/dmem/ram(265)