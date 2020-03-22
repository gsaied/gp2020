create_clock -name clk -period 3.2 -waveform {0.00 1.6} [get_ports clk] 
set_property HD.CLK_SRC BUFGCTRL_X0Y1 [get_ports clk]
set_property HD.CLK_SRC BUFGCTRL_X0Y8 [get_ports clk]
set_property HD.CLK_SRC BUFGCTRL_X0Y12 [get_ports clk]
