
	/* verilator lint_off COMBDLY */
	module rom_fire3_squeeze #(
	parameter WIDTH=32,
	parameter ADDR=7,
	parameter NUM=16)
	(
		input [ADDR-1:0] address ,
		//input clk,
		output [WIDTH-1:0] rom_out [0:NUM-1]
	);	
	

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_1 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_2 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_3 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_4 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_5 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_6 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_7 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_8 [0:2**ADDR-1] ;
initial  begin
$readmemb("new_file_fire3_squeeze_1.mem",rom_1,0,2**ADDR-1);
$readmemb("new_file_fire3_squeeze_3.mem",rom_2,0,2**ADDR-1);
$readmemb("new_file_fire3_squeeze_5.mem",rom_3,0,2**ADDR-1);
$readmemb("new_file_fire3_squeeze_7.mem",rom_4,0,2**ADDR-1);
$readmemb("new_file_fire3_squeeze_9.mem",rom_5,0,2**ADDR-1);
$readmemb("new_file_fire3_squeeze_11.mem",rom_6,0,2**ADDR-1);
$readmemb("new_file_fire3_squeeze_13.mem",rom_7,0,2**ADDR-1);
$readmemb("new_file_fire3_squeeze_15.mem",rom_8,0,2**ADDR-1);
end
assign rom_out[0] = rom_1[address] ;
assign rom_out[1] = rom_2[address] ;
assign rom_out[2] = rom_3[address] ;
assign rom_out[3] = rom_4[address] ;
assign rom_out[4] = rom_5[address] ;
assign rom_out[5] = rom_6[address] ;
assign rom_out[6] = rom_7[address] ;
assign rom_out[7] = rom_8[address] ;
endmodule
