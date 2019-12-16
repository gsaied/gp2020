set dirt /home/gsaied/Desktop/verilog_rtl/conv10/part2
cd $dirt
read_verilog -sv [ glob *.sv ] 
synth_design -top  xx
report_design_analysis -file $dirt/design.rpt
report_utilization -file $dirt/utiliziation.rpt
