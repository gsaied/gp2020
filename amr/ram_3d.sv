module ram_3d #(
	parameter ram_num = 16 ,
	parameter WIDTH= 16 ,
	parameter address= 10
)
(
	input clk,
	input rst,
	input  wea,
	input [address-1:0] addra ,
	input [WIDTH-1:0] dina ,
	output [WIDTH-1:0] douta
);
   (* ram_style="{registers}" *)
reg [WIDTH-1:0] ram3d [0:2**address-1] ;
always@(posedge clk) begin
		if(wea) begin
			ram3d[addra] <=dina ;
		end
end
	assign douta= ram3d[addra] ;
endmodule


	
