module flop (
	input clk,
	input rst,
	input [1:0] d,
	output reg [1:0] q 
);
	always @(posedge clk or negedge rst) begin
		if(!rst)
			q<= 2'b0 ; 
		else
			q<= d;
	end
endmodule
