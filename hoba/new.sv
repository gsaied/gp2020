module counter#(
	parameter CHIN = 64,
	parameter KERNEL_DIM = 3  
)
(
	input clk,
	input fire2_squeeze_en,
	input fire2_squeeze_end,
	output reg rom_clr_pulse
);

reg [$clog2(KERNEL_DIM**2*CHIN):0] clr_counter ;
always @(posedge clk) begin
	if (fire2_squeeze_en && !fire2_squeeze_end) begin
		if(clr_counter > KERNEL_DIM**2*CHIN-2 ) begin
			rom_clr_pulse<= 1'b1 ;
			clr_counter <= clr_counter+1 ;
		end
		else if(clr_counter > KERNEL_DIM**2*CHIN-1) begin
			clr_counter <= 0 ;
			rom_clr_pulse <= 1'b0 ;
		end
		else begin
			clr_counter <= clr_counter +1;
		end
	end
end
endmodule
