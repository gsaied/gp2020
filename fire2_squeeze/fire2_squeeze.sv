module fire2_squeeze #(
	parameter WOUT_FIRE2_SQUEEZE = 64,
	localparam DSP_NO_FIRE2_SQUEEZE = 16 ,
	localparam WIDTH = 16 ,
	parameter CHIN = 64,
	parameter KERNEL_DIM = 3  
)
(
	input clk,
//	input rst,
	input fire2_squeeze_en_i,
	input [WIDTH-1:0] ifm_i,
	input ram_feedback,
	output reg fire2_squeeze_sample,
	output fire2_squeeze_finish ,
	output reg [WIDTH-1:0] ofm [0:DSP_NO_FIRE2_SQUEEZE-1]
);
reg fire2_squeeze_end;
wire [2*WIDTH-1:0] biasing_wire [0:DSP_NO_FIRE2_SQUEEZE-1] ;
biasing_fire2_squeeze b7 (
	.bias_mem(biasing_wire)
);
reg fire2_squeeze_en_1 ;
reg fire2_squeeze_en;
reg [WIDTH-1:0] ifm ;
reg [WIDTH-1:0] temp_ifm ;
always@(posedge clk)begin
	temp_ifm <= ifm_i ;
        ifm<=temp_ifm;
	fire2_squeeze_en_1 <= fire2_squeeze_en_i ;
	fire2_squeeze_en <= fire2_squeeze_en_1 ;
end
///////////////////////////////////
//KERNELS INSTANTIATION
///////////////////////////////////
wire [WIDTH-1:0] kernels [0:DSP_NO_FIRE2_SQUEEZE-1] ;
reg [$clog2(KERNEL_DIM**2*CHIN)-1:0] weight_rom_address ;
//////////////////////////////////
//(* keep_hierarchy = "yes" *)
rom_fire2_squeeze u_2 (
	.clk(clk),
	.address(weight_rom_address),
	.kernels(kernels)
);
///////////////////////////////////
//this signal is very important to track
///////////////////////////////////
reg clr_pulse ;
reg temp_clr_pulse ;
reg rom_clr_pulse;
always @(posedge clk) begin
       	temp_clr_pulse <= rom_clr_pulse ; 
	clr_pulse<= temp_clr_pulse ; 
end
///////
///////
always @(posedge clk/* or negedge rst*/) begin
	/*if(!rst)
		weight_rom_address<= 0 ;
	else */if (rom_clr_pulse)
		weight_rom_address<= 0;
	else if (fire2_squeeze_en) begin
		weight_rom_address<= weight_rom_address+1;
	end
end

////////////////////////////
//GENERATION OF CLR PULSE///
////////////////////////////
reg [$clog2(KERNEL_DIM**2*CHIN):0] clr_counter ;
always @(posedge clk /*or negedge rst*/) begin
	/*if(!rst) begin
		rom_clr_pulse <= 1'b0 ;
		clr_counter <= 0 ;
	end
	else*/ if (!fire2_squeeze_end && fire2_squeeze_en) begin
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
end
reg layer_en_reg ; 
always @(posedge clk) layer_en_reg <= fire2_squeeze_en ; 
//////////////////////////////
//CORE GENERATION/////////////
//////////////////////////////
wire [2*WIDTH-1:0] ofmw [0:DSP_NO_FIRE2_SQUEEZE-1];
reg [2*WIDTH-1:0] ofmw2 [0:DSP_NO_FIRE2_SQUEEZE-1];
genvar k ;
generate
for (k = 0 ; k< DSP_NO_FIRE2_SQUEEZE ; k++) begin
	mac mac_k (
		.clr(clr_pulse),
		.clk(clk),
		.layer_en(layer_en_reg),
		.pix(ifm),
		.mul_out(ofmw[k]),
		.ker(kernels[k])
	);
end
endgenerate
//////////////////////////////////
//OUTPUT IS READY TO BE SAMPLED//
/////////////////////////////////
always @(*) begin
	for (int i = 0 ; i < DSP_NO_FIRE2_SQUEEZE ; i++) begin
		ofmw2[i]  = ofmw[i] + biasing_wire[i]  ;
	end
end
always@(posedge clk) begin
	if(clr_pulse) begin
		for (int i = 0 ; i< DSP_NO_FIRE2_SQUEEZE ; i++) begin
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
reg [$clog2(WOUT_FIRE2_SQUEEZE**2):0] fire2_squeeze_timer ;
always @(posedge clk /*or negedge rst*/) begin
	/*if (!rst) begin
		fire2_squeeze_timer<= 0 ;
		fire2_squeeze_end <= 1'b0 ;
	end
	else*/ if (fire2_squeeze_timer > WOUT_FIRE2_SQUEEZE**2-1)
		fire2_squeeze_end <= 1'b1 ;//LAYER HAS FINISHED
	else if (clr_pulse)
		fire2_squeeze_timer<= fire2_squeeze_timer+1 ;
end
always @(posedge clk) begin
	fire2_squeeze_sample <= clr_pulse ; 
end
(* dont_touch ="true"*)
reg ram_feedback_reg ; 
always @(posedge clk /*or negedge rst*/) begin
	/*if (!rst)
		ram_feedback_reg<= 1'b0 ; 
	else */if (ram_feedback)
		ram_feedback_reg<= 1'b1 ;
end
assign fire2_squeeze_finish= !ram_feedback_reg && fire2_squeeze_end ; 
initial begin 
weight_rom_address =0;
ram_feedback_reg = 1'b0;
rom_clr_pulse =1'b0;
clr_counter=0;
fire2_squeeze_timer =0;
fire2_squeeze_end =1'b0;
end 
endmodule



