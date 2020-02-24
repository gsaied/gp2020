module top_squeeze_2 
#(
	parameter WOUT = 64,
	parameter DSP_NO = 16 ,
	parameter W_IN = 128 ,
	parameter WIDTH = 16 ,
	parameter CHIN = 64,
	parameter KERNEL_DIM = 3  
)
(
	input clk,
	input rst,
	input fire2_squeeze_en,
	input [WIDTH-1:0] ifm,
	input ram_feedback,
	output reg fire2_squeeze_sample,
	output fire2_squeeze_finish  
);
reg [WIDTH-1:0] top_ofm [0:DSP_NO-1] ;
fire2_squeeze ug (
	.clk(clk),
	.rst(rst),
	.fire2_squeeze_en(fire2_squeeze_en),
	.ram_feedback(ram_feedback),
	.fire2_squeeze_sample(fire2_squeeze_sample),
	.ifm(ifm),
	.fire2_squeeze_finish(fire2_squeeze_finish),
	.ofm(top_ofm)
);
endmodule
