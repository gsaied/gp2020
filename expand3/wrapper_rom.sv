
/* verilator lint_off COMBDLY */
module wrapper_rom #(
parameter WIDTH=16,
parameter KERNEL=3,
parameter ADDR=10,
parameter NUM=256)
(
	input [ADDR-1:0] address ,
	output reg [WIDTH-1:0] rom_out [0:NUM-1]
);	
wire [WIDTH-1:0] rom1_wire [0:NUM-1]; 
wire [WIDTH-1:0] rom2_wire [0:NUM-1]; 
rom_array_layer_1 u1 (
	.address(address),
	.rom_out(rom1_wire) 
);
rom_array_layer_2 u2 (
	.address(address[5:0]),
	.rom_out(rom2_wire) 
);
always @(*) begin
	if (address > 511 ) 
		rom_out<= rom2_wire ;
	else
		rom_out<= rom1_wire ; 
end
endmodule 
