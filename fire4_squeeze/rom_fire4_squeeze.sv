
	/* verilator lint_off COMBDLY */
	module rom_fire4_squeeze #(
	parameter WIDTH=16,
	parameter ADDR=10,
	parameter NUM=32)
	(
		input [ADDR-1:0] address ,
		input clk,
		output reg [WIDTH-1:0] rom_out [0:NUM-1]
	);	
	

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_1 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_2 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_3 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_4 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_5 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_6 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_7 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_8 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_9 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_10 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_11 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_12 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_13 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_14 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_15 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_16 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_17 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_18 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_19 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_20 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_21 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_22 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_23 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_24 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_25 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_26 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_27 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_28 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_29 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_30 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_31 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_32 [0:2**ADDR-1] ;
initial  begin
$readmemb("file_fire4_squeeze_1.mem",rom_1,0,2**ADDR-1);
$readmemb("file_fire4_squeeze_2.mem",rom_2,0,2**ADDR-1);
$readmemb("file_fire4_squeeze_3.mem",rom_3,0,2**ADDR-1);
$readmemb("file_fire4_squeeze_4.mem",rom_4,0,2**ADDR-1);
$readmemb("file_fire4_squeeze_5.mem",rom_5,0,2**ADDR-1);
$readmemb("file_fire4_squeeze_6.mem",rom_6,0,2**ADDR-1);
$readmemb("file_fire4_squeeze_7.mem",rom_7,0,2**ADDR-1);
$readmemb("file_fire4_squeeze_8.mem",rom_8,0,2**ADDR-1);
$readmemb("file_fire4_squeeze_9.mem",rom_9,0,2**ADDR-1);
$readmemb("file_fire4_squeeze_10.mem",rom_10,0,2**ADDR-1);
$readmemb("file_fire4_squeeze_11.mem",rom_11,0,2**ADDR-1);
$readmemb("file_fire4_squeeze_12.mem",rom_12,0,2**ADDR-1);
$readmemb("file_fire4_squeeze_13.mem",rom_13,0,2**ADDR-1);
$readmemb("file_fire4_squeeze_14.mem",rom_14,0,2**ADDR-1);
$readmemb("file_fire4_squeeze_15.mem",rom_15,0,2**ADDR-1);
$readmemb("file_fire4_squeeze_16.mem",rom_16,0,2**ADDR-1);
$readmemb("file_fire4_squeeze_17.mem",rom_17,0,2**ADDR-1);
$readmemb("file_fire4_squeeze_18.mem",rom_18,0,2**ADDR-1);
$readmemb("file_fire4_squeeze_19.mem",rom_19,0,2**ADDR-1);
$readmemb("file_fire4_squeeze_20.mem",rom_20,0,2**ADDR-1);
$readmemb("file_fire4_squeeze_21.mem",rom_21,0,2**ADDR-1);
$readmemb("file_fire4_squeeze_22.mem",rom_22,0,2**ADDR-1);
$readmemb("file_fire4_squeeze_23.mem",rom_23,0,2**ADDR-1);
$readmemb("file_fire4_squeeze_24.mem",rom_24,0,2**ADDR-1);
$readmemb("file_fire4_squeeze_25.mem",rom_25,0,2**ADDR-1);
$readmemb("file_fire4_squeeze_26.mem",rom_26,0,2**ADDR-1);
$readmemb("file_fire4_squeeze_27.mem",rom_27,0,2**ADDR-1);
$readmemb("file_fire4_squeeze_28.mem",rom_28,0,2**ADDR-1);
$readmemb("file_fire4_squeeze_29.mem",rom_29,0,2**ADDR-1);
$readmemb("file_fire4_squeeze_30.mem",rom_30,0,2**ADDR-1);
$readmemb("file_fire4_squeeze_31.mem",rom_31,0,2**ADDR-1);
$readmemb("file_fire4_squeeze_32.mem",rom_32,0,2**ADDR-1);
end
always@(posedge clk) begin
 rom_out[0]  <= rom_1[address] ;
 rom_out[1]  <= rom_2[address] ;
 rom_out[2]  <= rom_3[address] ;
 rom_out[3]  <= rom_4[address] ;
 rom_out[4]  <= rom_5[address] ;
 rom_out[5]  <= rom_6[address] ;
 rom_out[6]  <= rom_7[address] ;
 rom_out[7]  <= rom_8[address] ;
 rom_out[8]  <= rom_9[address] ;
 rom_out[9]  <= rom_10[address] ;
 rom_out[10]  <= rom_11[address] ;
 rom_out[11]  <= rom_12[address] ;
 rom_out[12]  <= rom_13[address] ;
 rom_out[13]  <= rom_14[address] ;
 rom_out[14]  <= rom_15[address] ;
 rom_out[15]  <= rom_16[address] ;
 rom_out[16]  <= rom_17[address] ;
 rom_out[17]  <= rom_18[address] ;
 rom_out[18]  <= rom_19[address] ;
 rom_out[19]  <= rom_20[address] ;
 rom_out[20]  <= rom_21[address] ;
 rom_out[21]  <= rom_22[address] ;
 rom_out[22]  <= rom_23[address] ;
 rom_out[23]  <= rom_24[address] ;
 rom_out[24]  <= rom_25[address] ;
 rom_out[25]  <= rom_26[address] ;
 rom_out[26]  <= rom_27[address] ;
 rom_out[27]  <= rom_28[address] ;
 rom_out[28]  <= rom_29[address] ;
 rom_out[29]  <= rom_30[address] ;
 rom_out[30]  <= rom_31[address] ;
 rom_out[31]  <= rom_32[address] ;
end
endmodule
