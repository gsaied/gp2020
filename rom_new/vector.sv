module vector #(
	parameter WIDTH=16
)
(
	input [WIDTH-1:0] d,
	input clk,
	output reg [WIDTH-1:0] q
);
always @(posedge clk) begin
	q<= d ;
end
endmodule
