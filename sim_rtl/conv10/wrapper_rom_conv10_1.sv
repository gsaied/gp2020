/* verilator lint_off COMBDLY */
module wrapper_rom_conv10_1 #(
parameter WIDTH=16,
parameter KERNEL=1,
parameter ADDR=10,
parameter NUM=512)
(
	input [ADDR-1:0] address ,
	output reg [WIDTH-1:0] rom_out [0:NUM-1]
);	
wire [WIDTH-1:0] rom1_wire [0:NUM-1]; 
wire [WIDTH-1:0] rom2_wire [0:NUM-1]; 
rom_conv10_1 u1 (
	.address(address[8:0]),
	.rom_out(rom1_wire) 
);
rom2_conv10_1 u2 (
	.address(address[7:0]),
	.rom_out(rom2_wire) 
);
always @(*) begin
	if (address > 511 ) 
		rom_out<= rom2_wire ;
	else
		rom_out<= rom1_wire ; 
end
endmodule 
