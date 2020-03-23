
module biasing_fire5_squeeze (
	output [32-1:0] bias_mem [0:32-1]
);

reg [32-1:0] bias_reg_0 = 32'b11111111111111111111111110100101;
reg [32-1:0] bias_reg_1 = 32'b00000000000000000000000010010001;
reg [32-1:0] bias_reg_2 = 32'b00000000000000000000000010100100;
reg [32-1:0] bias_reg_3 = 32'b11111111111111111111111011010100;
reg [32-1:0] bias_reg_4 = 32'b00000000000000000000000000110000;
reg [32-1:0] bias_reg_5 = 32'b00000000000000000000000011001011;
reg [32-1:0] bias_reg_6 = 32'b00000000000000000000000100110101;
reg [32-1:0] bias_reg_7 = 32'b11111111111111111111111111110011;
reg [32-1:0] bias_reg_8 = 32'b11111111111111111111111011111011;
reg [32-1:0] bias_reg_9 = 32'b00000000000000000000000000001110;
reg [32-1:0] bias_reg_10 = 32'b00000000000000000000000000111010;
reg [32-1:0] bias_reg_11 = 32'b11111111111111111111111101101101;
reg [32-1:0] bias_reg_12 = 32'b11111111111111111111101010111111;
reg [32-1:0] bias_reg_13 = 32'b00000000000000000000010100000000;
reg [32-1:0] bias_reg_14 = 32'b11111111111111111111111111001100;
reg [32-1:0] bias_reg_15 = 32'b00000000000000000000001101110011;
reg [32-1:0] bias_reg_16 = 32'b00000000000000000000000100111101;
reg [32-1:0] bias_reg_17 = 32'b11111111111111111111111100100111;
reg [32-1:0] bias_reg_18 = 32'b00000000000000000000000000100111;
reg [32-1:0] bias_reg_19 = 32'b00000000000000000000000010100110;
reg [32-1:0] bias_reg_20 = 32'b00000000000000000000000000111011;
reg [32-1:0] bias_reg_21 = 32'b00000000000000000000000010000101;
reg [32-1:0] bias_reg_22 = 32'b00000000000000000000000010110100;
reg [32-1:0] bias_reg_23 = 32'b00000000000000000000000000010001;
reg [32-1:0] bias_reg_24 = 32'b00000000000000000000000000011011;
reg [32-1:0] bias_reg_25 = 32'b11111111111111111111111101111010;
reg [32-1:0] bias_reg_26 = 32'b00000000000000000000000110101001;
reg [32-1:0] bias_reg_27 = 32'b00000000000000000000000000001110;
reg [32-1:0] bias_reg_28 = 32'b00000000000000000000000001101110;
reg [32-1:0] bias_reg_29 = 32'b11111111111111111111111110010110;
reg [32-1:0] bias_reg_30 = 32'b00000000000000000000000001010100;
reg [32-1:0] bias_reg_31 = 32'b11111111111111111111111111110100;
assign bias_mem[0] = bias_reg_0;
assign bias_mem[1] = bias_reg_1;
assign bias_mem[2] = bias_reg_2;
assign bias_mem[3] = bias_reg_3;
assign bias_mem[4] = bias_reg_4;
assign bias_mem[5] = bias_reg_5;
assign bias_mem[6] = bias_reg_6;
assign bias_mem[7] = bias_reg_7;
assign bias_mem[8] = bias_reg_8;
assign bias_mem[9] = bias_reg_9;
assign bias_mem[10] = bias_reg_10;
assign bias_mem[11] = bias_reg_11;
assign bias_mem[12] = bias_reg_12;
assign bias_mem[13] = bias_reg_13;
assign bias_mem[14] = bias_reg_14;
assign bias_mem[15] = bias_reg_15;
assign bias_mem[16] = bias_reg_16;
assign bias_mem[17] = bias_reg_17;
assign bias_mem[18] = bias_reg_18;
assign bias_mem[19] = bias_reg_19;
assign bias_mem[20] = bias_reg_20;
assign bias_mem[21] = bias_reg_21;
assign bias_mem[22] = bias_reg_22;
assign bias_mem[23] = bias_reg_23;
assign bias_mem[24] = bias_reg_24;
assign bias_mem[25] = bias_reg_25;
assign bias_mem[26] = bias_reg_26;
assign bias_mem[27] = bias_reg_27;
assign bias_mem[28] = bias_reg_28;
assign bias_mem[29] = bias_reg_29;
assign bias_mem[30] = bias_reg_30;
assign bias_mem[31] = bias_reg_31;
endmodule