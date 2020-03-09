module fire8_squeeze #(
	parameter WOUT = 8,
	parameter DSP_NO = 112 ,
	parameter W_IN = 16 ,
	parameter WIDTH = 16 ,
	parameter CHIN = 384,
	parameter KERNEL_DIM = 3  
)
(
	input clk,
	//input rst,
	input fire8_squeeze_en,
	input [WIDTH-1:0] kernels [0:DSP_NO-1] ,
	input [WIDTH-1:0] ifm,
	input ram_feedback,
	output reg fire8_squeeze_sample,
	output rom_clr_pulse_o ,
	output fire8_squeeze_finish ,
	output reg [WIDTH-1:0] ofm [0:DSP_NO-1]
);
reg fire8_squeeze_end;
wire [2*WIDTH-1:0] biasing_wire [0:DSP_NO-1] ;
biasing_fire8_squeeze b7 (
	.bias_mem(biasing_wire)
);
///////////////////////////////////
//KERNELS INSTANTIATION////////////
///////////////////////////////////
//this signal is very important to track
///////////////////////////////////
reg clr_pulse ;
reg rom_clr_pulse;
always @(posedge clk) clr_pulse <= rom_clr_pulse ;
initial begin
		rom_clr_pulse = 1'b0 ;
		ram_feedback_reg= 1'b0 ; 
		fire8_squeeze_timer= 0 ;
		fire8_squeeze_end = 1'b0 ;
		clr_counter = 0 ;
end
////////////////////////////
//GENERATION OF CLR PULSE///
////////////////////////////
reg [$clog2(KERNEL_DIM**2*CHIN):0] clr_counter ;
always @(posedge clk/* or posedge rst*/) begin
	/*if(rst) begin
		rom_clr_pulse <= 1'b0 ;
		clr_counter <= 0 ;
	end
	else*/ if (!fire8_squeeze_end && fire8_squeeze_en) begin
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
reg layer_en_reg ;
always @(posedge clk) layer_en_reg <= fire8_squeeze_en ; 
genvar i ;
generate for (i = 0 ; i< DSP_NO ; i++) begin
	mac mac_i (
		.clr(clr_pulse),
		.clk(clk),
		//.rst(rst),
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
	if(clr_pulse) begin
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
reg [$clog2(WOUT**2):0] fire8_squeeze_timer ;
always @(posedge clk/* or posedge rst*/) begin
	/*if (rst) begin
		fire8_squeeze_timer<= 0 ;
		fire8_squeeze_end <= 1'b0 ;
	end
	else*/ if (fire8_squeeze_timer > WOUT**2)
		fire8_squeeze_end <= 1'b1 ;//LAYER HAS FINISHED
	else if (clr_pulse)
		fire8_squeeze_timer<= fire8_squeeze_timer+1 ;
end
always @(posedge clk) begin
	fire8_squeeze_sample <= clr_pulse ; 
end
(* dont_touch*)reg ram_feedback_reg ; 
always @(posedge clk/* or posedge rst*/) begin
	/*if (rst)
		ram_feedback_reg<= 1'b0 ; 
	else*/ if (ram_feedback)
		ram_feedback_reg<= 1'b1 ;
end
assign fire8_squeeze_finish= !ram_feedback_reg && fire8_squeeze_end ; 
assign rom_clr_pulse_o = rom_clr_pulse ; 

endmodule



