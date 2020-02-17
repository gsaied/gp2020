/* verilator lint_off COMBDLY */
/*
* FIRE3 && FIRE2 EXPAND 1*1   IMPLEMENTATION
* INPUT SIZE: 64*64*16
* OUTPUT SIZE: 64*64*64
* STRIDE: 1
* PAD:	0
* WINDOW: 1*1
*/
module fire2_3_expand_1 #(
	parameter WOUT = 64,
	parameter DSP_NO = 64,
	parameter W_IN = 64,
	parameter WIDTH = 16 ,
	parameter CHIN = 16 , 
	parameter KERNEL_DIM = 1 ,
	parameter CHOUT = 64   
)
(
	input clk,
	input rst,
	input fire2_expand_1_en,
	input fire3_expand_1_en,
	input [15:0] ifm_2,
	input [15:0] ifm_3,
	input ram_feedback,
	output fire2_expand_1_finish,
	output fire3_expand_1_finish,
	output reg fire2_expand_1_sample,
	output reg [WIDTH-1:0] ofm_2 [0:DSP_NO-1],
	output reg [WIDTH-1:0] ofm_3 [0:DSP_NO-1]
);
	reg fire2_expand_1_end;
	reg fire3_expand_1_end;
reg [WIDTH-1:0] ifm ; //MUX OUT
reg [2*WIDTH-1:0] biasing_wire [0:DSP_NO-1] ;//MUX OUT
reg [WIDTH-1:0] kernels [0:DSP_NO-1] ; //MUX OUT
wire [2*WIDTH-1:0] biasing_wire_2 [0:DSP_NO-1] ;
biasing_2 b7 (
	.bias_mem(biasing_wire_2)
);
wire [2*WIDTH-1:0] biasing_wire_3 [0:DSP_NO-1] ;
biasing_3 b8 (
	.bias_mem(biasing_wire_3)
);
///////////////////////////////////
//KERNELS INSTANTIATION
///////////////////////////////////
wire [WIDTH-1:0] kernels_2 [0:DSP_NO-1] ; 
wire [WIDTH-1:0] kernels_3 [0:DSP_NO-1] ; 
reg [WIDTH-1:0] kernel_regs [0:DSP_NO-1] ; 
reg [$clog2(KERNEL_DIM**2*CHIN)-1:0] weight_rom_address ; 
//////////////////////////////////
rom_2 u_2 (
	.address(weight_rom_address),
	.rom_out(kernels_2)
);
rom_3 u_3 (
	.address(weight_rom_address),
	.rom_out(kernels_3)
);
reg layer_en_reg ;
always @(posedge clk) begin
    layer_en_reg <= fire2_expand_1_en || fire3_expand_1_en ; 
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
	else if (fire2_expand_1_en || fire3_expand_1_en)begin
		weight_rom_address<= weight_rom_address+1;
	end
end
////////////////////////////
//ENABLE SIGNALS MULTIPLEX//
//ROM & INPUTS TO MAC///////
////////////////////////////
always @(*) begin
	if (fire2_expand_1_en) begin
		kernels <= kernels_2 ;
		biasing_wire <= biasing_wire_2 ; 	
		ifm<= ifm_2 ; 
	end
	else begin 
		kernels <= kernels_3 ;
		biasing_wire <= biasing_wire_3 ; 
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
	else if (!(fire2_expand_1_end && fire3_expand_1_end) && (fire3_expand_1_en || fire2_expand_1_en)) begin
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
	if(clr_pulse && (fire2_expand_1_en || fire3_expand_1_en) && !(fire2_expand_1_end && fire3_expand_1_end)) begin
		for (int i = 0 ; i< DSP_NO ; i++) begin
			if(ofmw2[i][31] == 1'b1 ) begin 
				if (fire2_expand_1_en)
					ofm_2[i] <= 16'b0 ;
				else
					ofm_3[i] <= 16'b0 ;
			end
			else begin
				if (fire2_expand_1_en)
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
reg [$clog2(WOUT**2):0] fire2_expand_1_timer ;
reg [$clog2(WOUT**2):0] fire3_expand_1_timer ;
always @(posedge clk or negedge rst) begin
	if (!rst) begin
		fire2_expand_1_timer<= 0 ;
		fire3_expand_1_timer<= 0 ;
		fire2_expand_1_end <= 1'b0 ; 
		fire3_expand_1_end <= 1'b0 ; 
	end
	else if (fire2_expand_1_en) begin
		if (fire2_expand_1_timer == WOUT**2)
			fire2_expand_1_end <= 1'b1 ;
		else if (clr_pulse)
			fire2_expand_1_timer<= fire2_expand_1_timer+1 ; 
		end
	else begin
		if (fire3_expand_1_timer == WOUT**2)
			fire3_expand_1_end <= 1'b1 ;
		else if (clr_pulse)
			fire3_expand_1_timer<= fire3_expand_1_timer+1 ; 
		end
end
always @(posedge clk) begin
	fire2_expand_1_sample <= clr_pulse ; 
end 
assign fire2_expand_1_finish = fire2_expand_1_end && !ram_feedback ;
assign fire3_expand_1_finish = fire2_expand_1_end && !ram_feedback ;
endmodule

