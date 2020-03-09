/* verilator lint_off INITIALDLY */
module fire9Squeeze #(
	parameter WOUT = 8,
	parameter DSP_NO = 112 ,
	parameter W_IN = 8 ,
	parameter WIDTH = 16 ,
	parameter CHIN = 512,
	parameter KERNEL_DIM = 1  
)
(
	input clk,
	input fire9Squeeze_en,
	output rom_clr_pulse_o ,
	input [WIDTH-1:0] ifm,
	input [WIDTH-1:0] kernels [0:DSP_NO-1] ,
	input ram_feedback,
	output reg fire9Squeeze_sample,
	output fire9Squeeze_finish ,
	output reg [WIDTH-1:0] ofm [0:DSP_NO-1]
);
reg fire9Squeeze_end;
wire [2*WIDTH-1:0] biasing_wire [0:DSP_NO-1] ;
biasing_fire9Squeeze b7 (
	.bias_mem(biasing_wire)
);
///////////////////////////////////
//KERNELS INSTANTIATION
///////////////////////////////////
//this signal is very important to track
///////////////////////////////////
reg clr_pulse ;
reg rom_clr_pulse;
initial begin
	ram_feedback_reg<=1'b0 ;
	rom_clr_pulse <= 1'b0 ;
	clr_counter <= 0 ;
	fire9Squeeze_timer<= 0 ;
	fire9Squeeze_end <= 1'b0 ;
end
always @(posedge clk) clr_pulse <= rom_clr_pulse ; 
///////
///////
reg layer_en_reg ;
always @(posedge clk) begin
    layer_en_reg <= fire9Squeeze_en  ; 
end 
////////////////////////////
//GENERATION OF CLR PULSE///
////////////////////////////
reg [$clog2(KERNEL_DIM**2*CHIN):0] clr_counter ;
always @(posedge clk) begin
	if (!fire9Squeeze_end && fire9Squeeze_en) begin
		if(clr_counter == KERNEL_DIM**2*CHIN-1 ) begin
			rom_clr_pulse<= 1'b1 ;
			clr_counter <= clr_counter+1 ;
		end
		else if(clr_counter == KERNEL_DIM**2*CHIN) begin
			clr_counter <= 0 ;
			rom_clr_pulse <= 1'b0 ;
		end
		else begin
			clr_counter <= clr_counter +1;
			rom_clr_pulse <= 1'b0 ;
		end
	end
end
//////////////////////////////
//CORE GENERATION/////////////
//////////////////////////////
wire [2*WIDTH-1:0] ofmw [0:DSP_NO-1];
reg [2*WIDTH-1:0] ofmw2 [0:DSP_NO-1];
genvar i ;
generate for (i = 0 ; i< DSP_NO ; i++) begin
	mac mac_i (
		.clr(clr_pulse),
		.clk(clk),
		.pix(ifm),
		.layer_en(layer_en_reg),
		.mul_out(ofmw[i]),
		.ker(kernels[i])
	);
end
endgenerate
/////////////////////////////////
//OUTPUT IS READY TO BE SAMPLED//
/////////////////////////////////
always @(*) begin
	for (int i = 0 ; i < DSP_NO ; i++) begin
		ofmw2[i]  = ofmw[i] + biasing_wire[i]  ;
	end
end
always@(posedge clk) begin
	if(clr_pulse && fire9Squeeze_en && !fire9Squeeze_end) begin
		for (int i = 0 ; i< DSP_NO ; i++) begin
			if(ofmw2[i][31] == 1'b1 )
				ofm[i] <= 16'b0 ;
			else
				ofm[i] <= {ofmw2[i][31],ofmw2[i][28:14]};
		end
	end
end
///////////////////////////////
//CHECK FOR LAYER END//////////
///////////////////////////////
reg [$clog2(WOUT**2):0] fire9Squeeze_timer ;
always @(posedge clk) begin
	if (fire9Squeeze_timer > WOUT**2)
		fire9Squeeze_end <= 1'b1 ;//LAYER HAS FINISHED
	else if (clr_pulse)
		fire9Squeeze_timer<= fire9Squeeze_timer+1 ;
end
always @(posedge clk) begin
	fire9Squeeze_sample <= clr_pulse ; 
end
(* dont_touch = "true" *)reg ram_feedback_reg ; 
always @(posedge clk) begin
	 if (ram_feedback) 
		ram_feedback_reg<= 1'b1 ;
end
assign fire9Squeeze_finish= !ram_feedback_reg && fire9Squeeze_end ; 
assign rom_clr_pulse_o = rom_clr_pulse ; 
endmodule


