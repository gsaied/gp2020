module rom_fire6_expand3 #(
	parameter WIDTH=16,
	parameter ADDR=10,
	parameter NUM=128
)
(

		input [ADDR-1:0] address ,
		input clk,
		output reg [WIDTH-1:0] rom_out [0:2*NUM-1]
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

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_113 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_114 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_115 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_116 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_117 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_118 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_119 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_120 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_121 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_122 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_123 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_124 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_125 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_126 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_127 [0:2**ADDR-1] ;

  	(* rom_style="{block}" *)
	reg [WIDTH-1:0] rom_128 [0:2**ADDR-1] ;
initial begin

$readmemb("file_fire6_expand3_2.mem",rom_1,0,2**ADDR-1);
$readmemb("file_fire6_expand3_4.mem",rom_2,0,2**ADDR-1);
$readmemb("file_fire6_expand3_6.mem",rom_3,0,2**ADDR-1);
$readmemb("file_fire6_expand3_8.mem",rom_4,0,2**ADDR-1);
$readmemb("file_fire6_expand3_10.mem",rom_5,0,2**ADDR-1);
$readmemb("file_fire6_expand3_12.mem",rom_6,0,2**ADDR-1);
$readmemb("file_fire6_expand3_14.mem",rom_7,0,2**ADDR-1);
$readmemb("file_fire6_expand3_16.mem",rom_8,0,2**ADDR-1);
$readmemb("file_fire6_expand3_18.mem",rom_9,0,2**ADDR-1);
$readmemb("file_fire6_expand3_20.mem",rom_10,0,2**ADDR-1);
$readmemb("file_fire6_expand3_22.mem",rom_11,0,2**ADDR-1);
$readmemb("file_fire6_expand3_24.mem",rom_12,0,2**ADDR-1);
$readmemb("file_fire6_expand3_26.mem",rom_13,0,2**ADDR-1);
$readmemb("file_fire6_expand3_28.mem",rom_14,0,2**ADDR-1);
$readmemb("file_fire6_expand3_30.mem",rom_15,0,2**ADDR-1);
$readmemb("file_fire6_expand3_32.mem",rom_16,0,2**ADDR-1);
$readmemb("file_fire6_expand3_34.mem",rom_17,0,2**ADDR-1);
$readmemb("file_fire6_expand3_36.mem",rom_18,0,2**ADDR-1);
$readmemb("file_fire6_expand3_38.mem",rom_19,0,2**ADDR-1);
$readmemb("file_fire6_expand3_40.mem",rom_20,0,2**ADDR-1);
$readmemb("file_fire6_expand3_42.mem",rom_21,0,2**ADDR-1);
$readmemb("file_fire6_expand3_44.mem",rom_22,0,2**ADDR-1);
$readmemb("file_fire6_expand3_46.mem",rom_23,0,2**ADDR-1);
$readmemb("file_fire6_expand3_48.mem",rom_24,0,2**ADDR-1);
$readmemb("file_fire6_expand3_50.mem",rom_25,0,2**ADDR-1);
$readmemb("file_fire6_expand3_52.mem",rom_26,0,2**ADDR-1);
$readmemb("file_fire6_expand3_54.mem",rom_27,0,2**ADDR-1);
$readmemb("file_fire6_expand3_56.mem",rom_28,0,2**ADDR-1);
$readmemb("file_fire6_expand3_58.mem",rom_29,0,2**ADDR-1);
$readmemb("file_fire6_expand3_60.mem",rom_30,0,2**ADDR-1);
$readmemb("file_fire6_expand3_62.mem",rom_31,0,2**ADDR-1);
$readmemb("file_fire6_expand3_64.mem",rom_32,0,2**ADDR-1);
$readmemb("file_fire6_expand3_66.mem",rom_33,0,2**ADDR-1);
$readmemb("file_fire6_expand3_68.mem",rom_34,0,2**ADDR-1);
$readmemb("file_fire6_expand3_70.mem",rom_35,0,2**ADDR-1);
$readmemb("file_fire6_expand3_72.mem",rom_36,0,2**ADDR-1);
$readmemb("file_fire6_expand3_74.mem",rom_37,0,2**ADDR-1);
$readmemb("file_fire6_expand3_76.mem",rom_38,0,2**ADDR-1);
$readmemb("file_fire6_expand3_78.mem",rom_39,0,2**ADDR-1);
$readmemb("file_fire6_expand3_80.mem",rom_40,0,2**ADDR-1);
$readmemb("file_fire6_expand3_82.mem",rom_41,0,2**ADDR-1);
$readmemb("file_fire6_expand3_84.mem",rom_42,0,2**ADDR-1);
$readmemb("file_fire6_expand3_86.mem",rom_43,0,2**ADDR-1);
$readmemb("file_fire6_expand3_88.mem",rom_44,0,2**ADDR-1);
$readmemb("file_fire6_expand3_90.mem",rom_45,0,2**ADDR-1);
$readmemb("file_fire6_expand3_92.mem",rom_46,0,2**ADDR-1);
$readmemb("file_fire6_expand3_94.mem",rom_47,0,2**ADDR-1);
$readmemb("file_fire6_expand3_96.mem",rom_48,0,2**ADDR-1);
$readmemb("file_fire6_expand3_98.mem",rom_49,0,2**ADDR-1);
$readmemb("file_fire6_expand3_100.mem",rom_50,0,2**ADDR-1);
$readmemb("file_fire6_expand3_102.mem",rom_51,0,2**ADDR-1);
$readmemb("file_fire6_expand3_104.mem",rom_52,0,2**ADDR-1);
$readmemb("file_fire6_expand3_106.mem",rom_53,0,2**ADDR-1);
$readmemb("file_fire6_expand3_108.mem",rom_54,0,2**ADDR-1);
$readmemb("file_fire6_expand3_110.mem",rom_55,0,2**ADDR-1);
$readmemb("file_fire6_expand3_112.mem",rom_56,0,2**ADDR-1);
$readmemb("file_fire6_expand3_114.mem",rom_57,0,2**ADDR-1);
$readmemb("file_fire6_expand3_116.mem",rom_58,0,2**ADDR-1);
$readmemb("file_fire6_expand3_118.mem",rom_59,0,2**ADDR-1);
$readmemb("file_fire6_expand3_120.mem",rom_60,0,2**ADDR-1);
$readmemb("file_fire6_expand3_122.mem",rom_61,0,2**ADDR-1);
$readmemb("file_fire6_expand3_124.mem",rom_62,0,2**ADDR-1);
$readmemb("file_fire6_expand3_126.mem",rom_63,0,2**ADDR-1);
$readmemb("file_fire6_expand3_128.mem",rom_64,0,2**ADDR-1);
$readmemb("file_fire6_expand3_130.mem",rom_65,0,2**ADDR-1);
$readmemb("file_fire6_expand3_132.mem",rom_66,0,2**ADDR-1);
$readmemb("file_fire6_expand3_134.mem",rom_67,0,2**ADDR-1);
$readmemb("file_fire6_expand3_136.mem",rom_68,0,2**ADDR-1);
$readmemb("file_fire6_expand3_138.mem",rom_69,0,2**ADDR-1);
$readmemb("file_fire6_expand3_140.mem",rom_70,0,2**ADDR-1);
$readmemb("file_fire6_expand3_142.mem",rom_71,0,2**ADDR-1);
$readmemb("file_fire6_expand3_144.mem",rom_72,0,2**ADDR-1);
$readmemb("file_fire6_expand3_146.mem",rom_73,0,2**ADDR-1);
$readmemb("file_fire6_expand3_148.mem",rom_74,0,2**ADDR-1);
$readmemb("file_fire6_expand3_150.mem",rom_75,0,2**ADDR-1);
$readmemb("file_fire6_expand3_152.mem",rom_76,0,2**ADDR-1);
$readmemb("file_fire6_expand3_154.mem",rom_77,0,2**ADDR-1);
$readmemb("file_fire6_expand3_156.mem",rom_78,0,2**ADDR-1);
$readmemb("file_fire6_expand3_158.mem",rom_79,0,2**ADDR-1);
$readmemb("file_fire6_expand3_160.mem",rom_80,0,2**ADDR-1);
$readmemb("file_fire6_expand3_162.mem",rom_81,0,2**ADDR-1);
$readmemb("file_fire6_expand3_164.mem",rom_82,0,2**ADDR-1);
$readmemb("file_fire6_expand3_166.mem",rom_83,0,2**ADDR-1);
$readmemb("file_fire6_expand3_168.mem",rom_84,0,2**ADDR-1);
$readmemb("file_fire6_expand3_170.mem",rom_85,0,2**ADDR-1);
$readmemb("file_fire6_expand3_172.mem",rom_86,0,2**ADDR-1);
$readmemb("file_fire6_expand3_174.mem",rom_87,0,2**ADDR-1);
$readmemb("file_fire6_expand3_176.mem",rom_88,0,2**ADDR-1);
$readmemb("file_fire6_expand3_178.mem",rom_89,0,2**ADDR-1);
$readmemb("file_fire6_expand3_180.mem",rom_90,0,2**ADDR-1);
$readmemb("file_fire6_expand3_182.mem",rom_91,0,2**ADDR-1);
$readmemb("file_fire6_expand3_184.mem",rom_92,0,2**ADDR-1);
$readmemb("file_fire6_expand3_186.mem",rom_93,0,2**ADDR-1);
$readmemb("file_fire6_expand3_188.mem",rom_94,0,2**ADDR-1);
$readmemb("file_fire6_expand3_190.mem",rom_95,0,2**ADDR-1);
$readmemb("file_fire6_expand3_192.mem",rom_96,0,2**ADDR-1);
$readmemb("file_fire6_expand3_194.mem",rom_97,0,2**ADDR-1);
$readmemb("file_fire6_expand3_196.mem",rom_98,0,2**ADDR-1);
$readmemb("file_fire6_expand3_198.mem",rom_99,0,2**ADDR-1);
$readmemb("file_fire6_expand3_200.mem",rom_100,0,2**ADDR-1);
$readmemb("file_fire6_expand3_202.mem",rom_101,0,2**ADDR-1);
$readmemb("file_fire6_expand3_204.mem",rom_102,0,2**ADDR-1);
$readmemb("file_fire6_expand3_206.mem",rom_103,0,2**ADDR-1);
$readmemb("file_fire6_expand3_208.mem",rom_104,0,2**ADDR-1);
$readmemb("file_fire6_expand3_210.mem",rom_105,0,2**ADDR-1);
$readmemb("file_fire6_expand3_212.mem",rom_106,0,2**ADDR-1);
$readmemb("file_fire6_expand3_214.mem",rom_107,0,2**ADDR-1);
$readmemb("file_fire6_expand3_216.mem",rom_108,0,2**ADDR-1);
$readmemb("file_fire6_expand3_218.mem",rom_109,0,2**ADDR-1);
$readmemb("file_fire6_expand3_220.mem",rom_110,0,2**ADDR-1);
$readmemb("file_fire6_expand3_222.mem",rom_111,0,2**ADDR-1);
$readmemb("file_fire6_expand3_224.mem",rom_112,0,2**ADDR-1);
$readmemb("file_fire6_expand3_226.mem",rom_113,0,2**ADDR-1);
$readmemb("file_fire6_expand3_228.mem",rom_114,0,2**ADDR-1);
$readmemb("file_fire6_expand3_230.mem",rom_115,0,2**ADDR-1);
$readmemb("file_fire6_expand3_232.mem",rom_116,0,2**ADDR-1);
$readmemb("file_fire6_expand3_234.mem",rom_117,0,2**ADDR-1);
$readmemb("file_fire6_expand3_236.mem",rom_118,0,2**ADDR-1);
$readmemb("file_fire6_expand3_238.mem",rom_119,0,2**ADDR-1);
$readmemb("file_fire6_expand3_240.mem",rom_120,0,2**ADDR-1);
$readmemb("file_fire6_expand3_242.mem",rom_121,0,2**ADDR-1);
$readmemb("file_fire6_expand3_244.mem",rom_122,0,2**ADDR-1);
$readmemb("file_fire6_expand3_246.mem",rom_123,0,2**ADDR-1);
$readmemb("file_fire6_expand3_248.mem",rom_124,0,2**ADDR-1);
$readmemb("file_fire6_expand3_250.mem",rom_125,0,2**ADDR-1);
$readmemb("file_fire6_expand3_252.mem",rom_126,0,2**ADDR-1);
$readmemb("file_fire6_expand3_254.mem",rom_127,0,2**ADDR-1);
$readmemb("file_fire6_expand3_256.mem",rom_128,0,2**ADDR-1);
end
always @(posedge clk) begin
rom_out[0]<= rom_1[address];
rom_out[2]<= rom_2[address];
rom_out[4]<= rom_3[address];
rom_out[6]<= rom_4[address];
rom_out[8]<= rom_5[address];
rom_out[10]<= rom_6[address];
rom_out[12]<= rom_7[address];
rom_out[14]<= rom_8[address];
rom_out[16]<= rom_9[address];
rom_out[18]<= rom_10[address];
rom_out[20]<= rom_11[address];
rom_out[22]<= rom_12[address];
rom_out[24]<= rom_13[address];
rom_out[26]<= rom_14[address];
rom_out[28]<= rom_15[address];
rom_out[30]<= rom_16[address];
rom_out[32]<= rom_17[address];
rom_out[34]<= rom_18[address];
rom_out[36]<= rom_19[address];
rom_out[38]<= rom_20[address];
rom_out[40]<= rom_21[address];
rom_out[42]<= rom_22[address];
rom_out[44]<= rom_23[address];
rom_out[46]<= rom_24[address];
rom_out[48]<= rom_25[address];
rom_out[50]<= rom_26[address];
rom_out[52]<= rom_27[address];
rom_out[54]<= rom_28[address];
rom_out[56]<= rom_29[address];
rom_out[58]<= rom_30[address];
rom_out[60]<= rom_31[address];
rom_out[62]<= rom_32[address];
rom_out[64]<= rom_33[address];
rom_out[66]<= rom_34[address];
rom_out[68]<= rom_35[address];
rom_out[70]<= rom_36[address];
rom_out[72]<= rom_37[address];
rom_out[74]<= rom_38[address];
rom_out[76]<= rom_39[address];
rom_out[78]<= rom_40[address];
rom_out[80]<= rom_41[address];
rom_out[82]<= rom_42[address];
rom_out[84]<= rom_43[address];
rom_out[86]<= rom_44[address];
rom_out[88]<= rom_45[address];
rom_out[90]<= rom_46[address];
rom_out[92]<= rom_47[address];
rom_out[94]<= rom_48[address];
rom_out[96]<= rom_49[address];
rom_out[98]<= rom_50[address];
rom_out[100]<= rom_51[address];
rom_out[102]<= rom_52[address];
rom_out[104]<= rom_53[address];
rom_out[106]<= rom_54[address];
rom_out[108]<= rom_55[address];
rom_out[110]<= rom_56[address];
rom_out[112]<= rom_57[address];
rom_out[114]<= rom_58[address];
rom_out[116]<= rom_59[address];
rom_out[118]<= rom_60[address];
rom_out[120]<= rom_61[address];
rom_out[122]<= rom_62[address];
rom_out[124]<= rom_63[address];
rom_out[126]<= rom_64[address];
rom_out[128]<= rom_65[address];
rom_out[130]<= rom_66[address];
rom_out[132]<= rom_67[address];
rom_out[134]<= rom_68[address];
rom_out[136]<= rom_69[address];
rom_out[138]<= rom_70[address];
rom_out[140]<= rom_71[address];
rom_out[142]<= rom_72[address];
rom_out[144]<= rom_73[address];
rom_out[146]<= rom_74[address];
rom_out[148]<= rom_75[address];
rom_out[150]<= rom_76[address];
rom_out[152]<= rom_77[address];
rom_out[154]<= rom_78[address];
rom_out[156]<= rom_79[address];
rom_out[158]<= rom_80[address];
rom_out[160]<= rom_81[address];
rom_out[162]<= rom_82[address];
rom_out[164]<= rom_83[address];
rom_out[166]<= rom_84[address];
rom_out[168]<= rom_85[address];
rom_out[170]<= rom_86[address];
rom_out[172]<= rom_87[address];
rom_out[174]<= rom_88[address];
rom_out[176]<= rom_89[address];
rom_out[178]<= rom_90[address];
rom_out[180]<= rom_91[address];
rom_out[182]<= rom_92[address];
rom_out[184]<= rom_93[address];
rom_out[186]<= rom_94[address];
rom_out[188]<= rom_95[address];
rom_out[190]<= rom_96[address];
rom_out[192]<= rom_97[address];
rom_out[194]<= rom_98[address];
rom_out[196]<= rom_99[address];
rom_out[198]<= rom_100[address];
rom_out[200]<= rom_101[address];
rom_out[202]<= rom_102[address];
rom_out[204]<= rom_103[address];
rom_out[206]<= rom_104[address];
rom_out[208]<= rom_105[address];
rom_out[210]<= rom_106[address];
rom_out[212]<= rom_107[address];
rom_out[214]<= rom_108[address];
rom_out[216]<= rom_109[address];
rom_out[218]<= rom_110[address];
rom_out[220]<= rom_111[address];
rom_out[222]<= rom_112[address];
rom_out[224]<= rom_113[address];
rom_out[226]<= rom_114[address];
rom_out[228]<= rom_115[address];
rom_out[230]<= rom_116[address];
rom_out[232]<= rom_117[address];
rom_out[234]<= rom_118[address];
rom_out[236]<= rom_119[address];
rom_out[238]<= rom_120[address];
rom_out[240]<= rom_121[address];
rom_out[242]<= rom_122[address];
rom_out[244]<= rom_123[address];
rom_out[246]<= rom_124[address];
rom_out[248]<= rom_125[address];
rom_out[250]<= rom_126[address];
rom_out[252]<= rom_127[address];
rom_out[254]<= rom_128[address];
rom_out[1]<= rom_1[address+512];
rom_out[3]<= rom_2[address+512];
rom_out[5]<= rom_3[address+512];
rom_out[7]<= rom_4[address+512];
rom_out[9]<= rom_5[address+512];
rom_out[11]<= rom_6[address+512];
rom_out[13]<= rom_7[address+512];
rom_out[15]<= rom_8[address+512];
rom_out[17]<= rom_9[address+512];
rom_out[19]<= rom_10[address+512];
rom_out[21]<= rom_11[address+512];
rom_out[23]<= rom_12[address+512];
rom_out[25]<= rom_13[address+512];
rom_out[27]<= rom_14[address+512];
rom_out[29]<= rom_15[address+512];
rom_out[31]<= rom_16[address+512];
rom_out[33]<= rom_17[address+512];
rom_out[35]<= rom_18[address+512];
rom_out[37]<= rom_19[address+512];
rom_out[39]<= rom_20[address+512];
rom_out[41]<= rom_21[address+512];
rom_out[43]<= rom_22[address+512];
rom_out[45]<= rom_23[address+512];
rom_out[47]<= rom_24[address+512];
rom_out[49]<= rom_25[address+512];
rom_out[51]<= rom_26[address+512];
rom_out[53]<= rom_27[address+512];
rom_out[55]<= rom_28[address+512];
rom_out[57]<= rom_29[address+512];
rom_out[59]<= rom_30[address+512];
rom_out[61]<= rom_31[address+512];
rom_out[63]<= rom_32[address+512];
rom_out[65]<= rom_33[address+512];
rom_out[67]<= rom_34[address+512];
rom_out[69]<= rom_35[address+512];
rom_out[71]<= rom_36[address+512];
rom_out[73]<= rom_37[address+512];
rom_out[75]<= rom_38[address+512];
rom_out[77]<= rom_39[address+512];
rom_out[79]<= rom_40[address+512];
rom_out[81]<= rom_41[address+512];
rom_out[83]<= rom_42[address+512];
rom_out[85]<= rom_43[address+512];
rom_out[87]<= rom_44[address+512];
rom_out[89]<= rom_45[address+512];
rom_out[91]<= rom_46[address+512];
rom_out[93]<= rom_47[address+512];
rom_out[95]<= rom_48[address+512];
rom_out[97]<= rom_49[address+512];
rom_out[99]<= rom_50[address+512];
rom_out[101]<= rom_51[address+512];
rom_out[103]<= rom_52[address+512];
rom_out[105]<= rom_53[address+512];
rom_out[107]<= rom_54[address+512];
rom_out[109]<= rom_55[address+512];
rom_out[111]<= rom_56[address+512];
rom_out[113]<= rom_57[address+512];
rom_out[115]<= rom_58[address+512];
rom_out[117]<= rom_59[address+512];
rom_out[119]<= rom_60[address+512];
rom_out[121]<= rom_61[address+512];
rom_out[123]<= rom_62[address+512];
rom_out[125]<= rom_63[address+512];
rom_out[127]<= rom_64[address+512];
rom_out[129]<= rom_65[address+512];
rom_out[131]<= rom_66[address+512];
rom_out[133]<= rom_67[address+512];
rom_out[135]<= rom_68[address+512];
rom_out[137]<= rom_69[address+512];
rom_out[139]<= rom_70[address+512];
rom_out[141]<= rom_71[address+512];
rom_out[143]<= rom_72[address+512];
rom_out[145]<= rom_73[address+512];
rom_out[147]<= rom_74[address+512];
rom_out[149]<= rom_75[address+512];
rom_out[151]<= rom_76[address+512];
rom_out[153]<= rom_77[address+512];
rom_out[155]<= rom_78[address+512];
rom_out[157]<= rom_79[address+512];
rom_out[159]<= rom_80[address+512];
rom_out[161]<= rom_81[address+512];
rom_out[163]<= rom_82[address+512];
rom_out[165]<= rom_83[address+512];
rom_out[167]<= rom_84[address+512];
rom_out[169]<= rom_85[address+512];
rom_out[171]<= rom_86[address+512];
rom_out[173]<= rom_87[address+512];
rom_out[175]<= rom_88[address+512];
rom_out[177]<= rom_89[address+512];
rom_out[179]<= rom_90[address+512];
rom_out[181]<= rom_91[address+512];
rom_out[183]<= rom_92[address+512];
rom_out[185]<= rom_93[address+512];
rom_out[187]<= rom_94[address+512];
rom_out[189]<= rom_95[address+512];
rom_out[191]<= rom_96[address+512];
rom_out[193]<= rom_97[address+512];
rom_out[195]<= rom_98[address+512];
rom_out[197]<= rom_99[address+512];
rom_out[199]<= rom_100[address+512];
rom_out[201]<= rom_101[address+512];
rom_out[203]<= rom_102[address+512];
rom_out[205]<= rom_103[address+512];
rom_out[207]<= rom_104[address+512];
rom_out[209]<= rom_105[address+512];
rom_out[211]<= rom_106[address+512];
rom_out[213]<= rom_107[address+512];
rom_out[215]<= rom_108[address+512];
rom_out[217]<= rom_109[address+512];
rom_out[219]<= rom_110[address+512];
rom_out[221]<= rom_111[address+512];
rom_out[223]<= rom_112[address+512];
rom_out[225]<= rom_113[address+512];
rom_out[227]<= rom_114[address+512];
rom_out[229]<= rom_115[address+512];
rom_out[231]<= rom_116[address+512];
rom_out[233]<= rom_117[address+512];
rom_out[235]<= rom_118[address+512];
rom_out[237]<= rom_119[address+512];
rom_out[239]<= rom_120[address+512];
rom_out[241]<= rom_121[address+512];
rom_out[243]<= rom_122[address+512];
rom_out[245]<= rom_123[address+512];
rom_out[247]<= rom_124[address+512];
rom_out[249]<= rom_125[address+512];
rom_out[251]<= rom_126[address+512];
rom_out[253]<= rom_127[address+512];
rom_out[255]<= rom_128[address+512];
end
endmodule
