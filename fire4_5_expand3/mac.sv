module mac (
	input clk,
	input clr,
	input layer_en,
	input signed [15:0] pix,
	input signed [15:0] ker,
	output reg signed [31:0] mul_out 
);
wire signed [31:0] intermed ;
	assign intermed = pix*ker + mul_out ; 
	always @(posedge clk ) begin
		if (clr)
			mul_out <= 32'b0 ;
		else if (layer_en) 
			mul_out <= intermed ; 
	end
endmodule
