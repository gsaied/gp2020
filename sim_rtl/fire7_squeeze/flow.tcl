# STEP#1: define the output directory area.
#
#set outputDir 
#file mkdir $outputDir
#
# STEP#2: setup design sources and constraints
#
set xdc_file <> 
read_verilog [ glob *.sv ]
read_xdc $xdc_file.xdc 
create_fileset -constrset cstr
#
# STEP#3: run synthesis, write design checkpoint, report timing,
# and utilization estimates
#
synth_design -top [lindex [find_top] 0] -part xc7vx690t -flatten_hierarchy rebuilt
write_checkpoint -force post_synth.dcp
report_timing_summary -file post_synth_timing_summary.rpt
report_utilization -file post_synth_util.rpt
#
#
# STEP#4: run logic optimization, placement and physical logic optimization,
# write design checkpoint, report utilization and timing estimates
#
opt_design
place_design
report_clock_utilization -file clock_util.rpt
#
# Optionally run optimization if there are timing violations after placement
if {[get_property SLACK [get_timing_paths -max_paths 1 -nworst 1 -setup]] < 0} {
puts "Found setup timing violations => running physical optimization"
phys_opt_design
}
write_checkpoint -force post_place.dcp
report_utilization -file post_place_util.rpt
report_timing_summary -file post_place_timing_summary.rpt
#Send Feedback
# STEP#5: run the router, write the post-route design checkpoint, report the routing
# status, report timing, power, and DRC, and finally save the Verilog netlist.
#
route_design
write_checkpoint -force post_route.dcp
report_route_status -file post_route_status.rpt
report_timing_summary -file post_route_timing_summary.rpt
report_power -file post_route_power.rpt
report_drc -file post_imp_drc.rpt
write_verilog -force netlist.v -mode timesim -sdf_anno true
#
# STEP#6: generate a bitstream
#
write_bitstream -force cpu.bi
