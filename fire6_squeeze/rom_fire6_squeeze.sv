
	/* verilator lint_off COMBDLY */
	module rom_fire6_squeeze #(
	parameter WIDTH=16,
	parameter KERNEL=3,
	parameter ADDR=11,
	parameter NUM=64)
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

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_33 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_34 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_35 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_36 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_37 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_38 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_39 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_40 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_41 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_42 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_43 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_44 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_45 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_46 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_47 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_48 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_49 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_50 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_51 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_52 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_53 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_54 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_55 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_56 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_57 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_58 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_59 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_60 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_61 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_62 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_63 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_64 [0:2**ADDR-1] ;
initial  begin
$readmemb("file_fire6_squeeze_1.mem",rom_1,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_2.mem",rom_2,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_3.mem",rom_3,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_4.mem",rom_4,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_5.mem",rom_5,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_6.mem",rom_6,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_7.mem",rom_7,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_8.mem",rom_8,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_9.mem",rom_9,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_10.mem",rom_10,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_11.mem",rom_11,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_12.mem",rom_12,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_13.mem",rom_13,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_14.mem",rom_14,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_15.mem",rom_15,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_16.mem",rom_16,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_17.mem",rom_17,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_18.mem",rom_18,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_19.mem",rom_19,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_20.mem",rom_20,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_21.mem",rom_21,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_22.mem",rom_22,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_23.mem",rom_23,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_24.mem",rom_24,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_25.mem",rom_25,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_26.mem",rom_26,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_27.mem",rom_27,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_28.mem",rom_28,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_29.mem",rom_29,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_30.mem",rom_30,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_31.mem",rom_31,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_32.mem",rom_32,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_33.mem",rom_33,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_34.mem",rom_34,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_35.mem",rom_35,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_36.mem",rom_36,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_37.mem",rom_37,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_38.mem",rom_38,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_39.mem",rom_39,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_40.mem",rom_40,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_41.mem",rom_41,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_42.mem",rom_42,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_43.mem",rom_43,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_44.mem",rom_44,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_45.mem",rom_45,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_46.mem",rom_46,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_47.mem",rom_47,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_48.mem",rom_48,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_49.mem",rom_49,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_50.mem",rom_50,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_51.mem",rom_51,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_52.mem",rom_52,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_53.mem",rom_53,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_54.mem",rom_54,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_55.mem",rom_55,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_56.mem",rom_56,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_57.mem",rom_57,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_58.mem",rom_58,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_59.mem",rom_59,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_60.mem",rom_60,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_61.mem",rom_61,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_62.mem",rom_62,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_63.mem",rom_63,0,2**ADDR-1);
$readmemb("file_fire6_squeeze_64.mem",rom_64,0,2**ADDR-1);
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
 rom_out[32]  <= rom_33[address] ;
 rom_out[33]  <= rom_34[address] ;
 rom_out[34]  <= rom_35[address] ;
 rom_out[35]  <= rom_36[address] ;
 rom_out[36]  <= rom_37[address] ;
 rom_out[37]  <= rom_38[address] ;
 rom_out[38]  <= rom_39[address] ;
 rom_out[39]  <= rom_40[address] ;
 rom_out[40]  <= rom_41[address] ;
 rom_out[41]  <= rom_42[address] ;
 rom_out[42]  <= rom_43[address] ;
 rom_out[43]  <= rom_44[address] ;
 rom_out[44]  <= rom_45[address] ;
 rom_out[45]  <= rom_46[address] ;
 rom_out[46]  <= rom_47[address] ;
 rom_out[47]  <= rom_48[address] ;
 rom_out[48]  <= rom_49[address] ;
 rom_out[49]  <= rom_50[address] ;
 rom_out[50]  <= rom_51[address] ;
 rom_out[51]  <= rom_52[address] ;
 rom_out[52]  <= rom_53[address] ;
 rom_out[53]  <= rom_54[address] ;
 rom_out[54]  <= rom_55[address] ;
 rom_out[55]  <= rom_56[address] ;
 rom_out[56]  <= rom_57[address] ;
 rom_out[57]  <= rom_58[address] ;
 rom_out[58]  <= rom_59[address] ;
 rom_out[59]  <= rom_60[address] ;
 rom_out[60]  <= rom_61[address] ;
 rom_out[61]  <= rom_62[address] ;
 rom_out[62]  <= rom_63[address] ;
 rom_out[63]  <= rom_64[address] ;
 end
endmodule
