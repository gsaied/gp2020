#set OWNER <OWNER>
if {[get_filesets constr] == "constr" } {
	puts "Constraints fileset exists, continuing.." } else {
	puts "Creating Constraints fileset"
	create_fileset -constrset constr
	add_files -fileset constr temp.xdc
}
set_param synth.elaboration.rodinMoreOptions "rt::set_parameter var_size_limit 4194304"
##########
##STAGE1##
##########
#
synth_design -top [lindex [find_top] 0] -part xc7vx690t -flatten_hierarchy rebuilt -directive AreaOptimized_medium -constrset constr -retiming -no_srlextract -resource_sharing on
write_checkpoint -force script4_post_synth.dcp
report_utilization -file script4_post_synth_utilization.rpt
report_timing -file script4_post_synth_timing.rpt
#
##########
##STAGE2##
##########
#
#open_checkpoint <>
#place_design -directive Explore
#report_timing -file script4_post_placement_timing.rpt
#report_utilization -file script4_post_placement_utilization.rpt
#write_checkpoint -force script4_post_placement.dcp
#
##########
##STAGE3##
##########
#
#open_checkpoint <>
#opt_design -directive resynth_seq_area
#report_timing -file script4_post_opt_timing.rpt
#report_utilization -file script4_post_opt_utilization.rpt
#write_checkpoint -force script4_post_opt.dcp
#
##########
##STAGE4##
##########
#
#open_checkpoint <>
#if {[get_property SLACK [get_timing_paths -max_paths 1 -nworst 1 -setup]] < 0} {
#puts "Found setup timing violations => running physical optimization"
#report_timing -file script4_pre_phys_opt_timing.rpt
#phys_opt_design
#report_timing -file script4_post_phys_opt_timing.rpt
#report_utilization -file script4_post_phys_utilization.rpt
#} else { puts "SKIPPED STAGE 4"}
#
##########
##STAGE5##
##########
#
#open_checkpoint <>
#route_design -directive MoreGlobalIterations 
#report_timing -file script4_post_route_timing.rpt 
#report_utilization -file script4_final_utilization.rpt
#report_drc -file script4_final_DRC.rpt