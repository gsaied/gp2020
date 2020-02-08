read_verilog -sv [ glob *.sv ] 
synth_design -top fire2_3_expand_1 -part xc7vx690t -keep_equivalent_registers
report_design_analysis -file design.rpt
report_utilization -file utiliziation.rpt
report_timing -file timing.rpt
