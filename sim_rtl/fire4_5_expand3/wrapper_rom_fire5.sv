
/* verilator lint_off COMBDLY */
module wrapper_rom_fire5 #(
parameter WIDTH=16,
parameter KERNEL=3,
parameter ADDR=9,
parameter NUM=128)
(
	input [ADDR-1:0] address ,
	output reg [WIDTH-1:0] rom_out [0:NUM-1]
);	
wire [WIDTH-1:0] rom1_wire [0:NUM-1]; 
wire [WIDTH-1:0] rom2_wire [0:NUM-1]; 
rom_fire5_expand3 u1 (
	.address(address[7:0]),
	.rom_out(rom1_wire) 
);
rom2_fire5_expand3 u2 (
	.address(address[4:0]),
	.rom_out(rom2_wire) 
);
always @(*) begin
	if (address > 255 ) 
		rom_out<= rom2_wire ;
	else
		rom_out<= rom1_wire ; 
end
endmodule 
