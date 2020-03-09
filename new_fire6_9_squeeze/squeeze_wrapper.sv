module squeeze_wrapper #(
	parameter WOUT = 8,
	parameter DSP_NO = 112,
	parameter KERNEL_DIM8 = 3,
	parameter WIDTH = 16 ,
	parameter CHIN8 = 384  
)
(

        input clk,
        input rst,
        input fire8_squeeze_en_i,
        input fire9_squeeze_en_i,
        input [WIDTH-1:0] ifm8_i,
        input [WIDTH-1:0] ifm9_i,
        input ram_feedback8,
        input ram_feedback9,
        output reg fire8_squeeze_sample,
        output reg fire9_squeeze_sample,
        output fire8_squeeze_finish ,
        output fire9_squeeze_finish ,
        output reg [WIDTH-1:0] ofm8 [0:DSP_NO-1],
        output reg [WIDTH-1:0] ofm9 [0:DSP_NO-1]
);
wire [WIDTH-1:0] kernels [0:DSP_NO-1] ;
wire rom_clr_pulse_8;
wire rom_clr_pulse_9;
reg fire8_squeeze_en ;
reg fire9_squeeze_en ;
reg [WIDTH-1:0] ifm8 ;
reg [WIDTH-1:0] ifm9 ;
always @(posedge clk) begin
	fire8_squeeze_en  <= fire8_squeeze_en_i ;
	fire9_squeeze_en  <= fire9_squeeze_en_i ;
	ifm8<= ifm8_i ; 
	ifm9<= ifm9_i ; 
end
fire8_squeeze u_8 (
	.kernels(kernels),
	.clk(clk),
	.rom_clr_pulse_o(rom_clr_pulse_8),
	.fire8_squeeze_en(fire8_squeeze_en),
	.ifm(ifm8),
	.ram_feedback(ram_feedback8),
	.fire8_squeeze_sample(fire8_squeeze_sample),
	.fire8_squeeze_finish(fire8_squeeze_finish),
	.ofm(ofm8)
);
fire9Squeeze u_9 (
	.clk(clk),
	.fire9Squeeze_en(fire9_squeeze_en),
	.rom_clr_pulse_o(rom_clr_pulse_9),
	.ifm(ifm9),
	.kernels(kernels),
	.ram_feedback(ram_feedback9),
	.fire9Squeeze_sample(fire9_squeeze_sample),
	.fire9Squeeze_finish(fire9_squeeze_finish),
	.ofm(ofm9)
);
(* keep_hierarchy = "yes" *) rom_fire8_squeeze u_2 (
        .clk(clk),
        .address(weight_rom_address),
        .rom_out(kernels)
);
////////////////////////
/* SHARED ROM CONTROL */
////////////////////////
reg [$clog2(KERNEL_DIM8**2*CHIN8)-1:0] weight_rom_address ;
initial begin
	weight_rom_address= 0;
end
always @(posedge clk/* or posedge rst*/) begin
        /*if(rst)
                weight_rom_address<= 0 ;
        else*/ if (rom_clr_pulse_8)
                weight_rom_address<= 0;
	else if (rom_clr_pulse_9 || fire8_squeeze_finish)
		weight_rom_address<= 3456 ;
        else if (fire8_squeeze_en || fire9_squeeze_en) begin
                weight_rom_address<= weight_rom_address+1;
        end
end
endmodule
