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
	output reg en_softmax,
	output reg  [WIDTH-1:0] pooltomax 
    );
///////////////////signals//////////////////////////  
wire clear;
reg restart;
reg [WIDTH-1 :0] pixel [0:TOTAL_ACC-1];  
reg [WIDTH-1 :0] acc_out [0:TOTAL_ACC-1];
reg [WIDTH-1 :0] pool_out1 [0:TOTAL_ACC-1]; 
reg [WIDTH-1 :0] pool_out2 [0:TOTAL_ACC-1];   
reg en_pool_out1;
reg [1:0] counter1;
reg [1:0] counter2;
reg [8:0] index1; 
reg [8:0] index2; 
reg flag_index1;
reg flag_index2;
genvar i;
generate
for (i=0; i < TOTAL_ACC ; i=i+1) begin :half_acc
        half_acc u_i(
        .clk(clk), 
        .clear(clear), 
        .conv10_sample(conv10_sample),
        .pixel(pixel[i]),
        .acc_out(acc_out[i])
        );
    end
 endgenerate
initial begin
   counter1 = 0;
   counter2 = 0;
   index1 = 0;
   index2 = 0;
   restart = 0;
   en_softmax=0;
   flag_index1=0;
   flag_index2=0;
end
always@(*) begin
   if (en_conv10_1)
      pixel=conv10_1_out;
   else
      pixel=conv10_2_out;   
end
always @(posedge clk ) begin
    if(en_conv10_1)begin
         for (int i=0 ; i < TOTAL_ACC ; i=i+1) begin
	     pool_out1[i] = {{6{acc_out[i][15]}}, acc_out[i][15:6]};
             
        end
        end
        else begin
        for (int i=0 ; i < TOTAL_ACC ; i=i+1) begin
        pool_out2[i] = {{6{acc_out[i][15]}}, acc_out[i][15:6]};
        end
        end
  
end    
always @(posedge clk ) begin
   if(conv10_1_end && !flag_index1)begin
          if(counter1>1)begin
               en_softmax<=1;
               pooltomax <= pool_out1[index1];
               index1<=index1+1;
         end
         else counter1<=counter1+1;
         if( index1>510)
            flag_index1<=1;
   end 
   else if(conv10_2_end&& !flag_index2)begin 
      if(counter2>1)begin
              en_softmax<=1;
              pooltomax <= pool_out2[index2];
              index2<=index2+1;
      end
      else counter2<=counter2+1;  
      if( index2>510)
            flag_index2<=1;
   end
   else  en_softmax<=0;      
end

always @(posedge clk ) begin
    if(en_conv10_2)
      restart<=1;  
end

assign clear=en_conv10_2 && !restart;

endmodule
