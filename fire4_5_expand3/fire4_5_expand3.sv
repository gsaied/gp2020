/* verilator lint_off COMBDLY */
/*
* FIRE4 && FIRE5 EXPAND 3*3   IMPLEMENTATION
* INPUT SIZE: 32*32*32
* OUTPUT SIZE: 32*32*128
* STRIDE: 1
* PAD:	0
* WINDOW: 3*3
*/
module fire4_5_expand_3 #(
	parameter WOUT = 32,
	parameter DSP_NO = 128,
	parameter W_IN = 32,
	parameter WIDTH = 16 ,
	parameter CHIN = 32 , 
	parameter KERNEL_DIM = 3 ,
	parameter CHOUT =128   
)
(
	input clk,
	input rst,
	input fire4_expand_3_en,
	input fire5_expand_3_en,
	input [15:0] ifm_2,
	input [15:0] ifm_3,
	input ram_feedback_4,
	input ram_feedback_5,
	output fire4_expand_3_finish,
	output fire5_expand_3_finish,
	output reg fire4_expand_3_sample,
	output reg [WIDTH-1:0] ofm_2 [0:DSP_NO-1],
	output reg [WIDTH-1:0] ofm_3 [0:DSP_NO-1]
);
	reg fire4_expand_3_end;
	reg fire5_expand_3_end;
reg [WIDTH-1:0] ifm ; //MUX OUT
reg [2*WIDTH-1:0] biasing_wire [0:DSP_NO-1] ;//MUX OUT
reg [WIDTH-1:0] kernels [0:DSP_NO-1] ; //MUX OUT
wire [2*WIDTH-1:0] biasing_wire_4 [0:DSP_NO-1] ;
biasing_fire4_expand3 b7 (
	.bias_mem(biasing_wire_4)
);
wire [2*WIDTH-1:0] biasing_wire_5 [0:DSP_NO-1] ;
biasing_fire5_expand3 b8 (
	.bias_mem(biasing_wire_5)
);
///////////////////////////////////
//KERNELS INSTANTIATION
///////////////////////////////////
wire [WIDTH-1:0] kernels_4 [0:DSP_NO-1] ; 
wire [WIDTH-1:0] kernels_5 [0:DSP_NO-1] ; 
reg [WIDTH-1:0] kernel_regs [0:DSP_NO-1] ; 
reg [$clog2(KERNEL_DIM**2*CHIN)-1:0] weight_rom_address ; 
//////////////////////////////////
wrapper_rom_fire4 u_2 (
	.address(weight_rom_address),
	.rom_out(kernels_4)
);
wrapper_rom_fire5  u_3 (
	.address(weight_rom_address),
	.rom_out(kernels_5)
);
reg layer_en_reg ;
always @(posedge clk) begin
    layer_en_reg <= fire4_expand_3_en || fire5_expand_3_en ; 
end 
///////////////////////////////////
//this signal is very important to track
//represents a pulse to clr pin of mac 
///////////////////////////////////
reg clr_pulse ; 
reg rom_clr_pulse;
///////
///////
always @(posedge clk or negedge rst) begin
	if(!rst)
		weight_rom_address<= 0 ; 
	else if (rom_clr_pulse)
		weight_rom_address<= 0;
	else if (fire4_expand_3_en || fire5_expand_3_en)begin
		weight_rom_address<= weight_rom_address+1;
	end
end
////////////////////////////
//ENABLE SIGNALS MULTIPLEX//
//ROM & INPUTS TO MAC///////
////////////////////////////
always @(*) begin
	if (fire4_expand_3_en) begin
		kernels <= kernels_4 ;
		biasing_wire <= biasing_wire_4 ; 	
		ifm<= ifm_2 ; 
	end
	else begin 
		kernels <= kernels_5 ;
		biasing_wire <= biasing_wire_5 ; 
		ifm<= ifm_3 ; 
	end
end
always @(posedge clk) begin
	kernel_regs<=kernels ;		
end
////////////////////////////
//GENERATION OF CLR PULSE///
////////////////////////////
reg [$clog2(KERNEL_DIM**2*CHIN):0] clr_counter ; 
always @(posedge clk or negedge rst) begin
	if(!rst) begin
		clr_pulse <= 1'b0 ; 
		rom_clr_pulse <= 1'b0 ; 
		clr_counter <= 0 ;
	end
	else if (!(fire4_expand_3_end && fire5_expand_3_end) && (fire5_expand_3_en || fire4_expand_3_en)) begin
		if(clr_counter == KERNEL_DIM**2*CHIN-1 ) begin
			rom_clr_pulse<= 1'b1 ; 
			clr_counter <= clr_counter+1 ;
		end
		else if(clr_counter == KERNEL_DIM**2*CHIN) begin
			clr_counter <= 0 ;
			clr_pulse<= 1'b1 ;
			rom_clr_pulse <= 1'b0 ; 
		end
		else begin
			clr_pulse <= 1'b0 ; 
			clr_counter <= clr_counter +1;
			rom_clr_pulse <= 1'b0 ; 
		end
	end
end
//////////////////////////////
//CORE GENERATION/////////////
//////////////////////////////
wire [2*WIDTH:0] ofmw [0:DSP_NO-1];
reg [2*WIDTH:0] ofmw2 [0:DSP_NO-1];
genvar i ; 
generate for (i = 0 ; i< CHOUT ; i++) begin
	mac mac_i (
		.clr(clr_pulse),
		.clk(clk),
		.rst(rst),
		.layer_en(layer_en_reg),
		.pix(ifm),
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
always@(posedge clk) begin
	if(clr_pulse && (fire4_expand_3_en || fire5_expand_3_en) && !(fire4_expand_3_end && fire5_expand_3_end)) begin
		for (int i = 0 ; i< DSP_NO ; i++) begin
			if(ofmw2[i][31] == 1'b1 ) begin 
				if (fire4_expand_3_en)
					ofm_2[i] <= 16'b0 ;
				else
					ofm_3[i] <= 16'b0 ;
			end
			else begin
				if (fire4_expand_3_en)
					ofm_2[i] <= {ofmw2[i][31],ofmw2[i][28:14]};
				else

					ofm_3[i] <= {ofmw2[i][31],ofmw2[i][28:14]};
			end
		end
	end
end
///////////////////////////////
//CHECK FOR LAYER END//////////
///////////////////////////////
reg [$clog2(WOUT**2):0] fire4_expand_3_timer ;
reg [$clog2(WOUT**2):0] fire5_expand_3_timer ;
always @(posedge clk or negedge rst) begin
	if (!rst) begin
		fire4_expand_3_timer<= 0 ;
		fire5_expand_3_timer<= 0 ;
		fire4_expand_3_end <= 1'b0 ; 
		fire5_expand_3_end <= 1'b0 ; 
	end
	else if (fire4_expand_3_en) begin
		if (fire4_expand_3_timer == WOUT**2)
			fire4_expand_3_end <= 1'b1 ;
		else if (clr_pulse)
			fire4_expand_3_timer<= fire4_expand_3_timer+1 ; 
		end
	else begin
		if (fire5_expand_3_timer == WOUT**2)
			fire5_expand_3_end <= 1'b1 ;
		else if (clr_pulse)
			fire5_expand_3_timer<= fire5_expand_3_timer+1 ; 
		end
end
always @(posedge clk) begin
	fire4_expand_3_sample <= clr_pulse ; 
end 
////////////////////////////////
//LAYER FINISH FLAG LOGIC///////
////////////////////////////////
reg ram_feedback_reg_4 ;
reg ram_feedback_reg_5 ;
always @(posedge clk or negedge rst) begin
	if(!rst) begin
		ram_feedback_reg_4<= 1'b0 ;
		ram_feedback_reg_5<= 1'b0 ;
	end
	else if (ram_feedback_4) 
		ram_feedback_reg_4<= 1'b1;
	else if (ram_feedback_5) 
		ram_feedback_reg_5<= 1'b1;
end
assign fire4_expand_3_finish = fire4_expand_3_end && !ram_feedback_reg_4 ;
assign fire5_expand_3_finish = fire5_expand_3_end && !ram_feedback_reg_5 ;
endmodule

