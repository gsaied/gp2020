read_verilog -sv [ glob *.sv ] 
create_fileset -constrset constr
add_files -fileset constr squeeze_fire2.xdc
#uncomment the following 2 lines to get schematic view
#synth_design -rtl <TOP>
#start_gui
synth_design -top fire2_squeeze -part xc7vx690t -keep_equivalent_registers  -quiet -constrset constr
write_checkpoint -force post_synth.dcp
#synth_design -top [lindex [find_top] 0] -part xc7vx690t
#opt_design
report_utilization -file utiliziation.rpt
report_utilization -hierarchical -file hierarchical_utilization.rpt
report_timing -max_paths 50 -file timing.rpt
report_design_analysis -file design.rpt
