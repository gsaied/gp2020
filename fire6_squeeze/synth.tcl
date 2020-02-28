read_verilog -sv [ glob *.sv ] 
#create_fileset -constrset constr
#uncomment the following 2 lines to get schematic view
#synth_design -rtl <TOP>
#start_gui
#synth_design -top pop -part xc7vx690t -keep_equivalent_registers -quiet 
synth_design -top fire6_squeeze -part xc7vx690t  -flatten_hierarchy rebuilt -gated_clock_conversion on -quiet
#opt_design
write_checkpoint -force post_synth_fire6_squeeze.dcp
report_utilization -file utiliziation.rpt
report_utilization -hierarchical -file hierarchical_utilization.rpt
report_timing -max_paths 50 -file timing.rpt
report_design_analysis -file design.rpt
