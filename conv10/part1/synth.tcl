read_verilog -sv [ glob *.sv ] 
synth_design -top conv10 -part xc7vx690t -keep_equivalent_registers -flatten_hierarchy none
report_design_analysis -file design.rpt
report_utilization -file utiliziation.rpt
report_timing -file timing.rpt
