
module biasing_fire3_squeeze (
	output [32-1:0] bias_mem [0:16-1]
);

reg [32-1:0] bias_reg_0 = 32'b00000000000000000000010000110111;
reg [32-1:0] bias_reg_1 = 32'b11111111111111111111111110111110;
reg [32-1:0] bias_reg_2 = 32'b00000000000000000000000100110111;
reg [32-1:0] bias_reg_3 = 32'b00000000000000000000001001010001;
reg [32-1:0] bias_reg_4 = 32'b00000000000000000000000010100111;
reg [32-1:0] bias_reg_5 = 32'b00000000000000000000000010100010;
reg [32-1:0] bias_reg_6 = 32'b00000000000000000000000001111010;
reg [32-1:0] bias_reg_7 = 32'b11111111111111111111101001100011;
reg [32-1:0] bias_reg_8 = 32'b00000000000000000000001010110110;
reg [32-1:0] bias_reg_9 = 32'b00000000000000000000001010010101;
reg [32-1:0] bias_reg_10 = 32'b00000000000000000000000100011111;
reg [32-1:0] bias_reg_11 = 32'b00000000000000000000001000000110;
reg [32-1:0] bias_reg_12 = 32'b00000000000000000000001010100001;
reg [32-1:0] bias_reg_13 = 32'b00000000000000000000000101011100;
reg [32-1:0] bias_reg_14 = 32'b00000000000000000000001011000000;
reg [32-1:0] bias_reg_15 = 32'b00000000000000000000000110100000;
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
endmodule
