/* verilator lint_off COMBDLY */
/* verilator lint_off INITIALDLY*/
/*
* FIRE4 && FIRE5 EXPAND 3*3   IMPLEMENTATION
* INPUT SIZE: 32*32*32
* OUTPUT SIZE: 32*32*128
* STRIDE: 1
* PAD:	0
* WINDOW: 3*3
*/
module fire4_5_expand_3 #(
	parameter WOUT_FIRE4_5_EXPAND3 = 32,
	parameter WIDTH = 16 ,
	parameter CHIN_FIRE4_5_EXPAND3 = 32 , 
	parameter KERNEL_DIM_FIRE4_5_EXPAND3 = 3 ,
	parameter DSP_NO_FIRE4_5_EXPAND3 =128   
)
(
	input clk,
	//input rst,
	input fire4_expand_3_en_i,
	input fire5_expand_3_en_i,
	input [15:0] ifm_4_i,
	input [15:0] ifm_5_i,
	input ram_feedback_4,
	input ram_feedback_5,
	output fire4_expand_3_finish,
	output fire5_expand_3_finish,
	output reg fire4_expand_3_sample,
	output reg [WIDTH-1:0] ofm_5 [0:DSP_NO_FIRE4_5_EXPAND3-1]
);
	reg fire4_expand_3_end;
	reg fire5_expand_3_end;
	wire rst_gen ; 
reg [WIDTH-1:0] ifm ; //MUX OUT
reg [2*WIDTH-1:0] biasing_wire [0:DSP_NO_FIRE4_5_EXPAND3-1] ;//MUX OUT
reg [WIDTH-1:0] kernels [0:DSP_NO_FIRE4_5_EXPAND3-1] ; //MUX OUT
wire [2*WIDTH-1:0] biasing_wire_4 [0:DSP_NO_FIRE4_5_EXPAND3-1] ;
biasing_fire4_expand3 b7 (
	.bias_mem(biasing_wire_4)
);
wire [2*WIDTH-1:0] biasing_wire_5 [0:DSP_NO_FIRE4_5_EXPAND3-1] ;
biasing_fire5_expand3 b8 (
	.bias_mem(biasing_wire_5)
);
///////////////////////////////////
//KERNELS INSTANTIATION
///////////////////////////////////
wire [WIDTH-1:0] kernels_4 [0:DSP_NO_FIRE4_5_EXPAND3-1] ; 
wire [WIDTH-1:0] kernels_5 [0:DSP_NO_FIRE4_5_EXPAND3-1] ; 
reg [WIDTH-1:0] kernel_regs [0:DSP_NO_FIRE4_5_EXPAND3-1] ; 
reg [$clog2(KERNEL_DIM_FIRE4_5_EXPAND3**2*CHIN_FIRE4_5_EXPAND3)-1:0] weight_rom_address ; 
//////////////////////////////////
wrapper_rom_fire4 u_2 (
	.address(weight_rom_address),
	.rom_out(kernels_4)
);
wrapper_rom_fire5  u_3 (
	.address(weight_rom_address),
	.rom_out(kernels_5)
);
	reg fire4_expand_3_en ; 
	reg fire5_expand_3_en ; 
	reg [WIDTH-1:0] ifm_4 ;
	reg [WIDTH-1:0] ifm_5 ;
	reg [WIDTH-1:0] tempifm4;
	reg [WIDTH-1:0] tempifm5;
always @(posedge clk) begin
    tempifm4<=ifm_4_i;
    tempifm5<=ifm_5_i;
	fire4_expand_3_en <= fire4_expand_3_en_i ;
	fire5_expand_3_en <= fire5_expand_3_en_i ;
	ifm_4<= tempifm4 ; 
	ifm_5<= tempifm5 ; 
end
(* dont_touch = "true"*) reg layer_en_reg ;
reg entemp;
always @(posedge clk) begin
    entemp<=fire4_expand_3_en || fire5_expand_3_en;
    layer_en_reg <= entemp ; 
end 
///////////////////////////////////
//this signal is very important to track
//represents a pulse to clr pin of mac 
///////////////////////////////////
reg clr_pulse ; 
reg rom_clr_pulse;
reg temp_clr_pulse ;
///////
always@(posedge clk)begin
	if (rst_gen)
		clr_pulse<=0;
	else begin
	temp_clr_pulse <= rom_clr_pulse ;
    clr_pulse<= temp_clr_pulse;
	end
end
///////
always @(posedge clk /*or negedge rst*/) begin
	/*if(!rst)
		weight_rom_address<= 0 ; 
	else*/ if (rom_clr_pulse || rst_gen)
		weight_rom_address<= 0;
	else if (fire4_expand_3_en || fire5_expand_3_en)begin
		weight_rom_address<= weight_rom_address+1;
	end
end
assign rst_gen = fire4_expand_3_end && fire4_expand_3_en ;
////////////////////////////
//ENABLE SIGNALS MULTIPLEX//
//ROM & INPUTS TO MAC///////
////////////////////////////
always @(posedge clk) begin
	if (fire4_expand_3_en) begin
		kernels <= kernels_4 ;
		biasing_wire <= biasing_wire_4 ; 	
		ifm<= ifm_4 ; 
	end
	else begin 
		kernels <= kernels_5 ;
		biasing_wire <= biasing_wire_5 ; 
		ifm<= ifm_5 ; 
	end
end
always @(posedge clk) begin
	kernel_regs<=kernels ;		
end
////////////////////////////
//GENERATION OF CLR PULSE///
////////////////////////////
reg [$clog2(KERNEL_DIM_FIRE4_5_EXPAND3**2*CHIN_FIRE4_5_EXPAND3):0] clr_counter ; 
always @(posedge clk/* or negedge rst*/) begin
	/*if(!rst) begin
		clr_pulse <= 1'b0 ; 
		rom_clr_pulse <= 1'b0 ; 
		clr_counter <= 0 ;
	end
	else*/ if (!(fire4_expand_3_end && fire5_expand_3_end) && (fire5_expand_3_en || fire4_expand_3_en) && !rst_gen) begin
		if(clr_counter == KERNEL_DIM_FIRE4_5_EXPAND3**2*CHIN_FIRE4_5_EXPAND3-1 ) begin
			rom_clr_pulse<= 1'b1 ; 
			clr_counter <= clr_counter+1 ;
		end
		else if(clr_counter == KERNEL_DIM_FIRE4_5_EXPAND3**2*CHIN_FIRE4_5_EXPAND3) begin
			clr_counter <= 0 ;
		
			rom_clr_pulse <= 1'b0 ; 
		end
		else begin
			 
			clr_counter <= clr_counter +1;
			rom_clr_pulse <= 1'b0 ; 
		end
	end
	else if (rst_gen) begin
		rom_clr_pulse <= 1'b0 ; 
		clr_counter <= 0 ;
	end
end
//////////////////////////////
//CORE GENERATION/////////////
//////////////////////////////
wire [2*WIDTH-1:0] ofmw [0:DSP_NO_FIRE4_5_EXPAND3-1];
reg [2*WIDTH-1:0] ofmw2 [0:DSP_NO_FIRE4_5_EXPAND3-1];
genvar i ; 
generate for (i = 0 ; i< DSP_NO_FIRE4_5_EXPAND3 ; i++) begin
	mac mac_i (
		.clr(clr_pulse || rst_gen),
		.clk(clk),
	//	.rst(rst),
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
	for (int i = 0 ; i < DSP_NO_FIRE4_5_EXPAND3 ; i++) begin
		ofmw2[i]  = ofmw[i] + biasing_wire[i]  ;
	end
end
always@(posedge clk) begin
	if(clr_pulse ) begin
		for (int i = 0 ; i< DSP_NO_FIRE4_5_EXPAND3 ; i++) begin
			if(ofmw2[i][31] == 1'b1 ) begin 
				ofm_5[i] <= 16'b0 ;
			end
			else begin
				ofm_5[i] <= {ofmw2[i][31],ofmw2[i][28:14]};
			end
		end
	end
end
///////////////////////////////
//CHECK FOR LAYER END//////////
///////////////////////////////
reg [$clog2(WOUT_FIRE4_5_EXPAND3**2):0] fire4_expand_3_timer ;
reg [$clog2(WOUT_FIRE4_5_EXPAND3**2):0] fire5_expand_3_timer ;
always @(posedge clk/* or negedge rst*/) begin
	/*if (!rst) begin
		fire4_expand_3_timer<= 0 ;
		fire5_expand_3_timer<= 0 ;
		fire4_expand_3_end <= 1'b0 ; 
		fire5_expand_3_end <= 1'b0 ; 
	end
	else*/ if (fire4_expand_3_en) begin
		if (fire4_expand_3_timer > WOUT_FIRE4_5_EXPAND3**2-1)
			fire4_expand_3_end <= 1'b1 ;
		else if (clr_pulse)
			fire4_expand_3_timer<= fire4_expand_3_timer+1 ; 
		end
	else begin
		if (fire5_expand_3_timer > WOUT_FIRE4_5_EXPAND3**2-1)
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
(*dont_touch="yes"*)reg ram_feedback_reg_4 ;
(*dont_touch="yes"*)reg ram_feedback_reg_5 ;
always @(posedge clk/* or negedge rst*/) begin
	/*if(!rst) begin
		ram_feedback_reg_4<= 1'b0 ;
		ram_feedback_reg_5<= 1'b0 ;
	end
	else*/ if (ram_feedback_4) 
		ram_feedback_reg_4<= 1'b1;
	else if (ram_feedback_5) 
		ram_feedback_reg_5<= 1'b1;
end
assign fire4_expand_3_finish = fire4_expand_3_end && !ram_feedback_reg_4 ;
assign fire5_expand_3_finish = fire5_expand_3_end && !ram_feedback_reg_5 ;
initial begin
weight_rom_address=0;
rom_clr_pulse=1'b0;
clr_counter=0;
ram_feedback_reg_4=1'b0;
ram_feedback_reg_5=1'b0;
fire4_expand_3_timer=0;
fire5_expand_3_timer=0;
fire4_expand_3_end=1'b0;
fire5_expand_3_end=1'b0;
end
endmodule

