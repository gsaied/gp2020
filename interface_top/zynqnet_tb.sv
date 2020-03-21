module zynqnet_tb ; 
reg clk; 
reg zynqnet_en ;
wire [9:0] classi ;
always #5 clk = !clk ; 
initial begin
	clk=0 ;
	zynqnet_en= 0 ;
	#40 zynqnet_en = 1;
end
zynqnet dut (
	.clk(clk),
	.zynqnet_en(zynqnet_en),
	.zynqnet_output(classi)
);
always @(posedge clk) begin
	if(classi != 0) begin
		$display(classi) ;
		$display("end of simulation time = %t",$time);
	end
end
endmodule
