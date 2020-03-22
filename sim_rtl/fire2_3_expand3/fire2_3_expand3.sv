/* verilator lint_off COMBDLY */
/*
* FIRE3 && FIRE2 EXPAND 3*3   IMPLEMENTATION
* INPUT SIZE: 64*64*16
* OUTPUT SIZE: 64*64*64
* STRIDE: 1
* PAD:	1
* WINDOW: 3*3
*/
module fire2_3_expand_3 #(
	parameter WOUT_FIRE2_3_EXPAND3 = 64,
	parameter DSP_NO_FIRE2_3_EXPAND3 = 64,
	parameter WIDTH = 16 ,
	parameter CHIN_FIRE2_3_EXPAND3 = 16 , 
	parameter KERNEL_DIM_FIRE2_3_EXPAND3 = 3  
)
(
	input clk,
//	input rst,
	input fire2_expand_3_en_i,
	input fire3_expand_3_en_i,
	input [15:0] ifm_2_i,
	input [15:0] ifm_3_i,
	input ram_feedback_2,
	input ram_feedback_3,
	output fire2_expand_3_finish,
	output fire3_expand_3_finish,
	output reg fire2_expand_3_sample,
	output reg [WIDTH-1:0] ofm_3 [0:DSP_NO_FIRE2_3_EXPAND3-1]
);
	reg fire2_expand_3_end;
	reg fire3_expand_3_end;
	reg fire2_expand_3_en;
	reg fire3_expand_3_en;
	reg [WIDTH-1:0] ifm_2 ;
	reg [WIDTH-1:0] ifm_3 ;
	reg [WIDTH-1:0] tempifm2;
	reg [WIDTH-1:0] tempifm3;
always @(posedge clk) begin
    tempifm2<=ifm_2_i;
    tempifm3<=ifm_3_i;
	fire2_expand_3_en <= fire2_expand_3_en_i ;
	fire3_expand_3_en <= fire3_expand_3_en_i ;
	ifm_2<= tempifm2 ; 
	ifm_3<= tempifm3 ; 
end
reg [WIDTH-1:0] ifm ; //MUX OUT
reg [2*WIDTH-1:0] biasing_wire [0:DSP_NO_FIRE2_3_EXPAND3-1] ;//MUX OUT
reg [WIDTH-1:0] kernels [0:DSP_NO_FIRE2_3_EXPAND3-1] ; //MUX OUT
wire [2*WIDTH-1:0] biasing_wire_2 [0:DSP_NO_FIRE2_3_EXPAND3-1] ;
biasing_fire2_expand3 b7 (
	.bias_mem(biasing_wire_2)
);
wire [2*WIDTH-1:0] biasing_wire_3 [0:DSP_NO_FIRE2_3_EXPAND3-1] ;
biasing_fire3_expand3 b8 (
	.bias_mem(biasing_wire_3)
);
///////////////////////////////////
//KERNELS INSTANTIATION
///////////////////////////////////
wire [WIDTH-1:0] kernels_2 [0:DSP_NO_FIRE2_3_EXPAND3-1] ; 
wire [WIDTH-1:0] kernels_3 [0:DSP_NO_FIRE2_3_EXPAND3-1] ; 
reg [WIDTH-1:0] kernel_regs [0:DSP_NO_FIRE2_3_EXPAND3-1] ; 
reg [$clog2(KERNEL_DIM_FIRE2_3_EXPAND3**2*CHIN_FIRE2_3_EXPAND3)-1:0] weight_rom_address ; 
//////////////////////////////////
wrapper_rom_fire2 u_2 (
	.address(weight_rom_address),
	.rom_out(kernels_2)
);
wrapper_rom_fire3 u_3 (
	.address(weight_rom_address),
	.rom_out(kernels_3)
);
reg layer_en_reg ;
reg entemp;
always @(posedge clk) begin
    entemp<=fire2_expand_3_en || fire3_expand_3_en;
    layer_en_reg <= entemp ; 
end 
///////////////////////////////////
//this signal is very important to track
//represents a pulse to clr pin of mac 
///////////////////////////////////
reg clr_pulse ; 
reg temp_clr_pulse ;
reg rom_clr_pulse;
wire rst_gen ; 
always@ (posedge clk) begin
temp_clr_pulse <= rom_clr_pulse ;
clr_pulse<= temp_clr_pulse;
end
///////
///////
always @(posedge clk/* or negedge rst*/) begin
	/*if(!rst)
		weight_rom_address<= 0 ; 
	else*/ if (rom_clr_pulse || rst_gen)
		weight_rom_address<= 0;
	else if (fire2_expand_3_en || fire3_expand_3_en)begin
		weight_rom_address<= weight_rom_address+1;
	end
end
assign rst_gen = fire2_expand_3_end && fire2_expand_3_en ; 
////////////////////////////
//ENABLE SIGNALS MULTIPLEX//
//ROM & INPUTS TO MAC///////
////////////////////////////
always @(posedge clk) begin
	if (fire2_expand_3_en) begin
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
reg [$clog2(KERNEL_DIM_FIRE2_3_EXPAND3**2*CHIN_FIRE2_3_EXPAND3):0] clr_counter ; 
always @(posedge clk/* or negedge rst*/) begin
	/*if(!rst) begin
			rom_clr_pulse <= 1'b0 ; 
			clr_counter <= 0 ;
	end
	else*/ if (!(fire2_expand_3_end && fire3_expand_3_end) && (fire3_expand_3_en || fire2_expand_3_en) && !rst_gen) begin
		if(clr_counter == KERNEL_DIM_FIRE2_3_EXPAND3**2*CHIN_FIRE2_3_EXPAND3-1 ) begin
			rom_clr_pulse<= 1'b1 ; 
			clr_counter <= clr_counter+1 ;
		end
		else if(clr_counter == KERNEL_DIM_FIRE2_3_EXPAND3**2*CHIN_FIRE2_3_EXPAND3) begin
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
wire [2*WIDTH-1:0] ofmw [0:DSP_NO_FIRE2_3_EXPAND3-1];
reg [2*WIDTH-1:0] ofmw2 [0:DSP_NO_FIRE2_3_EXPAND3-1];
genvar i ; 
generate for (i = 0 ; i< DSP_NO_FIRE2_3_EXPAND3; i++) begin
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
	for (int i = 0 ; i < DSP_NO_FIRE2_3_EXPAND3 ; i++) begin
		ofmw2[i]  = ofmw[i] + biasing_wire[i]  ;
	end
end
always@(posedge clk) begin
	if(clr_pulse) begin
		for (int i = 0 ; i< DSP_NO_FIRE2_3_EXPAND3 ; i++) begin
			if(ofmw2[i][31] == 1'b1 ) begin 
					ofm_3[i] <= 16'b0 ;
			end
			else begin
					ofm_3[i] <= {ofmw2[i][31],ofmw2[i][28:14]};
			end
		end
	end
end
///////////////////////////////
//CHECK FOR LAYER END//////////
///////////////////////////////
reg [$clog2(WOUT_FIRE2_3_EXPAND3**2):0] fire2_expand_3_timer ;
reg [$clog2(WOUT_FIRE2_3_EXPAND3**2):0] fire3_expand_3_timer ;
always @(posedge clk /*or negedge rst*/) begin
	/*if (!rst) begin
		fire2_expand_3_timer<= 0 ;
		fire3_expand_3_timer<= 0 ;
		fire2_expand_3_end <= 1'b0 ; 
		fire3_expand_3_end <= 1'b0 ; 
	end
	else*/ if (fire2_expand_3_en) begin
		if (fire2_expand_3_timer > WOUT_FIRE2_3_EXPAND3**2-1)
			fire2_expand_3_end <= 1'b1 ;
		else if (clr_pulse)
			fire2_expand_3_timer<= fire2_expand_3_timer+1 ; 
		end
	else if (fire3_expand_3_en) begin
		if (fire3_expand_3_timer > WOUT_FIRE2_3_EXPAND3**2-1)
			fire3_expand_3_end <= 1'b1 ;
		else if (clr_pulse)
			fire3_expand_3_timer<= fire3_expand_3_timer+1 ; 
		end
end
always @(posedge clk) begin
	fire2_expand_3_sample <= clr_pulse ; 
end 

(*dont_touch ="yes"*)reg ram_feedback_reg_2 ; 

(* dont_touch = "yes" *)reg ram_feedback_reg_3 ; 
always @(posedge clk /*or negedge rst*/) begin
	/*if(!rst) begin
		ram_feedback_reg_2<=1'b0 ;
		ram_feedback_reg_3<=1'b0 ;
	end
	else*/ if (ram_feedback_2) 
		ram_feedback_reg_2<= 1'b1 ;
	else if (ram_feedback_3) 
		ram_feedback_reg_3<= 1'b1 ;
end
assign fire2_expand_3_finish = fire2_expand_3_end && !ram_feedback_reg_2 ;
assign fire3_expand_3_finish = fire3_expand_3_end && !ram_feedback_reg_3 ;
initial begin
rom_clr_pulse= 1'b0 ; 
clr_counter = 0 ;
weight_rom_address=0;
ram_feedback_reg_2=1'b0;
ram_feedback_reg_3=1'b0;
fire2_expand_3_timer=0;
fire3_expand_3_timer=0;
fire2_expand_3_end=1'b0;
fire3_expand_3_end=1'b0;
end
endmodule

