
	/* verilator lint_off COMBDLY */
	module rom_fire8_squeeze #(
	parameter WIDTH=16,
	parameter KERNEL=3,
	parameter ADDR=12,
	parameter NUM=112)
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

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_65 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_66 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_67 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_68 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_69 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_70 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_71 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_72 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_73 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_74 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_75 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_76 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_77 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_78 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_79 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_80 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_81 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_82 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_83 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_84 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_85 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_86 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_87 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_88 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_89 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_90 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_91 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_92 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_93 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_94 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_95 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_96 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_97 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_98 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_99 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_100 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_101 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_102 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_103 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_104 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_105 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_106 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_107 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_108 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_109 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_110 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_111 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_112 [0:2**ADDR-1] ;
initial  begin
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_1.mem",rom_1,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_2.mem",rom_2,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_3.mem",rom_3,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_4.mem",rom_4,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_5.mem",rom_5,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_6.mem",rom_6,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_7.mem",rom_7,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_8.mem",rom_8,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_9.mem",rom_9,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_10.mem",rom_10,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_11.mem",rom_11,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_12.mem",rom_12,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_13.mem",rom_13,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_14.mem",rom_14,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_15.mem",rom_15,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_16.mem",rom_16,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_17.mem",rom_17,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_18.mem",rom_18,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_19.mem",rom_19,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_20.mem",rom_20,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_21.mem",rom_21,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_22.mem",rom_22,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_23.mem",rom_23,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_24.mem",rom_24,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_25.mem",rom_25,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_26.mem",rom_26,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_27.mem",rom_27,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_28.mem",rom_28,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_29.mem",rom_29,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_30.mem",rom_30,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_31.mem",rom_31,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_32.mem",rom_32,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_33.mem",rom_33,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_34.mem",rom_34,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_35.mem",rom_35,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_36.mem",rom_36,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_37.mem",rom_37,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_38.mem",rom_38,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_39.mem",rom_39,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_40.mem",rom_40,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_41.mem",rom_41,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_42.mem",rom_42,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_43.mem",rom_43,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_44.mem",rom_44,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_45.mem",rom_45,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_46.mem",rom_46,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_47.mem",rom_47,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_48.mem",rom_48,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_49.mem",rom_49,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_50.mem",rom_50,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_51.mem",rom_51,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_52.mem",rom_52,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_53.mem",rom_53,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_54.mem",rom_54,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_55.mem",rom_55,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_56.mem",rom_56,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_57.mem",rom_57,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_58.mem",rom_58,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_59.mem",rom_59,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_60.mem",rom_60,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_61.mem",rom_61,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_62.mem",rom_62,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_63.mem",rom_63,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_64.mem",rom_64,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_65.mem",rom_65,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_66.mem",rom_66,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_67.mem",rom_67,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_68.mem",rom_68,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_69.mem",rom_69,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_70.mem",rom_70,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_71.mem",rom_71,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_72.mem",rom_72,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_73.mem",rom_73,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_74.mem",rom_74,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_75.mem",rom_75,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_76.mem",rom_76,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_77.mem",rom_77,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_78.mem",rom_78,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_79.mem",rom_79,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_80.mem",rom_80,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_81.mem",rom_81,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_82.mem",rom_82,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_83.mem",rom_83,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_84.mem",rom_84,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_85.mem",rom_85,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_86.mem",rom_86,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_87.mem",rom_87,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_88.mem",rom_88,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_89.mem",rom_89,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_90.mem",rom_90,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_91.mem",rom_91,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_92.mem",rom_92,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_93.mem",rom_93,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_94.mem",rom_94,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_95.mem",rom_95,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_96.mem",rom_96,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_97.mem",rom_97,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_98.mem",rom_98,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_99.mem",rom_99,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_100.mem",rom_100,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_101.mem",rom_101,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_102.mem",rom_102,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_103.mem",rom_103,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_104.mem",rom_104,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_105.mem",rom_105,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_106.mem",rom_106,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_107.mem",rom_107,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_108.mem",rom_108,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_109.mem",rom_109,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_110.mem",rom_110,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_111.mem",rom_111,0,2**ADDR-1);
$readmemb("new_fire8_9_squeeze/file_fire8_squeeze_112.mem",rom_112,0,2**ADDR-1);
end
always @(posedge clk) begin
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
rom_out[64]  <= rom_65[address] ;
rom_out[65]  <= rom_66[address] ;
rom_out[66]  <= rom_67[address] ;
rom_out[67]  <= rom_68[address] ;
rom_out[68]  <= rom_69[address] ;
rom_out[69]  <= rom_70[address] ;
rom_out[70]  <= rom_71[address] ;
rom_out[71]  <= rom_72[address] ;
rom_out[72]  <= rom_73[address] ;
rom_out[73]  <= rom_74[address] ;
rom_out[74]  <= rom_75[address] ;
rom_out[75]  <= rom_76[address] ;
rom_out[76]  <= rom_77[address] ;
rom_out[77]  <= rom_78[address] ;
rom_out[78]  <= rom_79[address] ;
rom_out[79]  <= rom_80[address] ;
rom_out[80]  <= rom_81[address] ;
rom_out[81]  <= rom_82[address] ;
rom_out[82]  <= rom_83[address] ;
rom_out[83]  <= rom_84[address] ;
rom_out[84]  <= rom_85[address] ;
rom_out[85]  <= rom_86[address] ;
rom_out[86]  <= rom_87[address] ;
rom_out[87]  <= rom_88[address] ;
rom_out[88]  <= rom_89[address] ;
rom_out[89]  <= rom_90[address] ;
rom_out[90]  <= rom_91[address] ;
rom_out[91]  <= rom_92[address] ;
rom_out[92]  <= rom_93[address] ;
rom_out[93]  <= rom_94[address] ;
rom_out[94]  <= rom_95[address] ;
rom_out[95]  <= rom_96[address] ;
rom_out[96]  <= rom_97[address] ;
rom_out[97]  <= rom_98[address] ;
rom_out[98]  <= rom_99[address] ;
rom_out[99]  <= rom_100[address] ;
rom_out[100]  <= rom_101[address] ;
rom_out[101]  <= rom_102[address] ;
rom_out[102]  <= rom_103[address] ;
rom_out[103]  <= rom_104[address] ;
rom_out[104]  <= rom_105[address] ;
rom_out[105]  <= rom_106[address] ;
rom_out[106]  <= rom_107[address] ;
rom_out[107]  <= rom_108[address] ;
rom_out[108]  <= rom_109[address] ;
rom_out[109]  <= rom_110[address] ;
rom_out[110]  <= rom_111[address] ;
rom_out[111]  <= rom_112[address] ;
 end
endmodule
