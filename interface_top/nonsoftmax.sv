/* IMPLEMENTATION OF NON SOFTMAX LAYER
* CREATED ON 4th OCT
*/

module nonsoftmax (
	input clk,
	input en_softmax,
	output reg [9:0] prediction,
	input signed [15:0] fm 
);

reg [9:0] counter ; 
reg [9:0] index ; 
reg flag;
reg nonsoftmax_end;
reg signed [15:0] comp_feedback ;
initial begin
   counter=0;
   index=0;
   comp_feedback=0;
   flag=0;
   nonsoftmax_end=0;
end
always @(posedge clk) begin
	if(en_softmax)begin
            if ( fm > comp_feedback &&!flag) begin
                comp_feedback <= fm ;
                index <= counter  ;
                counter <= counter +1 ;
            end
            else
                counter <= counter +1 ;
        end
        if(counter>1022)begin
            prediction<=index;
            flag<=1;
            nonsoftmax_end<=1;
        end
   end     
endmodule
