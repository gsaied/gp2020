module conv_mac (
	input clk,
	input clr,
	input layer_en,
	input signed [15:0] pix,
	input signed [15:0] ker,
	output reg signed [31:0] mul_out 
);
initial mul_out =32'b0 ;
	always @(posedge clk ) begin
		if (clr)
			mul_out <= 32'b0 ;
		else if (layer_en)
			mul_out <= pix*ker + mul_out ; 
	end
endmodule
