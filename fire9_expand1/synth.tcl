read_verilog -sv [ glob *.sv ] 
create_fileset -constrset constr
add_files -fileset constr expand1_fire9.xdc
#uncomment the following 2 lines to get schematic view
#synth_design -rtl <TOP>
#start_gui
synth_design -top fire9_expand1 -part xc7vx690t -constrset constr
write_checkpoint -force post_synth.dcp
#synth_design -top [lindex [find_top] 0] -part xc7vx690t
report_utilization -file utiliziation.rpt
report_utilization -hierarchical -file hierarchical_utilization.rpt
report_timing -max_paths 50 -file timing.rpt
report_design_analysis -file design.rpt
opt_design -resynth_area
report_utilization -file post_opt_utilization.rpt
opt_design -merge_equivalent_drivers
report_utilization -file post_merging_utilization.rpt 
