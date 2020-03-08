read_verilog -sv [ glob *.sv ] 
create_fileset -constrset constr
add_files -fileset constr temp.xdc
set_param synth.elaboration.rodinMoreOptions "rt::set_parameter var_size_limit 4194304"
#uncomment the following 2 lines to get schematic view
#synth_design -rtl <TOP>
#start_gui
#synth_design -top integ -part xc7vx690t -keep_equivalent_registers
synth_design -top [lindex [find_top] 0] -part xc7vx690t -flatten_hierarchy rebuilt -constrset constr 
#keep_hierarchy for brams
