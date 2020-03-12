/* verilator lint_off INITIALDLY */
/* verilator lint_off COMBDLY */
module conv10_1_2 #(
	parameter WOUT = 8,
	parameter DSP_NO = 512,
	parameter W_IN = 8,
	parameter WIDTH = 16 ,
	parameter CHIN = 736 , 
	parameter KERNEL_DIM = 1 ,
	parameter CHOUT = 512   
)
(
	input clk,
	input conv10_1_en,
	input conv10_2_en,
	input [15:0] ifm_1_i,
	input [15:0] ifm_2_i,
	input ram_feedback_1,
	input ram_feedback_2,
	output conv10_1_finish,
	output conv10_2_finish,
	output reg conv10_1_sample,
	output reg [WIDTH-1:0] ofm [0:DSP_NO-1]
);
	reg conv10_1_end;
	reg conv10_2_end;
	wire rst_gen ; 
	reg [WIDTH-1:0] ifm_1 ;
	reg [WIDTH-1:0] ifm_2 ;
/*	
	reg conv10_1_en ;
	reg conv10_2_en ;
	*/
////////////////////////
/* REGISTERING INPUTS */
////////////////////////
always @(posedge clk) begin
	ifm_1<= ifm_1_i ; 
	ifm_2<= ifm_2_i ; 
end
reg [WIDTH-1:0] ifm ; //MUX OUT
reg [2*WIDTH-1:0] biasing_wire [0:DSP_NO-1] ;//MUX OUT
reg [WIDTH-1:0] kernels [0:DSP_NO-1] ; //MUX OUT
wire [2*WIDTH-1:0] biasing_wire_1 [0:DSP_NO-1] ;
biasing_conv10_1 b7 (
	.bias_mem(biasing_wire_1)
);
wire [2*WIDTH-1:0] biasing_wire_2 [0:DSP_NO-1] ;
biasing_conv10_2 b8 (
	.bias_mem(biasing_wire_2)
);
///////////////////////////////////
//KERNELS INSTANTIATION
////////////////////////////m//////
wire [WIDTH-1:0] kernels_1 [0:DSP_NO-1] ; 
wire [WIDTH-1:0] kernels_2 [0:DSP_NO-1] ; 
reg [WIDTH-1:0] kernel_regs [0:DSP_NO-1] ; 
reg [$clog2(KERNEL_DIM**2*CHIN)-1:0] weight_rom_address ; 
//////////////////////////////////
wrapper_rom_conv10_1 u_2 (
	.address(weight_rom_address),
	.rom_out(kernels_1)
);
wrapper_rom_conv10_2 u_3 (
	.address(weight_rom_address),
	.rom_out(kernels_2)
);
reg layer_en_reg ;
always @(posedge clk) begin
    layer_en_reg <= conv10_1_en || conv10_2_en ; 
end 
///////////////////////////////////
//this signal is very important to track
//represents a pulse to clr pin of mac 
///////////////////////////////////
reg clr_pulse ; 
reg rom_clr_pulse;
always @(posedge clk) clr_pulse <= rom_clr_pulse ;
///////
///////
always @(posedge clk  ) begin
	if (rom_clr_pulse || rst_gen )
		weight_rom_address<= 0;
	else if (conv10_1_en || conv10_2_en)begin
		weight_rom_address<= weight_rom_address+1;
	end
end
assign rst_gen = conv10_1_en && conv10_1_end ; 
////////////////////////////
//ENABLE SIGNALS MULTIPLEX//
//ROM & INPUTS TO MAC///////
////////////////////////////
always @(*) begin
	if (conv10_1_en) begin
		kernels <= kernels_1 ;
		biasing_wire <= biasing_wire_1 ; 	
		ifm<= ifm_1 ; 
	end
	else begin 
		kernels <= kernels_2 ;
		biasing_wire <= biasing_wire_2 ; 
		ifm<= ifm_2 ; 
	end
end
always @(posedge clk) begin
	kernel_regs<=kernels ;		
end
////////////////////////////
//GENERATION OF CLR PULSE///
////////////////////////////
reg [$clog2(KERNEL_DIM**2*CHIN):0] clr_counter ; 
always @(posedge clk ) begin
	if (!(conv10_1_end && conv10_2_end) && (conv10_2_en || conv10_1_en) && !rst_gen) begin
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
	else if (rst_gen) begin
		rom_clr_pulse <= 1'b0 ; 
		clr_counter <= 0 ;
	end
end
//////////////////////////////
//CORE GENERATION/////////////
//////////////////////////////
wire [2*WIDTH-1:0] ofmw [0:DSP_NO-1];
reg [2*WIDTH-1:0] ofmw2 [0:DSP_NO-1];
genvar i ; 
generate for (i = 0 ; i< CHOUT ; i++) begin
	mac mac_i (
		.clr(clr_pulse || rst_gen),
		.clk(clk),
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
	if(clr_pulse ) begin
		for (int i = 0 ; i< DSP_NO ; i++) begin
				ofm[i] <= {ofmw2[i][31],ofmw2[i][29:15]};
		end
	end
end
///////////////////////////////
//CHECK FOR LAYER END//////////
///////////////////////////////
reg [$clog2(WOUT**2):0] conv10_1_timer ;
reg [$clog2(WOUT**2):0] conv10_2_timer ;
always @(posedge clk ) begin
	if (conv10_1_en) begin
		if (conv10_1_timer > WOUT**2)
			conv10_1_end <= 1'b1 ;
		else if (clr_pulse)
			conv10_1_timer<= conv10_1_timer+1 ; 
		end
	else begin
		if (conv10_2_timer > WOUT**2)
			conv10_2_end <= 1'b1 ;
		else if (clr_pulse)
			conv10_2_timer<= conv10_2_timer+1 ; 
		end
end
always @(posedge clk) begin
	conv10_1_sample <= clr_pulse ; 
end 

(* dont_touch = "true" *)reg ram_feedback_reg_1 ; 
(* dont_touch = "true" *)reg ram_feedback_reg_2 ; 
always @(posedge clk ) begin
	if (ram_feedback_1) 
		ram_feedback_reg_1<= 1'b1 ;
	else if (ram_feedback_2) 
		ram_feedback_reg_2<= 1'b1 ;
end
assign conv10_1_finish = conv10_1_end && !ram_feedback_reg_1 ;
assign conv10_2_finish = conv10_2_end && !ram_feedback_reg_2 ;
initial begin
	weight_rom_address<= 0 ;
	rom_clr_pulse <= 1'b0 ; 
	clr_counter <= 0 ;
	conv10_1_timer<= 0 ;
	conv10_2_timer<= 0 ;
	conv10_1_end <= 1'b0 ; 
	conv10_2_end <= 1'b0 ; 
	ram_feedback_reg_1<=1'b0 ;
	ram_feedback_reg_2<=1'b0 ;
end
endmodule

