read_verilog -sv [ glob *.sv ] 
create_fileset -constrset constr
add_files -fileset constr expand3_fire7.xdc
#uncomment the following 2 lines to get schematic view
#synth_design -rtl <TOP>
#start_gui
#synth_design -top integ -part xc7vx690t -keep_equivalent_registers
synth_design -top [lindex [find_top] 0] -part xc7vx690t -flatten_hierarchy full -directive AreaOptimized_high -constrset constr

report_utilization -file utiliziation.rpt
report_utilization -hierarchical -file hierarchical_utilization.rpt
report_timing -max_paths 50 -file timing.rpt
report_design_analysis -file design.rpt
opt_design -directive ExploreArea
report_utilization -file post_opt_utilization.rpt
