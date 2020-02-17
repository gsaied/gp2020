module fire2_3Expand1x1_tb;
parameter WOUT = 64;
	parameter DSP_NO = 64;
	parameter W_IN = 64;
	parameter WIDTH = 16 ;
	parameter CHIN = 16 ;
	parameter KERNEL_DIM = 1 ;
	parameter CHOUT = 64   ;
reg clk;
reg rst;
reg fire2_expand_1_en;
reg fire3_expand_1_en;
reg [15:0] ifm_2;
//reg [15:0] ifm_3;
reg ram_feedback;
wire fire2_expand_1_finish;
wire fire3_expand_1_finish;
wire [15:0] ofm_2 [0:DSP_NO-1];
wire [15:0] ofm_3 [0:DSP_NO-1];
int fw_2,fw_3;
reg clr_pulse = fire2_3_expand_1.clr_pulse ; 
reg q ; 
reg [15:0] python [0:2**22] ; 
initial begin
	$readmemb("in_fire3Expand_MOD.txt",python) ; 
end

int addr=0; 
reg [15:0] python_in ;
///////////////////////////
 always @(posedge clk)
 q <= clr_pulse ;

always @(posedge clk ) begin
   
	if (!rst) begin
		addr <= 0 ; 
		python_in<= python[addr] ;
	end
	else begin
	   if (fire3_expand_1_en) begin
	    python_in<= python[addr] ;
		addr<= addr +1 ; 
		end
	end
end///////
fire2_3_expand_1 fire3_3_expand_1tb(.clk(clk),.rst(rst),.ram_feedback(ram_feedback),.fire2_expand_1_en(fire2_expand_1_en),.fire3_expand_1_en(fire3_expand_1_en),.ifm_2(ifm_2),.ifm_3(python_in),.fire2_expand_1_finish(fire2_expand_1_finish),.fire3_expand_1_finish(fire3_expand_1_finish),.ofm_2(ofm_2),.ofm_3(ofm_3),.fire2_expand_1_sample(clr_pulse)); 

always begin 
#5
clk= ~clk;
end

initial begin 
fw_2= $fopen("out_fire2Expand4.txt","w");
fw_3= $fopen("out_fire3Expand.txt","w");
end

initial begin 
clk=0;
fire2_expand_1_en=0;
ram_feedback=0;
rst = 1 ;
#5 rst = 0 ; 
#20 rst=1;
#30 fire3_expand_1_en=1;


end 

always @(posedge q) begin

    if (!fire3_expand_1_finish ) 
    begin
        for (int i=0;i<64;i++)
             begin
                $fwrite(fw_3,"%b\n",ofm_3[i]);
                $display("ofm[k]=%b",ofm_3[i]); 
             end
    end
end


endmodule
