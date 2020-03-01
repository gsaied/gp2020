create_clock -name clk -period 5 -waveform {0 2.5} [get_ports clk] 
keep_hierarchy [get_cells u_2]
