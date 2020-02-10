`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/07/2020 02:47:44 PM
// Design Name: 
// Module Name: fire2Squeeze3x3_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fire2Squeeze3x3_tb;
    parameter DSP_NO = 16;
	parameter STRIDE = 2 ;
	parameter W_IN = 128;
	parameter H_IN = 128 ;
	parameter WIDTH = 16 ;
	parameter CHIN = 64 ;
	parameter KERNEL_DIM = 3 ;
	parameter CHOUT = 16  ;
	parameter WINDOWS=CHIN*(((W_IN-1)/STRIDE)**2);
	parameter ITER = ((W_IN**2)*CHOUT)/DSP_NO ;//8*8
reg clk;
reg rst;
reg fire2_squeeze_3_en;
reg [15:0] ifm;
wire fire2_squeeze_3_end;
wire [15:0] ofm [0:DSP_NO-1];
reg  [15:0] reg_ofm [0:DSP_NO-1]; 
reg clr_pulse = fire2_squeeze_3.clr_pulse ; 
//
//
reg [15:0] python [0:2**22] ; 
initial begin
	$readmemb("in_fire2.txt",python) ; 
end
int addr ; 
reg [15:0] python_in ;
///////////////////////////
always @(posedge clk ) begin
	if (!rst || clr_pulse) begin
		python_in<= 0 ;
		addr <= 0 ; 
	end
	else begin
		addr<= addr +1 ;
		python_in<= python[addr] ; 
	end
end///////
fire2_squeeze_3 fire2_squeeze_3tb(.clk(clk),.rst(rst),.fire2_squeeze_3_en(fire2_squeeze_3_en),.ifm(python_in),.fire2_squeeze_3_end(fire2_squeeze_3_end),.ofm(ofm),.fire2_squeeze_3_sample(clr_pulse));
assign reg_ofm=ofm; 

always begin 
#5
clk= ~clk;
end

initial begin 
clk=0;
fire2_squeeze_3_en=1;
rst = 1 ;
#5 rst = 0 ; 
#20 rst=1;

end 



endmodule
