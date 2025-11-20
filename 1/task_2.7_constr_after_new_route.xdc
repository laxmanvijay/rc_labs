## Clock signal
set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports CLK100MHZ]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports CLK100MHZ]
## Pin assignments

set_property -dict {PACKAGE_PIN J15 IOSTANDARD LVCMOS33} [get_ports a]
set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports b]
set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVCMOS33} [get_ports y]

set_property BEL AFF [get_cells y_reg_reg]
set_property LOC SLICE_X0Y101 [get_cells y_reg_reg]

