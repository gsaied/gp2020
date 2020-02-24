read_verilog -sv [ glob *.sv ] 
create_fileset -constrset constr
add_files squeeze_fire8.xdc
#uncomment the following 2 lines to get schematic view
#synth_design -rtl <TOP>
#start_gui
#synth_design -top rom_fire8_squeeze -part xc7vx690t -keep_equivalent_registers -quiet
synth_design -top [lindex [find_top] 0] -part xc7vx690t -quiet -flatten_hierarchy rebuilt -constrset constr
#opt_design

report_utilization -file utiliziation.rpt
report_utilization -hierarchical -file hierarchical_utilization.rpt
report_timing -max_paths 50 -file timing.rpt
report_design_analysis -file design.rpt
