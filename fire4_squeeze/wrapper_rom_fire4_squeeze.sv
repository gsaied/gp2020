/* verilator lint_off COMBDLY */
module wrapper_rom_fire4_squeeze #(
parameter WIDTH=16,
parameter KERNEL=3,
parameter ADDR=11,
parameter NUM=32)
(
	input [ADDR-1:0] address ,
	output reg [WIDTH-1:0] rom_out [0:NUM-1]
);	
wire [WIDTH-1:0] rom1_wire [0:NUM-1]; 
wire [WIDTH-1:0] rom2_wire [0:NUM-1]; 
rom_fire4_squeeze u1 (
	.address(address[9:0]),
	.rom_out(rom1_wire) 
);
rom2_fire4_squeeze u2 (
	.address(address[6:0]),
	.rom_out(rom2_wire) 
);
always @(*) begin
	if (address > 1023) 
		rom_out<= rom2_wire ;
	else
		rom_out<= rom1_wire ; 
end
endmodule 
