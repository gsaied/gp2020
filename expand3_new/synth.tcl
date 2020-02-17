read_verilog -sv [ glob *.sv ] 
#create_fileset -constrset constr
#uncomment the following 2 lines to get schematic view
#synth_desing -rtl <TOP>
#start_gui
#synth_design -top integ -part xc7vx690t -keep_equivalent_registers
synth_design -top fire6_expand3 -part xc7vx690t
#opt_design

report_utilization -file utiliziation.rpt
report_timing -max_paths 50 -file timing.rpt
report_design_analysis -file design.rpt