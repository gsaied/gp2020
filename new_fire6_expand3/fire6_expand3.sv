/* verilator lint_off COMBDLY */
module fire6_expand3 #(
	parameter WOUT_FIRE6_EXPAND3 = 16,
	parameter DSP_NO_FIRE6_EXPAND3 = 256,
	parameter WIDTH = 16 ,
	parameter CHIN_FIRE6_EXPAND3 = 64,
	parameter KERNEL_DIM_FIRE6_EXPAND3 = 3  
)
(
	input clk,
//	input rst,
	input fire6_expand3_en_i,
	input [WIDTH-1:0] ifm_i,
	input ram_feedback,
	output reg fire6_expand3_sample,
	output fire6_expand3_finish ,
	output reg [WIDTH-1:0] ofm [0:DSP_NO_FIRE6_EXPAND3-1]
);
reg fire6_expand3_end;
wire [2*WIDTH-1:0] biasing_wire [0:DSP_NO_FIRE6_EXPAND3-1] ;
biasing_fire6_expand3 b7 (
	.bias_mem(biasing_wire)
);
reg [WIDTH-1:0] ifm ;
reg [WIDTH-1:0] temp_ifm ;
reg [WIDTH-1:0] temp2_ifm ;
reg fire6_expand3_en;
always @(posedge clk) begin
	temp_ifm <= ifm_i ;
	temp2_ifm <= temp_ifm ; 
	ifm<= temp2_ifm ; 
	fire6_expand3_en<= fire6_expand3_en_i ; 
end
///////////////////////////////////
//KERNELS INSTANTIATION
///////////////////////////////////
reg [$clog2(KERNEL_DIM_FIRE6_EXPAND3**2*CHIN_FIRE6_EXPAND3)-1:0] weight_rom_address ;
reg [WIDTH-1:0] kernel_mux [0:DSP_NO_FIRE6_EXPAND3-1] ;
wire [WIDTH-1:0] kernels_bram_wire [0:DSP_NO_FIRE6_EXPAND3-1] ;
reg [WIDTH-1:0] kernels_bram [0:DSP_NO_FIRE6_EXPAND3-1] ;
wire [WIDTH-1:0] kernels_lut [0:DSP_NO_FIRE6_EXPAND3-1] ;
reg [WIDTH-1:0] kernels_lut_reg [0:DSP_NO_FIRE6_EXPAND3-1] ;
reg [WIDTH-1:0] kernel_final_reg [0:DSP_NO_FIRE6_EXPAND3-1] ;
//////////////////////////////////
//(* dont_touch ="true"*)
(* keep_hierarchy = "yes" *)rom_fire6_expand3 u_2 (
	.address(weight_rom_address[9:0]),
	.clk(clk),
	.rom_out(kernels_bram)
);
//(* dont_touch ="true"*)
(* keep_hierarchy = "yes" *)rom2_fire6_expand3 u_3 (
	.address(weight_rom_address[5:0]),
	.rom_out(kernels_lut)
);
always @(posedge clk) begin
		kernels_lut_reg<=kernels_lut ;
		kernel_final_reg<=kernel_mux;
end
always @(*) begin
	if (weight_rom_address > 512)
		kernel_mux <= kernels_lut_reg ;
	else
		kernel_mux <= kernels_bram ;
end
///////////////////////////////////
//this signal is very important to track
///////////////////////////////////
reg clr_pulse ;
reg temp_clr_pulse ;
reg rom_clr_pulse;
always@(posedge clk) begin
	temp_clr_pulse<= rom_clr_pulse;
	clr_pulse <= temp_clr_pulse ; 
end
///////
///////
always @(posedge clk /*or negedge rst*/) begin
	/*if(!rst)
		weight_rom_address<= 0 ;
	else*/ if (rom_clr_pulse)
		weight_rom_address<= 0;
	else if (fire6_expand3_en) begin
		weight_rom_address<= weight_rom_address+1;
	end
end
reg layer_en_reg ;
always @(posedge clk) begin
    layer_en_reg <= fire6_expand3_en  ; 
end 
////////////////////////////
//GENERATION OF CLR PULSE///
////////////////////////////
reg [$clog2(KERNEL_DIM_FIRE6_EXPAND3**2*CHIN_FIRE6_EXPAND3):0] clr_counter ;
always @(posedge clk/* or negedge rst*/) begin
	/*if(!rst) begin
		rom_clr_pulse <= 1'b0 ;
		clr_counter <= 0 ;
	end
	else */if (fire6_expand3_en) begin
		if(clr_counter == KERNEL_DIM_FIRE6_EXPAND3**2*CHIN_FIRE6_EXPAND3-1 ) begin
			rom_clr_pulse<= 1'b1 ;
			clr_counter <= clr_counter+1 ;
		end
		else if(clr_counter == KERNEL_DIM_FIRE6_EXPAND3**2*CHIN_FIRE6_EXPAND3) begin
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
wire [2*WIDTH-1:0] ofmw [0:DSP_NO_FIRE6_EXPAND3-1];
reg [2*WIDTH-1:0] ofmw2 [0:DSP_NO_FIRE6_EXPAND3-1];
genvar i ;
generate for (i = 0 ; i< DSP_NO_FIRE6_EXPAND3 ; i++) begin
	mac mac_i (
		.clr(clr_pulse),
		.clk(clk),
	//	.rst(rst),
		.pix(ifm),
		.layer_en(layer_en_reg),
		.mul_out(ofmw[i]),
		.ker(kernel_final_reg[i])
	);
end
endgenerate
/////////////////////////////////
//OUTPUT IS READY TO BE SAMPLED//
/////////////////////////////////
always @(*) begin
	for (int i = 0 ; i < DSP_NO_FIRE6_EXPAND3 ; i++) begin
		ofmw2[i]  = ofmw[i] + biasing_wire[i]  ;
	end
end
always@(posedge clk) begin
	if(clr_pulse) begin
		for (int i = 0 ; i< DSP_NO_FIRE6_EXPAND3 ; i++) begin
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
reg [$clog2(WOUT_FIRE6_EXPAND3**2):0] fire6_expand3_timer ;
always @(posedge clk/* or negedge rst*/) begin
	/*if (!rst) begin
		fire6_expand3_timer<= 0 ;
		fire6_expand3_end <= 1'b0 ;
	end
	else */if (fire6_expand3_timer > WOUT_FIRE6_EXPAND3**2-1)
		fire6_expand3_end <= 1'b1 ;//LAYER HAS FINISHED
	else if (clr_pulse)
		fire6_expand3_timer<= fire6_expand3_timer+1 ;
end
always @(posedge clk) begin
	fire6_expand3_sample <= clr_pulse ; 
end
(*dont_touch="yes"*)reg ram_feedback_reg ; 
always @(posedge clk/* or negedge rst*/) begin
	/*if (!rst)
		ram_feedback_reg<= 1'b0 ; 
	else */if (ram_feedback)
		ram_feedback_reg<= 1'b1 ;
end
assign fire6_expand3_finish= !ram_feedback_reg && fire6_expand3_end ; 
initial begin
weight_rom_address=0;
ram_feedback_reg=1'b0;
rom_clr_pulse=1'b0;
clr_counter=0;
fire6_expand3_timer=0;
fire6_expand3_end=1'b0;
end
endmodule



