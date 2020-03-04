/* verilator lint_off COMBDLY */
module wrapper_rom_fire6_squeeze #(
parameter WIDTH=16,
parameter KERNEL=3,
parameter ADDR=12,
parameter NUM=64)
(
	input [ADDR-1:0] address ,
	input clk,
	output reg [WIDTH-1:0] rom_out [0:NUM-1]
);	
wire [WIDTH-1:0] rom1_wire [0:NUM-1]; 
wire [WIDTH-1:0] rom2_wire [0:NUM-1]; 
rom_fire6_squeeze u1 (
	.address(address[10:0]),
	.clk(clk),
	.rom_out(rom1_wire) 
);
rom2_fire6_squeeze u2 (
	.address(address[7:0]),
	.rom_out(rom2_wire) 
);
always @(*) begin
	if (address > 2047) 
		rom_out<= rom2_wire ;
	else
		rom_out<= rom1_wire ; 
end
endmodule 
