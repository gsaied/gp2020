module acc_array#(
	parameter TOTAL_ACC = 512,
	parameter WIDTH = 16
)
(
	input clk,
	input conv10_1_end,
	input conv10_2_end,
	input  en_conv10_1,
	input  en_conv10_2,
	input conv10_sample,
	input [WIDTH-1:0] conv10_1_out [0:TOTAL_ACC-1],
	input [WIDTH-1:0] conv10_2_out [0:TOTAL_ACC-1],
	output reg  [WIDTH-1:0] pooltomax 
    );
///////////////////signals//////////////////////////  
wire clear;
reg restart;
reg [WIDTH-1 :0] pixel [0:TOTAL_ACC-1];  
reg [WIDTH-1 :0] acc_out [0:TOTAL_ACC-1];
reg [WIDTH-1 :0] pool_out_1 [0:TOTAL_ACC-1];  
reg [WIDTH-1 :0] pool_out_2 [0:TOTAL_ACC-1];  
reg [1:0] counter;
reg [9:0] index; 
genvar i;
generate
for (i=0; i < TOTAL_ACC ; i=i+1) begin :half_acc
        acc u_i(
        .clk(clk), 
        .clear(clear), 
        .conv10_sample(conv10_sample),
        .pixel(pixel[i]),
        .acc_out(acc_out[i])
        );
    end
 endgenerate
initial begin
   counter = 0;
   index = 0;
   restart = 0;
end
always@(*) begin
   if (en_conv10_1)
      pixel=conv10_1_out;
   else
      pixel=conv10_2_out;   
end
always @(posedge clk ) begin
         for (int i=0 ; i < TOTAL_ACC ; i=i+1) begin
	     pool_out_1[i] <= {{6{acc_out[i][15]}}, acc_out[i][15:6]};
             pool_out_2[i] <= {{6{acc_out[i][15]}}, acc_out[i][15:6]};
end

	if(conv10_2_end) begin
	if(counter>1)begin
	if(index<1024)begin
         pooltomax <= pool_out[index];
         index<=index+1;
	end
      end
      else counter<=counter+1;  
	end
end    
always @(posedge clk ) begin
    if(en_conv10_2)
      restart<=1;  
end
assign clear=en_conv10_2 && !restart;
endmodule
