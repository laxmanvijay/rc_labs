## Clock signal
set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports CLK100MHZ]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports CLK100MHZ]

set_input_delay -clock [get_clocks sys_clk_pin] 0.000 [get_ports {a b}]
set_input_delay -clock [get_clocks sys_clk_pin] -min 0.000 [get_ports {a b}]

set_output_delay -clock [get_clocks sys_clk_pin] 0.000 [get_ports y]
set_output_delay -clock [get_clocks sys_clk_pin] -min 0.000 [get_ports y]

## Pin assignments

set_property -dict {PACKAGE_PIN J15 IOSTANDARD LVCMOS33} [get_ports a]
set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports b]
set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVCMOS33} [get_ports y]


set_property BEL BUFG [get_cells CLK100MHZ_IBUF_BUFG_inst]
set_property LOC BUFGCTRL_X0Y16 [get_cells CLK100MHZ_IBUF_BUFG_inst]
set_property FIXED_ROUTE { { CLK_BUFG_BUFGCTRL0_O GAP CLK_HROW_TOP_R_X78Y130/CLK_HROW_CK_MUX_OUT_L8 CLK_HROW_CK_HCLK_OUT_L8 CLK_HROW_CK_BUFHCLK_L8 <12>HCLK_LEAF_CLK_B_BOTL5 <11>GCLK_L_B11_WEST CLK_L0 CLBLL_L_CLK }  } [get_nets CLK100MHZ_IBUF_BUFG]
