module acc (
	input clk,
	input clear,
	input conv10_sample,
	input signed [15:0] pixel,
	output reg signed [15:0] acc_out 
);
initial begin
    acc_out = 16'b0 ;
end
always @(posedge clk ) begin
	 if(clear)
	    acc_out <= 16'b0 ;
	 else if (conv10_sample) 
		acc_out <= pixel + acc_out ; 
end
endmodule

