set dirt /home/gsaied/Desktop/verilog_rtl/pool/pool_sv
cd $dirt
#read_verilog -sv integ.sv
read_verilog -sv pool.sv
read_verilog -sv clock_divider.sv
read_verilog -sv [ glob *.sv ] 
create_fileset -constrset constr
add_files pool.xdc
#uncomment the following 2 lines to get schematic view
#synth_design -top integ -rtl 
#start_gui
#synth_design -top integ -part xc7vx690t -keep_equivalent_registers
synth_design -top pool -part xc7vx690t -constrset constr
#opt_design

report_utilization -file $dirt/utiliziation.rpt
report_timing -max_paths 50 -file $dirt/timing.rpt
report_design_analysis -file $dirt/design.rpt
