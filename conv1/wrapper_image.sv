/* verilator lint_off COMBDLY */
module wrapper_image #(
	parameter WIDTH =16,
	parameter ADDR= 18
)
(
	input clk,
	input [ADDR-1:0] address,
	output reg [WIDTH-1:0] image_wrapper_o
);
	(* rom_style = "block" *)
	reg [WIDTH-1:0] first_part [0:2**17-1] ;

	(* rom_style = "block" *)
	reg [WIDTH-1:0] second_part [0:2**16-1] ;

	(* rom_style = "block" *)
	reg [WIDTH-1:0] third_part [0:2**12-1] ;
	
initial begin
	$readmemb("first_part.mem",first_part,0,2**17-1);
	$readmemb("second_part.mem",second_part,0,2**16-1);
	$readmemb("third_part.mem",third_part,0,2**12-1);
end
reg [WIDTH-1:0] o1; 
reg [WIDTH-1:0] o2; 
reg [WIDTH-1:0] o3; 
(* dont_touch = "true" *)reg [WIDTH-1:0] o11; 
(* dont_touch = "true" *)reg [WIDTH-1:0] o21; 
(* dont_touch = "true" *)reg [WIDTH-1:0] o31; 
reg [1:0] address_reg ; 
reg [1:0] address_reg1 ; 
always @(posedge clk) begin
	address_reg1 <= address[17:16] ;
	address_reg <= address_reg1;
	
end
always @(posedge clk) begin 
o21 <= o2;
o31 <= o3;
o11 <= o1;
end
always @(*) begin
	case(address_reg) 
		2'b10:image_wrapper_o<= o21;
		2'b11:image_wrapper_o<= o31;
		default:image_wrapper_o<= o11;
	endcase
end
always @(posedge clk) begin
		o1<= first_part[address[ADDR-2:0]]; 
		o2<= second_part[address[ADDR-3:0]] ;
		o3<= third_part[address[ADDR-7:0]];
end
endmodule
