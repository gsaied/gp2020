/*
* CONV 10 IMPLEMENTATION
* INPUT SIZE: 8*8*736
* OUTPUT SIZE: 8*8*512
* STRIDE: 1
* PAD:	0
* WINDOW: 1*1
*/
module conv10 #(
	parameter DSP_NO = 512,
	parameter STRIDE = 1 ,
	parameter W_IN = 8,
	parameter H_IN = 8 ,
	parameter WIDTH = 16 ,
	parameter CHIN = 736 , 
	parameter KERNEL_DIM = 1 ,
	parameter CHOUT = 512  ,
	parameter WINDOWS=CHIN*(((W_IN-1)/STRIDE)**2),
	parameter ITER = ((W_IN**2)*CHOUT)/DSP_NO //8*8
)
(
	input clk,
	input rst,
	input conv10_1_en,
	input conv10_2_en,
	input [15:0] ifm,
	output reg conv10_end,
	output reg conv10_2nd_end,
	output reg [WIDTH-1:0] ofm [0:DSP_NO-1]
);

///////////////////////////////////
//BIASING INSTANTIATION////////////
///////////////////////////////////
reg [WIDTH-1:0] biasing_wire [0:DSP_NO-1] ;
wire [WIDTH-1:0] biasing_wire_2 [0:DSP_NO-1] ;
wire [WIDTH-1:0] biasing_wire_1 [0:DSP_NO-1] ;
biasing_rom b10 (
	.bias_mem(biasing_wire_1)
);
biasing2_rom b20 (
	.bias_mem(biasing_wire_2)
);
always @(*) begin
	if(conv10_1_en) //careful, by default bias mem 2 is loaded 
		biasing_wire= biasing_wire_1 ; 
	else  
		biasing_wire= biasing_wire_2 ; 
end
///////////////////////////////////
//KERNELS INSTANTIATION////////////
///////////////////////////////////
wire [WIDTH-1:0] kernels_1st_layer [0:DSP_NO-1] ; 
wire [WIDTH-1:0] kernels_2nd_layer [0:DSP_NO-1] ; 
reg [WIDTH-1:0] kernel_regs [0:DSP_NO-1] ; 
reg [$clog2(KERNEL_DIM**2*CHIN)-1:0] weight_rom_address ; 
//////////////////////////////////
rom_array_layer_1 u_2 (
	.address(weight_rom_address),
	.rom_out(kernels_1st_layer)
);
rom_array_layer_2 u_3 (
	.address(weight_rom_address),
	.rom_out(kernels_2nd_layer)
);
///////////////////////////////////
//this signal is very important to track
//represents a pulse to clr pin of mac 
//to reset every kernel_dim**2*CHIN cycles of clk
///////////////////////////////////
reg clr_pulse ; 
reg rom_clr_pulse ;
///////
///////
always @(posedge clk or negedge rst) begin
	if(!rst)
		weight_rom_address<= 0 ; 
	else if (rom_clr_pulse)
		weight_rom_address<= 0;
	else begin
		weight_rom_address<= weight_rom_address+1;
	end
end
always @(posedge clk) begin
	if(conv10_1_en) begin
		kernel_regs<=kernels_1st_layer ;
	end
	else if (conv10_2_en) begin
		kernel_regs<=kernels_2nd_layer ;
	end
end
////////////////////////////
//GENERATION OF CLR PULSE///
////////////////////////////
reg [$clog2(KERNEL_DIM**2*CHIN)-1:0] clr_counter ; 
always @(posedge clk or negedge rst) begin
	if(!rst) begin
		clr_pulse <= 1'b0 ; 
		rom_clr_pulse <= 1'b0 ; 
		clr_counter <= 0 ;
	end
	else if (!conv10_end) begin
		if(clr_counter == KERNEL_DIM**2*CHIN-1 ) begin
			rom_clr_pulse<= 1'b1 ;
			clr_counter<= clr_counter +1 ;
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
wire [2*WIDTH-1:0] ofmw [0:DSP_NO-1];
reg [2*WIDTH-1:0] ofmw2 [0:DSP_NO-1];
genvar i ; 
generate for (i = 0 ; i< CHOUT ; i++) begin
	mac mac_i (
		.clr(clr_pulse),
		.clk(clk),
		.rst(rst),
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
		ofmw2[i]  = ofmw[i] + {biasing_wire[i],16'b0}  ; //bias + CHECK IF THIS LOGIC IS CORRECT
	end
end
always@(posedge clk) begin
	if((conv10_1_en || conv10_2_en) && !( conv10_end && conv10_2nd_end) && clr_pulse) begin
		for (int i = 0 ; i< DSP_NO ; i++) begin
			if(ofmw2[i][31] == 1'b1 ) 
				ofm[i] <= 16'b0 ;
			else
				ofm[i] <= ofmw2[i][23:8] ;//relu
		end
	end
end
///////////////////////////////
//CHECK FOR LAYER END//////////
///////////////////////////////
reg [$clog2(CHOUT**2)-1:0] conv10_timer ;
always @(posedge clk or negedge rst) begin//will be modified to use clk_sampling as the counting signal
	if (!rst) begin
		conv10_timer<= 0 ;
		conv10_end <= 1'b0 ; 
	end
	else if (conv10_1_en) begin
		if (conv10_timer == CHOUT**2-1)
			conv10_end <= 1'b1 ;//LAYER_1 HAS FINISHED
		else if (clr_pulse)
			conv10_timer<= conv10_timer+1 ; 
		end
	else if (conv10_2_en) begin
		if (conv10_timer == CHOUT**2-1)
			conv10_2nd_end <= 1'b1 ;//LAYER_2 HAS FINISHED
		else if (clr_pulse)
			conv10_timer<= conv10_timer+1 ; 
	end
end
endmodule

