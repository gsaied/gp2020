
/* verilator lint_off COMBDLY */
module wrapper_rom_fire3 #(
parameter WIDTH=16,
parameter KERNEL=3,
parameter ADDR=8,
parameter NUM=64)
(
	input [ADDR-1:0] address ,
	output reg [WIDTH-1:0] rom_out [0:NUM-1]
);	
wire [WIDTH-1:0] rom1_wire [0:NUM-1]; 
wire [WIDTH-1:0] rom2_wire [0:NUM-1]; 
rom_fire3_expand3 u1 (
	.address(address[6:0]),
	.rom_out(rom1_wire) 
);
rom2_fire3_expand3 u2 (
	.address(address[3:0]),
	.rom_out(rom2_wire) 
);
always @(*) begin
	if (address > 127 ) 
		rom_out<= rom2_wire ;
	else
		rom_out<= rom1_wire ; 
end
endmodule 
