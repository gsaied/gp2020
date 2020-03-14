
module fire6_expand1 #(
	parameter WOUT = 16,
	parameter DSP_NO = 256 ,
	parameter W_IN = 16 ,
	parameter WIDTH = 16 ,
	parameter CHIN = 64,
	parameter KERNEL_DIM = 1  
)
(
	input clk,
	//input rst,
	input fire6_expand1_en_i,
	input [WIDTH-1:0] ifm_i,
	input ram_feedback,
	output reg fire6_expand1_sample,
	output fire6_expand1_finish ,
	output reg [WIDTH-1:0] ofm [0:DSP_NO-1]
);
reg fire6_expand1_end;
reg fire6_expand1_en;
reg [WIDTH-1:0] ifm ; 
always @(posedge clk) begin
	fire6_expand1_en <= fire6_expand1_en_i ;
	ifm<= ifm_i ; 
end
reg [$clog2(WOUT**2):0] fire6_expand1_timer ;
(*dont_touch="yes"*)reg ram_feedback_reg ; 
wire [2*WIDTH-1:0] biasing_wire [0:DSP_NO-1] ;
biasing_fire6_expand1 b7 (
	.bias_mem(biasing_wire)
);
///////////////////////////////////
//KERNELS INSTANTIATION
///////////////////////////////////
wire [WIDTH-1:0] kernels [0:DSP_NO-1] ;
reg [WIDTH-1:0] kernel_regs [0:DSP_NO-1] ;
reg [$clog2(KERNEL_DIM**2*CHIN)-1:0] weight_rom_address ;
//////////////////////////////////
rom_fire6_expand1 u_2 (
	.address(weight_rom_address),
	.rom_out(kernels)
);
///////////////////////////////////
//this signal is very important to track
///////////////////////////////////
reg clr_pulse ;
reg rom_clr_pulse;
always@(posedge clk) clr_pulse<= rom_clr_pulse;
///////
///////
always @(posedge clk /*or negedge rst*/) begin
	/*if(!rst)
		weight_rom_address<= 0 ;
	else */if (rom_clr_pulse)
		weight_rom_address<= 0;
	else if (fire6_expand1_en) begin
		weight_rom_address<= weight_rom_address+1;
	end
end
always @(posedge clk) begin
	if(fire6_expand1_en) 
		kernel_regs<=kernels ;
end
reg layer_en_reg ;
always @(posedge clk) begin
    layer_en_reg <= fire6_expand1_en  ; 
end 
////////////////////////////
//GENERATION OF CLR PULSE///
////////////////////////////
reg [$clog2(KERNEL_DIM**2*CHIN):0] clr_counter ;
always @(posedge clk /*or negedge rst*/) begin
	/*if(!rst) begin
	
		rom_clr_pulse <= 1'b0 ;
		clr_counter <= 0 ;
	end
	else */if (!fire6_expand1_end && fire6_expand1_en) begin
		if(clr_counter == KERNEL_DIM**2*CHIN-1) begin
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
		//.rst(rst),
		.pix(ifm),
		.layer_en(layer_en_reg),
		.mul_out(ofmw[i]),
		.ker(kernel_regs[i])
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
initial begin
weight_rom_address=0;
rom_clr_pulse=1'b0;
ram_feedback_reg=1'b0;
clr_counter=0;
fire6_expand1_timer=0;
fire6_expand1_end=1'b0;
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
always @(posedge clk /*or negedge rst*/) begin
	/*if (!rst) begin
		fire6_expand1_timer<= 0 ;
		fire6_expand1_end <= 1'b0 ;
	end
	else */if (fire6_expand1_timer > WOUT**2-1)
		fire6_expand1_end <= 1'b1 ;//LAYER HAS FINISHED
	else if (clr_pulse)
		fire6_expand1_timer<= fire6_expand1_timer+1 ;
end
always @(posedge clk) begin
	fire6_expand1_sample <= clr_pulse ; 
end
always @(posedge clk /*or negedge rst*/) begin
	/*if (!rst)
		ram_feedback_reg<= 1'b0 ; 
	else*/ if (ram_feedback)
		ram_feedback_reg<= 1'b1 ;
end
assign fire6_expand1_finish= !ram_feedback_reg && fire6_expand1_end ; 
endmodule



