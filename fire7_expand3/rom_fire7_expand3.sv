
	/* verilator lint_off COMBDLY */
	module rom_fire7_expand3 #(
	parameter WIDTH=16,
	parameter KERNEL=3,
	parameter ADDR=9,
	parameter NUM=192)
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

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_9 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_10 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_11 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_12 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_13 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_14 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_15 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_16 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_17 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_18 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_19 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_20 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_21 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_22 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_23 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_24 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_25 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_26 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_27 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_28 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_29 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_30 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_31 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_32 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_33 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_34 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_35 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_36 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_37 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_38 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_39 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_40 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_41 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_42 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_43 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_44 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_45 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_46 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_47 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_48 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_49 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_50 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_51 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_52 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_53 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_54 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_55 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_56 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_57 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_58 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_59 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_60 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_61 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_62 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_63 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_64 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_65 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_66 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_67 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_68 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_69 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_70 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_71 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_72 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_73 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_74 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_75 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_76 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_77 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_78 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_79 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_80 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_81 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_82 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_83 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_84 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_85 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_86 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_87 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_88 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_89 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_90 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_91 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_92 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_93 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_94 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_95 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_96 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_97 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_98 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_99 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_100 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_101 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_102 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_103 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_104 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_105 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_106 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_107 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_108 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_109 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_110 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_111 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_112 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_113 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_114 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_115 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_116 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_117 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_118 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_119 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_120 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_121 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_122 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_123 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_124 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_125 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_126 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_127 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_128 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_129 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_130 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_131 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_132 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_133 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_134 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_135 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_136 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_137 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_138 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_139 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_140 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_141 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_142 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_143 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_144 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_145 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_146 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_147 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_148 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_149 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_150 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_151 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_152 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_153 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_154 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_155 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_156 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_157 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_158 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_159 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_160 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_161 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_162 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_163 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_164 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_165 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_166 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_167 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_168 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_169 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_170 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_171 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_172 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_173 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_174 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_175 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_176 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_177 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_178 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_179 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_180 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_181 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_182 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_183 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_184 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_185 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_186 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_187 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_188 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_189 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_190 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_191 [0:2**ADDR-1] ;

  	(* rom_style="{distributed}" *)
	reg [WIDTH-1:0] rom_192 [0:2**ADDR-1] ;
initial  begin
$readmemb("file_fire7_expand3_1.mem",rom_1,0,2**ADDR-1);
$readmemb("file_fire7_expand3_2.mem",rom_2,0,2**ADDR-1);
$readmemb("file_fire7_expand3_3.mem",rom_3,0,2**ADDR-1);
$readmemb("file_fire7_expand3_4.mem",rom_4,0,2**ADDR-1);
$readmemb("file_fire7_expand3_5.mem",rom_5,0,2**ADDR-1);
$readmemb("file_fire7_expand3_6.mem",rom_6,0,2**ADDR-1);
$readmemb("file_fire7_expand3_7.mem",rom_7,0,2**ADDR-1);
$readmemb("file_fire7_expand3_8.mem",rom_8,0,2**ADDR-1);
$readmemb("file_fire7_expand3_9.mem",rom_9,0,2**ADDR-1);
$readmemb("file_fire7_expand3_10.mem",rom_10,0,2**ADDR-1);
$readmemb("file_fire7_expand3_11.mem",rom_11,0,2**ADDR-1);
$readmemb("file_fire7_expand3_12.mem",rom_12,0,2**ADDR-1);
$readmemb("file_fire7_expand3_13.mem",rom_13,0,2**ADDR-1);
$readmemb("file_fire7_expand3_14.mem",rom_14,0,2**ADDR-1);
$readmemb("file_fire7_expand3_15.mem",rom_15,0,2**ADDR-1);
$readmemb("file_fire7_expand3_16.mem",rom_16,0,2**ADDR-1);
$readmemb("file_fire7_expand3_17.mem",rom_17,0,2**ADDR-1);
$readmemb("file_fire7_expand3_18.mem",rom_18,0,2**ADDR-1);
$readmemb("file_fire7_expand3_19.mem",rom_19,0,2**ADDR-1);
$readmemb("file_fire7_expand3_20.mem",rom_20,0,2**ADDR-1);
$readmemb("file_fire7_expand3_21.mem",rom_21,0,2**ADDR-1);
$readmemb("file_fire7_expand3_22.mem",rom_22,0,2**ADDR-1);
$readmemb("file_fire7_expand3_23.mem",rom_23,0,2**ADDR-1);
$readmemb("file_fire7_expand3_24.mem",rom_24,0,2**ADDR-1);
$readmemb("file_fire7_expand3_25.mem",rom_25,0,2**ADDR-1);
$readmemb("file_fire7_expand3_26.mem",rom_26,0,2**ADDR-1);
$readmemb("file_fire7_expand3_27.mem",rom_27,0,2**ADDR-1);
$readmemb("file_fire7_expand3_28.mem",rom_28,0,2**ADDR-1);
$readmemb("file_fire7_expand3_29.mem",rom_29,0,2**ADDR-1);
$readmemb("file_fire7_expand3_30.mem",rom_30,0,2**ADDR-1);
$readmemb("file_fire7_expand3_31.mem",rom_31,0,2**ADDR-1);
$readmemb("file_fire7_expand3_32.mem",rom_32,0,2**ADDR-1);
$readmemb("file_fire7_expand3_33.mem",rom_33,0,2**ADDR-1);
$readmemb("file_fire7_expand3_34.mem",rom_34,0,2**ADDR-1);
$readmemb("file_fire7_expand3_35.mem",rom_35,0,2**ADDR-1);
$readmemb("file_fire7_expand3_36.mem",rom_36,0,2**ADDR-1);
$readmemb("file_fire7_expand3_37.mem",rom_37,0,2**ADDR-1);
$readmemb("file_fire7_expand3_38.mem",rom_38,0,2**ADDR-1);
$readmemb("file_fire7_expand3_39.mem",rom_39,0,2**ADDR-1);
$readmemb("file_fire7_expand3_40.mem",rom_40,0,2**ADDR-1);
$readmemb("file_fire7_expand3_41.mem",rom_41,0,2**ADDR-1);
$readmemb("file_fire7_expand3_42.mem",rom_42,0,2**ADDR-1);
$readmemb("file_fire7_expand3_43.mem",rom_43,0,2**ADDR-1);
$readmemb("file_fire7_expand3_44.mem",rom_44,0,2**ADDR-1);
$readmemb("file_fire7_expand3_45.mem",rom_45,0,2**ADDR-1);
$readmemb("file_fire7_expand3_46.mem",rom_46,0,2**ADDR-1);
$readmemb("file_fire7_expand3_47.mem",rom_47,0,2**ADDR-1);
$readmemb("file_fire7_expand3_48.mem",rom_48,0,2**ADDR-1);
$readmemb("file_fire7_expand3_49.mem",rom_49,0,2**ADDR-1);
$readmemb("file_fire7_expand3_50.mem",rom_50,0,2**ADDR-1);
$readmemb("file_fire7_expand3_51.mem",rom_51,0,2**ADDR-1);
$readmemb("file_fire7_expand3_52.mem",rom_52,0,2**ADDR-1);
$readmemb("file_fire7_expand3_53.mem",rom_53,0,2**ADDR-1);
$readmemb("file_fire7_expand3_54.mem",rom_54,0,2**ADDR-1);
$readmemb("file_fire7_expand3_55.mem",rom_55,0,2**ADDR-1);
$readmemb("file_fire7_expand3_56.mem",rom_56,0,2**ADDR-1);
$readmemb("file_fire7_expand3_57.mem",rom_57,0,2**ADDR-1);
$readmemb("file_fire7_expand3_58.mem",rom_58,0,2**ADDR-1);
$readmemb("file_fire7_expand3_59.mem",rom_59,0,2**ADDR-1);
$readmemb("file_fire7_expand3_60.mem",rom_60,0,2**ADDR-1);
$readmemb("file_fire7_expand3_61.mem",rom_61,0,2**ADDR-1);
$readmemb("file_fire7_expand3_62.mem",rom_62,0,2**ADDR-1);
$readmemb("file_fire7_expand3_63.mem",rom_63,0,2**ADDR-1);
$readmemb("file_fire7_expand3_64.mem",rom_64,0,2**ADDR-1);
$readmemb("file_fire7_expand3_65.mem",rom_65,0,2**ADDR-1);
$readmemb("file_fire7_expand3_66.mem",rom_66,0,2**ADDR-1);
$readmemb("file_fire7_expand3_67.mem",rom_67,0,2**ADDR-1);
$readmemb("file_fire7_expand3_68.mem",rom_68,0,2**ADDR-1);
$readmemb("file_fire7_expand3_69.mem",rom_69,0,2**ADDR-1);
$readmemb("file_fire7_expand3_70.mem",rom_70,0,2**ADDR-1);
$readmemb("file_fire7_expand3_71.mem",rom_71,0,2**ADDR-1);
$readmemb("file_fire7_expand3_72.mem",rom_72,0,2**ADDR-1);
$readmemb("file_fire7_expand3_73.mem",rom_73,0,2**ADDR-1);
$readmemb("file_fire7_expand3_74.mem",rom_74,0,2**ADDR-1);
$readmemb("file_fire7_expand3_75.mem",rom_75,0,2**ADDR-1);
$readmemb("file_fire7_expand3_76.mem",rom_76,0,2**ADDR-1);
$readmemb("file_fire7_expand3_77.mem",rom_77,0,2**ADDR-1);
$readmemb("file_fire7_expand3_78.mem",rom_78,0,2**ADDR-1);
$readmemb("file_fire7_expand3_79.mem",rom_79,0,2**ADDR-1);
$readmemb("file_fire7_expand3_80.mem",rom_80,0,2**ADDR-1);
$readmemb("file_fire7_expand3_81.mem",rom_81,0,2**ADDR-1);
$readmemb("file_fire7_expand3_82.mem",rom_82,0,2**ADDR-1);
$readmemb("file_fire7_expand3_83.mem",rom_83,0,2**ADDR-1);
$readmemb("file_fire7_expand3_84.mem",rom_84,0,2**ADDR-1);
$readmemb("file_fire7_expand3_85.mem",rom_85,0,2**ADDR-1);
$readmemb("file_fire7_expand3_86.mem",rom_86,0,2**ADDR-1);
$readmemb("file_fire7_expand3_87.mem",rom_87,0,2**ADDR-1);
$readmemb("file_fire7_expand3_88.mem",rom_88,0,2**ADDR-1);
$readmemb("file_fire7_expand3_89.mem",rom_89,0,2**ADDR-1);
$readmemb("file_fire7_expand3_90.mem",rom_90,0,2**ADDR-1);
$readmemb("file_fire7_expand3_91.mem",rom_91,0,2**ADDR-1);
$readmemb("file_fire7_expand3_92.mem",rom_92,0,2**ADDR-1);
$readmemb("file_fire7_expand3_93.mem",rom_93,0,2**ADDR-1);
$readmemb("file_fire7_expand3_94.mem",rom_94,0,2**ADDR-1);
$readmemb("file_fire7_expand3_95.mem",rom_95,0,2**ADDR-1);
$readmemb("file_fire7_expand3_96.mem",rom_96,0,2**ADDR-1);
$readmemb("file_fire7_expand3_97.mem",rom_97,0,2**ADDR-1);
$readmemb("file_fire7_expand3_98.mem",rom_98,0,2**ADDR-1);
$readmemb("file_fire7_expand3_99.mem",rom_99,0,2**ADDR-1);
$readmemb("file_fire7_expand3_100.mem",rom_100,0,2**ADDR-1);
$readmemb("file_fire7_expand3_101.mem",rom_101,0,2**ADDR-1);
$readmemb("file_fire7_expand3_102.mem",rom_102,0,2**ADDR-1);
$readmemb("file_fire7_expand3_103.mem",rom_103,0,2**ADDR-1);
$readmemb("file_fire7_expand3_104.mem",rom_104,0,2**ADDR-1);
$readmemb("file_fire7_expand3_105.mem",rom_105,0,2**ADDR-1);
$readmemb("file_fire7_expand3_106.mem",rom_106,0,2**ADDR-1);
$readmemb("file_fire7_expand3_107.mem",rom_107,0,2**ADDR-1);
$readmemb("file_fire7_expand3_108.mem",rom_108,0,2**ADDR-1);
$readmemb("file_fire7_expand3_109.mem",rom_109,0,2**ADDR-1);
$readmemb("file_fire7_expand3_110.mem",rom_110,0,2**ADDR-1);
$readmemb("file_fire7_expand3_111.mem",rom_111,0,2**ADDR-1);
$readmemb("file_fire7_expand3_112.mem",rom_112,0,2**ADDR-1);
$readmemb("file_fire7_expand3_113.mem",rom_113,0,2**ADDR-1);
$readmemb("file_fire7_expand3_114.mem",rom_114,0,2**ADDR-1);
$readmemb("file_fire7_expand3_115.mem",rom_115,0,2**ADDR-1);
$readmemb("file_fire7_expand3_116.mem",rom_116,0,2**ADDR-1);
$readmemb("file_fire7_expand3_117.mem",rom_117,0,2**ADDR-1);
$readmemb("file_fire7_expand3_118.mem",rom_118,0,2**ADDR-1);
$readmemb("file_fire7_expand3_119.mem",rom_119,0,2**ADDR-1);
$readmemb("file_fire7_expand3_120.mem",rom_120,0,2**ADDR-1);
$readmemb("file_fire7_expand3_121.mem",rom_121,0,2**ADDR-1);
$readmemb("file_fire7_expand3_122.mem",rom_122,0,2**ADDR-1);
$readmemb("file_fire7_expand3_123.mem",rom_123,0,2**ADDR-1);
$readmemb("file_fire7_expand3_124.mem",rom_124,0,2**ADDR-1);
$readmemb("file_fire7_expand3_125.mem",rom_125,0,2**ADDR-1);
$readmemb("file_fire7_expand3_126.mem",rom_126,0,2**ADDR-1);
$readmemb("file_fire7_expand3_127.mem",rom_127,0,2**ADDR-1);
$readmemb("file_fire7_expand3_128.mem",rom_128,0,2**ADDR-1);
$readmemb("file_fire7_expand3_129.mem",rom_129,0,2**ADDR-1);
$readmemb("file_fire7_expand3_130.mem",rom_130,0,2**ADDR-1);
$readmemb("file_fire7_expand3_131.mem",rom_131,0,2**ADDR-1);
$readmemb("file_fire7_expand3_132.mem",rom_132,0,2**ADDR-1);
$readmemb("file_fire7_expand3_133.mem",rom_133,0,2**ADDR-1);
$readmemb("file_fire7_expand3_134.mem",rom_134,0,2**ADDR-1);
$readmemb("file_fire7_expand3_135.mem",rom_135,0,2**ADDR-1);
$readmemb("file_fire7_expand3_136.mem",rom_136,0,2**ADDR-1);
$readmemb("file_fire7_expand3_137.mem",rom_137,0,2**ADDR-1);
$readmemb("file_fire7_expand3_138.mem",rom_138,0,2**ADDR-1);
$readmemb("file_fire7_expand3_139.mem",rom_139,0,2**ADDR-1);
$readmemb("file_fire7_expand3_140.mem",rom_140,0,2**ADDR-1);
$readmemb("file_fire7_expand3_141.mem",rom_141,0,2**ADDR-1);
$readmemb("file_fire7_expand3_142.mem",rom_142,0,2**ADDR-1);
$readmemb("file_fire7_expand3_143.mem",rom_143,0,2**ADDR-1);
$readmemb("file_fire7_expand3_144.mem",rom_144,0,2**ADDR-1);
$readmemb("file_fire7_expand3_145.mem",rom_145,0,2**ADDR-1);
$readmemb("file_fire7_expand3_146.mem",rom_146,0,2**ADDR-1);
$readmemb("file_fire7_expand3_147.mem",rom_147,0,2**ADDR-1);
$readmemb("file_fire7_expand3_148.mem",rom_148,0,2**ADDR-1);
$readmemb("file_fire7_expand3_149.mem",rom_149,0,2**ADDR-1);
$readmemb("file_fire7_expand3_150.mem",rom_150,0,2**ADDR-1);
$readmemb("file_fire7_expand3_151.mem",rom_151,0,2**ADDR-1);
$readmemb("file_fire7_expand3_152.mem",rom_152,0,2**ADDR-1);
$readmemb("file_fire7_expand3_153.mem",rom_153,0,2**ADDR-1);
$readmemb("file_fire7_expand3_154.mem",rom_154,0,2**ADDR-1);
$readmemb("file_fire7_expand3_155.mem",rom_155,0,2**ADDR-1);
$readmemb("file_fire7_expand3_156.mem",rom_156,0,2**ADDR-1);
$readmemb("file_fire7_expand3_157.mem",rom_157,0,2**ADDR-1);
$readmemb("file_fire7_expand3_158.mem",rom_158,0,2**ADDR-1);
$readmemb("file_fire7_expand3_159.mem",rom_159,0,2**ADDR-1);
$readmemb("file_fire7_expand3_160.mem",rom_160,0,2**ADDR-1);
$readmemb("file_fire7_expand3_161.mem",rom_161,0,2**ADDR-1);
$readmemb("file_fire7_expand3_162.mem",rom_162,0,2**ADDR-1);
$readmemb("file_fire7_expand3_163.mem",rom_163,0,2**ADDR-1);
$readmemb("file_fire7_expand3_164.mem",rom_164,0,2**ADDR-1);
$readmemb("file_fire7_expand3_165.mem",rom_165,0,2**ADDR-1);
$readmemb("file_fire7_expand3_166.mem",rom_166,0,2**ADDR-1);
$readmemb("file_fire7_expand3_167.mem",rom_167,0,2**ADDR-1);
$readmemb("file_fire7_expand3_168.mem",rom_168,0,2**ADDR-1);
$readmemb("file_fire7_expand3_169.mem",rom_169,0,2**ADDR-1);
$readmemb("file_fire7_expand3_170.mem",rom_170,0,2**ADDR-1);
$readmemb("file_fire7_expand3_171.mem",rom_171,0,2**ADDR-1);
$readmemb("file_fire7_expand3_172.mem",rom_172,0,2**ADDR-1);
$readmemb("file_fire7_expand3_173.mem",rom_173,0,2**ADDR-1);
$readmemb("file_fire7_expand3_174.mem",rom_174,0,2**ADDR-1);
$readmemb("file_fire7_expand3_175.mem",rom_175,0,2**ADDR-1);
$readmemb("file_fire7_expand3_176.mem",rom_176,0,2**ADDR-1);
$readmemb("file_fire7_expand3_177.mem",rom_177,0,2**ADDR-1);
$readmemb("file_fire7_expand3_178.mem",rom_178,0,2**ADDR-1);
$readmemb("file_fire7_expand3_179.mem",rom_179,0,2**ADDR-1);
$readmemb("file_fire7_expand3_180.mem",rom_180,0,2**ADDR-1);
$readmemb("file_fire7_expand3_181.mem",rom_181,0,2**ADDR-1);
$readmemb("file_fire7_expand3_182.mem",rom_182,0,2**ADDR-1);
$readmemb("file_fire7_expand3_183.mem",rom_183,0,2**ADDR-1);
$readmemb("file_fire7_expand3_184.mem",rom_184,0,2**ADDR-1);
$readmemb("file_fire7_expand3_185.mem",rom_185,0,2**ADDR-1);
$readmemb("file_fire7_expand3_186.mem",rom_186,0,2**ADDR-1);
$readmemb("file_fire7_expand3_187.mem",rom_187,0,2**ADDR-1);
$readmemb("file_fire7_expand3_188.mem",rom_188,0,2**ADDR-1);
$readmemb("file_fire7_expand3_189.mem",rom_189,0,2**ADDR-1);
$readmemb("file_fire7_expand3_190.mem",rom_190,0,2**ADDR-1);
$readmemb("file_fire7_expand3_191.mem",rom_191,0,2**ADDR-1);
$readmemb("file_fire7_expand3_192.mem",rom_192,0,2**ADDR-1);
end
assign rom_out[0] = rom_1[address] ;
assign rom_out[1] = rom_2[address] ;
assign rom_out[2] = rom_3[address] ;
assign rom_out[3] = rom_4[address] ;
assign rom_out[4] = rom_5[address] ;
assign rom_out[5] = rom_6[address] ;
assign rom_out[6] = rom_7[address] ;
assign rom_out[7] = rom_8[address] ;
assign rom_out[8] = rom_9[address] ;
assign rom_out[9] = rom_10[address] ;
assign rom_out[10] = rom_11[address] ;
assign rom_out[11] = rom_12[address] ;
assign rom_out[12] = rom_13[address] ;
assign rom_out[13] = rom_14[address] ;
assign rom_out[14] = rom_15[address] ;
assign rom_out[15] = rom_16[address] ;
assign rom_out[16] = rom_17[address] ;
assign rom_out[17] = rom_18[address] ;
assign rom_out[18] = rom_19[address] ;
assign rom_out[19] = rom_20[address] ;
assign rom_out[20] = rom_21[address] ;
assign rom_out[21] = rom_22[address] ;
assign rom_out[22] = rom_23[address] ;
assign rom_out[23] = rom_24[address] ;
assign rom_out[24] = rom_25[address] ;
assign rom_out[25] = rom_26[address] ;
assign rom_out[26] = rom_27[address] ;
assign rom_out[27] = rom_28[address] ;
assign rom_out[28] = rom_29[address] ;
assign rom_out[29] = rom_30[address] ;
assign rom_out[30] = rom_31[address] ;
assign rom_out[31] = rom_32[address] ;
assign rom_out[32] = rom_33[address] ;
assign rom_out[33] = rom_34[address] ;
assign rom_out[34] = rom_35[address] ;
assign rom_out[35] = rom_36[address] ;
assign rom_out[36] = rom_37[address] ;
assign rom_out[37] = rom_38[address] ;
assign rom_out[38] = rom_39[address] ;
assign rom_out[39] = rom_40[address] ;
assign rom_out[40] = rom_41[address] ;
assign rom_out[41] = rom_42[address] ;
assign rom_out[42] = rom_43[address] ;
assign rom_out[43] = rom_44[address] ;
assign rom_out[44] = rom_45[address] ;
assign rom_out[45] = rom_46[address] ;
assign rom_out[46] = rom_47[address] ;
assign rom_out[47] = rom_48[address] ;
assign rom_out[48] = rom_49[address] ;
assign rom_out[49] = rom_50[address] ;
assign rom_out[50] = rom_51[address] ;
assign rom_out[51] = rom_52[address] ;
assign rom_out[52] = rom_53[address] ;
assign rom_out[53] = rom_54[address] ;
assign rom_out[54] = rom_55[address] ;
assign rom_out[55] = rom_56[address] ;
assign rom_out[56] = rom_57[address] ;
assign rom_out[57] = rom_58[address] ;
assign rom_out[58] = rom_59[address] ;
assign rom_out[59] = rom_60[address] ;
assign rom_out[60] = rom_61[address] ;
assign rom_out[61] = rom_62[address] ;
assign rom_out[62] = rom_63[address] ;
assign rom_out[63] = rom_64[address] ;
assign rom_out[64] = rom_65[address] ;
assign rom_out[65] = rom_66[address] ;
assign rom_out[66] = rom_67[address] ;
assign rom_out[67] = rom_68[address] ;
assign rom_out[68] = rom_69[address] ;
assign rom_out[69] = rom_70[address] ;
assign rom_out[70] = rom_71[address] ;
assign rom_out[71] = rom_72[address] ;
assign rom_out[72] = rom_73[address] ;
assign rom_out[73] = rom_74[address] ;
assign rom_out[74] = rom_75[address] ;
assign rom_out[75] = rom_76[address] ;
assign rom_out[76] = rom_77[address] ;
assign rom_out[77] = rom_78[address] ;
assign rom_out[78] = rom_79[address] ;
assign rom_out[79] = rom_80[address] ;
assign rom_out[80] = rom_81[address] ;
assign rom_out[81] = rom_82[address] ;
assign rom_out[82] = rom_83[address] ;
assign rom_out[83] = rom_84[address] ;
assign rom_out[84] = rom_85[address] ;
assign rom_out[85] = rom_86[address] ;
assign rom_out[86] = rom_87[address] ;
assign rom_out[87] = rom_88[address] ;
assign rom_out[88] = rom_89[address] ;
assign rom_out[89] = rom_90[address] ;
assign rom_out[90] = rom_91[address] ;
assign rom_out[91] = rom_92[address] ;
assign rom_out[92] = rom_93[address] ;
assign rom_out[93] = rom_94[address] ;
assign rom_out[94] = rom_95[address] ;
assign rom_out[95] = rom_96[address] ;
assign rom_out[96] = rom_97[address] ;
assign rom_out[97] = rom_98[address] ;
assign rom_out[98] = rom_99[address] ;
assign rom_out[99] = rom_100[address] ;
assign rom_out[100] = rom_101[address] ;
assign rom_out[101] = rom_102[address] ;
assign rom_out[102] = rom_103[address] ;
assign rom_out[103] = rom_104[address] ;
assign rom_out[104] = rom_105[address] ;
assign rom_out[105] = rom_106[address] ;
assign rom_out[106] = rom_107[address] ;
assign rom_out[107] = rom_108[address] ;
assign rom_out[108] = rom_109[address] ;
assign rom_out[109] = rom_110[address] ;
assign rom_out[110] = rom_111[address] ;
assign rom_out[111] = rom_112[address] ;
assign rom_out[112] = rom_113[address] ;
assign rom_out[113] = rom_114[address] ;
assign rom_out[114] = rom_115[address] ;
assign rom_out[115] = rom_116[address] ;
assign rom_out[116] = rom_117[address] ;
assign rom_out[117] = rom_118[address] ;
assign rom_out[118] = rom_119[address] ;
assign rom_out[119] = rom_120[address] ;
assign rom_out[120] = rom_121[address] ;
assign rom_out[121] = rom_122[address] ;
assign rom_out[122] = rom_123[address] ;
assign rom_out[123] = rom_124[address] ;
assign rom_out[124] = rom_125[address] ;
assign rom_out[125] = rom_126[address] ;
assign rom_out[126] = rom_127[address] ;
assign rom_out[127] = rom_128[address] ;
assign rom_out[128] = rom_129[address] ;
assign rom_out[129] = rom_130[address] ;
assign rom_out[130] = rom_131[address] ;
assign rom_out[131] = rom_132[address] ;
assign rom_out[132] = rom_133[address] ;
assign rom_out[133] = rom_134[address] ;
assign rom_out[134] = rom_135[address] ;
assign rom_out[135] = rom_136[address] ;
assign rom_out[136] = rom_137[address] ;
assign rom_out[137] = rom_138[address] ;
assign rom_out[138] = rom_139[address] ;
assign rom_out[139] = rom_140[address] ;
assign rom_out[140] = rom_141[address] ;
assign rom_out[141] = rom_142[address] ;
assign rom_out[142] = rom_143[address] ;
assign rom_out[143] = rom_144[address] ;
assign rom_out[144] = rom_145[address] ;
assign rom_out[145] = rom_146[address] ;
assign rom_out[146] = rom_147[address] ;
assign rom_out[147] = rom_148[address] ;
assign rom_out[148] = rom_149[address] ;
assign rom_out[149] = rom_150[address] ;
assign rom_out[150] = rom_151[address] ;
assign rom_out[151] = rom_152[address] ;
assign rom_out[152] = rom_153[address] ;
assign rom_out[153] = rom_154[address] ;
assign rom_out[154] = rom_155[address] ;
assign rom_out[155] = rom_156[address] ;
assign rom_out[156] = rom_157[address] ;
assign rom_out[157] = rom_158[address] ;
assign rom_out[158] = rom_159[address] ;
assign rom_out[159] = rom_160[address] ;
assign rom_out[160] = rom_161[address] ;
assign rom_out[161] = rom_162[address] ;
assign rom_out[162] = rom_163[address] ;
assign rom_out[163] = rom_164[address] ;
assign rom_out[164] = rom_165[address] ;
assign rom_out[165] = rom_166[address] ;
assign rom_out[166] = rom_167[address] ;
assign rom_out[167] = rom_168[address] ;
assign rom_out[168] = rom_169[address] ;
assign rom_out[169] = rom_170[address] ;
assign rom_out[170] = rom_171[address] ;
assign rom_out[171] = rom_172[address] ;
assign rom_out[172] = rom_173[address] ;
assign rom_out[173] = rom_174[address] ;
assign rom_out[174] = rom_175[address] ;
assign rom_out[175] = rom_176[address] ;
assign rom_out[176] = rom_177[address] ;
assign rom_out[177] = rom_178[address] ;
assign rom_out[178] = rom_179[address] ;
assign rom_out[179] = rom_180[address] ;
assign rom_out[180] = rom_181[address] ;
assign rom_out[181] = rom_182[address] ;
assign rom_out[182] = rom_183[address] ;
assign rom_out[183] = rom_184[address] ;
assign rom_out[184] = rom_185[address] ;
assign rom_out[185] = rom_186[address] ;
assign rom_out[186] = rom_187[address] ;
assign rom_out[187] = rom_188[address] ;
assign rom_out[188] = rom_189[address] ;
assign rom_out[189] = rom_190[address] ;
assign rom_out[190] = rom_191[address] ;
assign rom_out[191] = rom_192[address] ;
endmodule
