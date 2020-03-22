/* IMPLEMENTATION OF NON SOFTMAX LAYER
* CREATED ON 4th OCT
*/

module nonsoftmax (
	input clk,
	input en_softmax,
	output [9:0] prediction,
	input signed [15:0] fm 
);

reg [9:0] counter ; 
reg [9:0] index ; 
reg signed [15:0] comp_feedback ;
initial begin
   counter=0;
   index=0;
   comp_feedback=0;
end
always @(posedge clk) begin
	if(en_softmax)begin
            if ( fm > comp_feedback ) begin
                comp_feedback <= fm ;
                index <= counter  ;
                counter <= counter +1 ;
            end
            else
                counter <= counter +1 ;
        end
   end     
assign prediction  = index ;
endmodule
