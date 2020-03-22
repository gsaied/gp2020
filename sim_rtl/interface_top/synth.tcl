read_verilog -sv [ glob *.sv ] 
create_fileset -constrset constr
add_files -fileset constr temp.xdc
set_param synth.elaboration.rodinMoreOptions "rt::set_parameter var_size_limit 4194304"
#uncomment the following 2 lines to get schematic view
#synth_design -rtl <TOP>
#start_gui
#synth_design -top integ -part xc7vx690t -keep_equivalent_registers
synth_design -top  FirstSharedMemory -part xc7vx690t -flatten_hierarchy rebuilt -directive AreaOptimized_high -constrset constr -mode out_of_context
#keep_hierarchy for brams
report_utilization -file utiliziation.rpt
report_utilization -hierarchical -file hierarchical_utilization.rpt
report_timing -file post_synth_timing.rpt
if {[get_property SLACK [get_timing_paths -max_paths 1 -nworst 1 -setup]] < 0} {
puts "Found setup timing violations => running physical optimization"
report_timing -file slack.rpt
}
opt_design -directive ExploreSequentialArea
place_design -no_fanout_opt -directive ExtraTimingOpt
route_design -directive NoTimingRelaxation -tns_cleanup
report_timing
