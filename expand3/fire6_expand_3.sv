
module fire6_expand_3 #(
	parameter DSP_NO = 256 ,
	parameter W_IN = 16 ,
	parameter WIDTH = 16 ,
	parameter CHIN = 64,
	parameter KERNEL_DIM = 3  
)
(
	input clk,
	input rst,
	input fire6_expand_3_en,
	input [15:0] ifm,
	output reg fire6_expand_3_end,
	output reg [WIDTH-1:0] ofm [0:DSP_NO-1]
);

wire [WIDTH-1:0] biasing_wire [0:DSP_NO-1] ;
biasing_rom b7 (
	.bias_mem(biasing_wire)
);
///////////////////////////////////
//KERNELS INSTANTIATION
///////////////////////////////////
wire [WIDTH-1:0] kernels [0:DSP_NO-1] ;
reg [WIDTH-1:0] kernel_regs [0:DSP_NO-1] ;
reg [$clog2(KERNEL_DIM**2*CHIN)-1:0] weight_rom_address ;
//////////////////////////////////
wrapper_rom u_2 (
	.address(weight_rom_address),
	.rom_out(kernels)
);
///////////////////////////////////
//this signal is very important to track
//represents a pulse to clr pin of mac to reset every 27 cycles of clk
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
	else begin
		weight_rom_address<= weight_rom_address+1;
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
	else if (!fire6_expand_3_end) begin
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
wire [2*WIDTH-1:0] ofmw [0:DSP_NO-1];
reg [2*WIDTH-1:0] ofmw2 [0:DSP_NO-1];
genvar i ;
generate for (i = 0 ; i< DSP_NO ; i++) begin
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
	if(clr_pulse && fire6_expand_3_en && !fire6_expand_3_end) begin
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
reg [$clog2(DSP_NO**2)-1:0] fire6_expand_3_timer ;
always @(posedge clk or negedge rst) begin
	if (!rst) begin
		fire6_expand_3_timer<= 0 ;
		fire6_expand_3_end <= 1'b0 ;
	end
	else if (fire6_expand_3_timer == DSP_NO**2-1)
		fire6_expand_3_end <= 1'b1 ;//LAYER HAS FINISHED
	else
		fire6_expand_3_timer<= fire6_expand_3_timer+1 ;
end
endmodule



