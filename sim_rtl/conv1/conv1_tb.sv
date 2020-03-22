`timescale 1ns / 1ps
module conv1_tb;
parameter WOUT = 128 ;
parameter DSP_NO = 64 ;
parameter STRIDE = 2 ;
parameter W_IN = 258 ;
parameter WIDTH = 16 ;
parameter CHIN = 3 ; 
parameter KERNEL_DIM = 3;
parameter CHOUT = 64;  
reg clk;
reg conv1_en;
reg ram_feedback;
wire conv1_finish;
wire [15:0] ofm [0:DSP_NO-1];
int f,i,k;
reg clr_pulse = conv1.clr_pulse ; 
reg q ;
wire conv1_hoba ;
assign conv1_hoba = conv1tb.conv1_end ; 
always @(posedge clk)
q <= clr_pulse ; 
conv1 conv1tb(.clk(clk),.conv1_en_i(conv1_en),.ram_feedback(ram_feedback),.conv1_finish(conv1_finish),.ofm(ofm),.conv1_sample(clr_pulse));

always begin 
#5
clk= ~clk;
end
initial begin
f= $fopen("outconv1aa.txt","w");
end
initial begin 
clk=0;
ram_feedback=0;
#50 conv1_en=1;
end 
always @(posedge q) begin
    if (!conv1_hoba) begin
      for(i=0;i<64;i++)begin
        $fwrite(f,"%b\n",ofm[i]);
//        $display("ofm[k]=%b",ofm[i]); 
        end
        
    end
else $stop ;
end
endmodule
 
