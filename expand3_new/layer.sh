#!/bin/bash
echo -e "Enter input Width/Height\n" ;
read W_IN ; 
echo -e "Enter input channels \n" ;
read CHIN ; 
echo -e "Enter weights Width/Height \n" ;
read KERNEL_DIM ; 
echo -e "Enter output channels\n" ; 
read DSP_NO ; 
echo -e "Enter output width/height\n" ; 
read WOUT ; 
echo -e "Enter Layer name, same as weights rom and biasing" ; 
read layer_name ; 
touch "$layer_name".sv ; 
echo "
module "$layer_name" #(
	parameter WOUT = "$WOUT",
	parameter DSP_NO = "$DSP_NO" ,
	parameter W_IN = "$W_IN" ,
	parameter WIDTH = 16 ,
	parameter CHIN = "$CHIN",
	parameter KERNEL_DIM = "$KERNEL_DIM"  
)
(
	input clk,
	input rst,
	input "$layer_name"_en,
	input [WIDTH-1:0] ifm,
	input ram_feedback,
	output reg "$layer_name"_sample,
	output "$layer_name"_finish ,
	output reg [WIDTH-1:0] ofm [0:DSP_NO-1]
);
reg "$layer_name"_end;
wire [2*WIDTH-1:0] biasing_wire [0:DSP_NO-1] ;
biasing_"$layer_name" b7 (
	.bias_mem(biasing_wire)
);
///////////////////////////////////
//KERNELS INSTANTIATION
///////////////////////////////////
wire [WIDTH-1:0] kernels [0:DSP_NO-1] ;
reg [WIDTH-1:0] kernel_regs [0:DSP_NO-1] ;
reg [\$clog2(KERNEL_DIM**2*CHIN)-1:0] weight_rom_address ;
//////////////////////////////////
rom_"$layer_name" u_2 (
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
	else if ("$layer_name"_en) begin
		weight_rom_address<= weight_rom_address+1;
	end
end
always @(posedge clk) begin
	if("$layer_name"_en) 
		kernel_regs<=kernels ;
end
reg layer_en_reg ;
always @(posedge clk) begin
    layer_en_reg <= "$layer_name"_en  ; 
end 
////////////////////////////
//GENERATION OF CLR PULSE///
////////////////////////////
reg [\$clog2(KERNEL_DIM**2*CHIN):0] clr_counter ;
always @(posedge clk or negedge rst) begin
	if(!rst) begin
		clr_pulse <= 1'b0 ;
		rom_clr_pulse <= 1'b0 ;
		clr_counter <= 0 ;
	end
	else if (!"$layer_name"_end && "$layer_name"_en) begin
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
		.layer_en(layer_en_reg);
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
	if(clr_pulse && "$layer_name"_en && !"$layer_name"_end) begin
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
reg [\$clog2(WOUT**2):0] "$layer_name"_timer ;
always @(posedge clk or negedge rst) begin
	if (!rst) begin
		"$layer_name"_timer<= 0 ;
		"$layer_name"_end <= 1'b0 ;
	end
	else if ("$layer_name"_timer == WOUT**2)
		"$layer_name"_end <= 1'b1 ;//LAYER HAS FINISHED
	else if (clr_pulse)
		"$layer_name"_timer<= "$layer_name"_timer+1 ;
end
always @(posedge clk) begin
	"$layer_name"_sample <= clr_pulse ; 
end
assign "$layer_name"_finish= !ram_feedback && "$layer_name"_end ; 
endmodule


" > "$layer_name".sv 
