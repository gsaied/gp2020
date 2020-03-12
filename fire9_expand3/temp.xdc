create_clock -name clk -period 3.2 -waveform {0.00 1.60} [get_ports clk] 
set_property HD.CLK_SRC BUFGCTRL_X0Y16 [get_ports clk] 
