
module fire7_expand3 #(
	parameter WOUT = 16,
	parameter DSP_NO = 192 ,
	parameter W_IN = 16 ,
	parameter WIDTH = 16 ,
	parameter CHIN = 64,
	parameter KERNEL_DIM = 3  
)
(
	input clk,
	input rst,
	input fire7_expand3_en,
	input [WIDTH-1:0] ifm,
	input ram_feedback,
	output reg fire7_expand3_sample,
	output fire7_expand3_finish ,
	output reg [WIDTH-1:0] ofm [0:DSP_NO-1]
);
reg fire7_expand3_end;
wire [2*WIDTH-1:0] biasing_wire [0:DSP_NO-1] ;
biasing_fire7_expand3 b7 (
	.bias_mem(biasing_wire)
);
///////////////////////////////////
//KERNELS INSTANTIATION
///////////////////////////////////
wire [WIDTH-1:0] kernels [0:DSP_NO-1] ;
reg [WIDTH-1:0] kernel_regs [0:DSP_NO-1] ;
reg [$clog2(KERNEL_DIM**2*CHIN)-1:0] weight_rom_address ;
//////////////////////////////////
wrapper_rom_fire7_expand3 u_2 (
	.address(weight_rom_address),
	.rom_out(kernels)
);
///////////////////////////////////
//this signal is very important to track
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
	else if (fire7_expand3_en) begin
		weight_rom_address<= weight_rom_address+1;
	end
end
always @(posedge clk) begin
	if(fire7_expand3_en) 
		kernel_regs<=kernels ;
end
reg layer_en_reg ;
always @(posedge clk) begin
    layer_en_reg <= fire7_expand3_en  ; 
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
	else if (!fire7_expand3_end && fire7_expand3_en) begin
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
generate for (i = 0 ; i< DSP_NO ; i++) begin
	mac mac_i (
		.clr(clr_pulse),
		.clk(clk),
		.rst(rst),
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
always@(posedge clk) begin
	if(clr_pulse && fire7_expand3_en && !fire7_expand3_end) begin
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
reg [$clog2(WOUT**2):0] fire7_expand3_timer ;
always @(posedge clk or negedge rst) begin
	if (!rst) begin
		fire7_expand3_timer<= 0 ;
		fire7_expand3_end <= 1'b0 ;
	end
	else if (fire7_expand3_timer == WOUT**2+1)
		fire7_expand3_end <= 1'b1 ;//LAYER HAS FINISHED
	else if (clr_pulse)
		fire7_expand3_timer<= fire7_expand3_timer+1 ;
end
always @(posedge clk) begin
	fire7_expand3_sample <= clr_pulse ; 
end
reg ram_feedback_reg ; 
always @(posedge clk or negedge rst) begin
	if (!rst)
		ram_feedback_reg<= 1'b0 ; 
	else if (ram_feedback)
		ram_feedback_reg<= 1'b1 ;
end
assign fire7_expand3_finish= !ram_feedback_reg && fire7_expand3_end ; 
endmodule


