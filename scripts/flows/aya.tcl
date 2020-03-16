if {[get_filesets constr] == "constr" } {
	puts "Constraints fileset exists, continuing.." } else {
	puts "Creating Constraints fileset"
	create_fileset -constrset constr
	add_files -fileset constr temp.xdc
}
#matnsash el slr
set_param synth.elaboration.rodinMoreOptions "rt::set_parameter var_size_limit 4194304"

