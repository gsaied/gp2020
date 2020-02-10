
module biasing_rom (
	output [31:0] bias_mem [0:16-1]
);

reg [32-1:0] bias_reg_0 = 32'b00000000000000000000000000000000;
reg [32-1:0] bias_reg_1 = 32'b00000000000000000000001101001101;
reg [32-1:0] bias_reg_2 = 32'b00000000000000000000011100100100;
reg [32-1:0] bias_reg_3 = 32'b11111111111111111111111000100000;
reg [32-1:0] bias_reg_4 = 32'b00000000000000000000011000110001;
reg [32-1:0] bias_reg_5 = 32'b11111111111111111111111111111111;
reg [32-1:0] bias_reg_6 = 32'b00000000000000000000000000000000;
reg [32-1:0] bias_reg_7 = 32'b11111111111111111111111111111111;
reg [32-1:0] bias_reg_8 = 32'b00000000000000000000000000000000;
reg [32-1:0] bias_reg_9 = 32'b11111111111111111111111110001000;
reg [32-1:0] bias_reg_10 = 32'b00000000000000000000000111010000;
reg [32-1:0] bias_reg_11 = 32'b00000000000000000000000000000000;
reg [32-1:0] bias_reg_12 = 32'b00000000000000000000001111011011;
reg [32-1:0] bias_reg_13 = 32'b00000000000000000000100001010011;
reg [32-1:0] bias_reg_14 = 32'b00000000000000000000010110011100;
reg [32-1:0] bias_reg_15 = 32'b11111111111111111111111111111111;
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
