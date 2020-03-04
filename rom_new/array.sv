module array #(
	parameter WIDTH=16,
	parameter DEPTH=4,
	parameter NUM=2
)
(
	input [WIDTH-1:0] d [0:DEPTH-1],
	input clk,
	input [1:0] address,
	output [WIDTH-1:0] out_q [NUM-1:0]
);
reg [WIDTH-1:0] q [0:DEPTH-1] ;
reg [WIDTH-1:0] q2 [0:DEPTH-1] ;
always @(posedge clk) begin
	for (int i=0 ; i< DEPTH ; i++) begin
		q[i] <= d[i] ;
		q2[i] <= d[i] ;
	end
end
initial begin
	q[3] = 16'habff ;
	q[2] = 16'hebff ;
	q[1] = 16'hcbff ;
	q[0] = 16'hff10 ;
	q2[3] = 16'h1bff ;
	q2[2] = 16'h1bff ;
	q2[1] = 16'h1bff ;
	q2[0] = 16'h1f10 ;
end
assign out_q[1] = q[address] ;
assign out_q[0] = q2[address] ;
endmodule
