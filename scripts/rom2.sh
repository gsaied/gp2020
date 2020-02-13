#!/bin/bash
echo -e "Enter layer name, same as weights and bias \n"
read layername
rm -rf rom2_"$layername".sv
echo -e  "Enter #files\n" 
read file_count
echo -e " enter kernel dimension\n"
read kernel_dim
echo " enter rest of the rom"
read rom_rest
let "size=$kernel_dim**2*$rom_rest"
address=` ./log2.pl "$rom_rest"` ;
touch readmem.sv always.sv decl.sv rom2_"$layername".sv

echo "
	/* verilator lint_off COMBDLY */
	module rom2_"$layername" #(
	parameter WIDTH=16,
	parameter KERNEL="$kernel_dim",
	parameter ADDR="$address",
	parameter NUM="$file_count")
	(
		input [ADDR-1:0] address ,
		output [WIDTH-1:0] rom_out [0:NUM-1]
	);	
	" >> rom2_"$layername".sv
echo "initial begin" >> readmem.sv
count=1
find *.mem | grep extend | sort -n -t _ -k 3 | while read LINE ; do
	
	echo "
  	(* rom_style=\"{distributed}\" *)
	reg [WIDTH-1:0] rom_"$count" [0:2**ADDR-1] ;" >> decl.sv;
	echo "\$readmemb("\"$LINE\"",rom_"$count",0,2**ADDR-1);" >> readmem.sv;
	((count++))
done
for (( i = 0 ; i < $file_count ; i++)) ; do
	echo "assign rom_out["$i"] = rom_"$(($i+1))"[address] ;" >> always.sv ;
done
echo "end" >> readmem.sv
cat decl.sv >> rom2_"$layername".sv
cat readmem.sv >> rom2_"$layername".sv
cat always.sv >> rom2_"$layername".sv
echo "endmodule" >> rom2_"$layername".sv
rm -rf always.sv decl.sv readmem.sv
