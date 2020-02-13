module mac (
	input rst,
	input clk,
	input clr,
	input signed [15:0] pix,
	input signed [15:0] ker,
	output reg signed [32:0] mul_out 
);
wire signed [32:0] intermed ;
	assign intermed = pix*ker + mul_out ; 
	always @(posedge clk ) begin
		if (!rst || clr)
			mul_out <= 33'b0 ;
		else
			mul_out <= intermed ; 
	end
endmodule
