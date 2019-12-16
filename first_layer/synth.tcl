set dirt /home/gsaied/Desktop/verilog_rtl/first_layer
cd $dirt
read_verilog -sv [ glob *.sv ] 
synth_design -top conv1 -part xc7vx690t -keep_equivalent_registers
report_design_analysis -file $dirt/design.rpt
report_utilization -file $dirt/utiliziation.rpt
report_timing -file $dirt/timing.rpt
