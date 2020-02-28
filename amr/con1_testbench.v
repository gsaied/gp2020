module con1_testbench#(
    parameter RAM_NUM1=64,
    parameter RAM_NUM2=16,
    parameter num_instances=8,
	parameter WIDTH= 16 ,
	parameter ADDRESS= 10,
)(
	input clk,
	input rst,
	input start, //PIN
	output final_finish_o
);
conv1 conv1layer(
	.clk(clk),
	.rst(rst),
	.conv1_en(enconv1),//elmafrood start bs 3ayzeen ne2fl el enable
	.conv1_end(conv1_end),
	.ram_feedback(squeeze2_end),
	.ofm(conv1out),
	.conv1_sample(clkconv1)
);
always @(posedge clk or negedge rst) begin
	if (!rst)
		enconv1<=0 ; 
	else if (start && !conv1_end)
		enconv1<=1 ;
	else
		en_conv1<=0 ;
end

fire2_3_expand_1 u_2(
	.clk(clk),
	.rst(rst),
	.ram_feedback_2(squeeze3_end),
	.ram_feedback_3(squeeze4_end),
	.fire2_expand_1_en(enexpand2),
	.fire2_expand_1_en(en_expand3),
	.ifm_2(expand21x1in),
	.ifm_3(expand31x1in),
	.ofm_2(expand21x1out),
	.ofm_3(expand31x1out),
	.fire2_expand_1_sample(clkexpand21x1)
); 
fire4_5_expand_1 u_3(
	.clk(clk),
	.rst(rst),
	.ram_feedback_4(squeeze5_end),
	.ram_feedback_5(squeeze6_end),
	.fire4_expand_1_en(enexpand4),
	.fire5_expand_1_en(enexpand5),
	.ifm_4(expand41x1in),
	.ifm_5(expand51x1in),
	.ofm_4(expand41x1out),
	.ofm_5(expand51x1out),
	.fire4_expand_1_sample(clkexpand41x1)
) ;

fire2_3_expand_3 fire3_3_expand_3tb(
	.clk(clk),
	.rst(rst),
	.ram_feedback_2(squeeze3_end),
	.ram_feedback_3(squeeze4_end),
	.fire2_expand_3_en(enexpand2),
	.fire3_expand_3_en(en_expand3),
	.ifm_2(expand23x3in),
	.ifm_3(expand33x3in),
	.ofm_2(expand23x3out),
	.ofm_3(expand33x3out),
	.fire3_expand_3_finish(expand3_end),
	.fire2_expand_3_finish(expand2_end),
	.fire2_expand_3_sample(clkexpand23x3)
);
fire2_squeeze_3 fire2_squeeze_3tb(
	.clk(clk),
	.rst(rst),
	.ram_feedback(expand2_end),
	.fire2_squeeze_3_en(ensqueeze2),
	.ifm(squeeze2in),
	.fire2_squeeze_3_end(squeeze2_end),
	.ofm(squeeze2out),.fire2_squeeze_3_sample(clksqueeze2) 
);
	reg clk;
	reg rst;
	reg conv1_end; 
	wire expand2_end;
	wire expand3_end;
	wire expand4_end;
	wire expand5_end;
	wire expand6_end;
	wire expand7_end;
	wire expand8_end;
	wire expand9_end;
	wire clr_pulse;
    wire squeeze2_end;
    wire squeeze3_end;
    wire squeeze4_end;
    wire squeeze5_end;
    wire squeeze6_end;
    wire squeeze7_end;
    wire squeeze8_end;
    wire squeeze9_end;
    wire conv10_1end;
    reg [width-1:0] squeeze2out[0:ram_num2-1];
    reg [width-1:0] squeeze3out[0:ram_num2-1];
    reg [width-1:0] squeeze4out[0:2*ram_num2-1];
    reg [width-1:0] squeeze5out[0:2*ram_num2-1];
    reg [width-1:0] squeeze6out[0:4*ram_num2-1];
    reg [width-1:0] squeeze7out[0:4*ram_num2-1];
    reg [width-1:0] squeeze8out[0:7*ram_num2-1];
    reg [width-1:0] squeeze9out[0:7*ram_num2-1];
    reg [width-1:0] conv10_1out[0:32*ram_num2-1];
    reg [width-1:0] conv10_2out[0:32*ram_num2-1];
reg q;
always@(posedge clk) 
q<=clr_pulse;
int f,i,k,ff,r,g;
wire[width-1:0] conv1out[0:ram_num1-1];
wire [width-1:0] expand21x1out[0:ram_num1-1];
wire [width-1:0] expand23x3out[0:ram_num1-1];
wire [width-1:0] expand31x1out[0:ram_num1-1];
wire [width-1:0] expand33x3out[0:ram_num1-1];
wire [width-1:0] expand41x1out[0:2*ram_num1-1];
wire [width-1:0] expand43x3out[0:2*ram_num1-1];
wire [width-1:0] expand51x1out[0:2*ram_num1-1];
wire [width-1:0] expand53x3out[0:2*ram_num1-1];
wire [width-1:0] expand61x1out[0:4*ram_num1-1];
wire [width-1:0] expand63x3out[0:4*ram_num1-1];
wire [width-1:0] expand71x1out[0:3*ram_num1-1];
wire [width-1:0] expand73x3out[0:3*ram_num1-1];
wire [width-1:0] expand81x1out[0:4*ram_num1-1];
wire [width-1:0] expand83x3out[0:4*ram_num1-1];
wire [width-1:0] expand91x1out[0:368-1];
wire [width-1:0] expand93x3out[0:368-1];
wire clkconv1;
wire clkexpand21x1;
wire clkexpand23x3;
wire clkexpand31x1;
wire clkexpand33x3;
wire clkexpand41x1;
wire clkexpand43x3;
wire clkexpand51x1;
wire clkexpand53x3;
wire clkexpand61x1;
wire clkexpand63x3;
wire clkexpand71x1;
wire clkexpand73x3;
wire clkexpand81x1;
wire clkexpand83x3;
wire clkexpand91x1;
wire clkexpand93x3;
wire clksqueeze2;
wire clksqueeze3;
wire clksqueeze4;
wire clksqueeze5;
wire clksqueeze6;
wire clksqueeze7;
wire clksqueeze8;
wire clksqueeze9;
wire clkconv10_1;
wire clkconv10_2;
reg enconv1;
reg enexpand2=0;
reg ensqueeze2=0;
reg ensqueeze21=0;
reg en_expand3=0;
reg ensqueeze3=0;
reg enexpand4=0;
wire ensqueeze4=0;
reg enexpand5=0;
wire ensqueeze5=0;
wire enexpand6=0;
wire ensqueeze6=0;
wire enexpand7=0;
wire ensqueeze7=0;
wire enexpand8=0;
wire ensqueeze8=0;
wire enexpand9=0;
wire ensqueeze9=0;
wire enconv10_1=0;
wire enconv10_2=0;
wire [width-1:0] expand21x1in;
wire [width-1:0] expand31x1in;
wire [width-1:0] expand41x1in;
wire [width-1:0] expand51x1in;
wire [width-1:0] expand61x1in;
wire [width-1:0] expand71x1in;
wire [width-1:0] expand81x1in;
wire [width-1:0] expand91x1in;
wire [width-1:0] expand23x3in;
wire [width-1:0] expand33x3in;
wire [width-1:0] expand43x3in;
wire [width-1:0] expand53x3in;
wire [width-1:0] expand63x3in;
wire [width-1:0] expand73x3in;
wire [width-1:0] expand83x3in;
wire [width-1:0] expand93x3in;
wire [width-1:0] squeeze2in;
wire [width-1:0] squeeze3in;
wire [width-1:0] squeeze4in;
wire [width-1:0] squeeze5in;
wire [width-1:0] squeeze6in;
wire [width-1:0] squeeze7in;
wire [width-1:0] squeeze8in;
wire [width-1:0] squeeze9in;
wire [width-1:0] conv10_1in;
wire [width-1:0] conv10_2in;
wire [width-1:0] doutb1 [0:16][0:ram_num1-1];
wire [width-1:0] doutb2 [0:38][0:ram_num2-1];

temp BRAM1(
.clk(clk),
.rst(rst),
.conv1(conv1out),
.expand21x1(expand21x1out),
.expand31x1(expand31x1out),
.expand41x1(expand41x1out),
.expand51x1(expand51x1out),
.expand61x1(expand61x1out),
.expand71x1(expand71x1out),
.expand81x1(expand81x1out),
.expand91x1(expand91x1out),
.expand23x3(expand23x3out),
.expand33x3(expand33x3out),
.expand43x3(expand43x3out),
.expand53x3(expand53x3out),
.expand63x3(expand63x3out),
.expand73x3(expand73x3out),
.expand83x3(expand83x3out),
.expand93x3(expand93x3out),
.clkconv1(clkconv1),
.clkexpand21x1(clkexpand21x1),
.clkexpand23x3(clkexpand23x3),
.clkexpand31x1(clkexpand31x1),
.clkexpand33x3(clkexpand33x3),
.clkexpand41x1(clkexpand41x1),
.clkexpand43x3(clkexpand43x3),
.clkexpand51x1(clkexpand51x1),
.clkexpand53x3(clkexpand53x3),
.clkexpand61x1(clkexpand61x1),
.clkexpand63x3(clkexpand63x3),
.clkexpand71x1(clkexpand71x1),
.clkexpand73x3(clkexpand73x3),
.clkexpand81x1(clkexpand81x1),
.clkexpand83x3(clkexpand83x3),
.clkexpand91x1(clkexpand91x1),
.clkexpand93x3(clkexpand93x3),
.enconv1(enconv1),
.enexpand2(enexpand2),
.conv1_end(conv1_end),
.expand2_end(expand2_end),
.expand3_end(expand3_end),
.expand4_end(expand4_end),
.expand5_end(expand5_end),
.expand6_end(expand6_end),
.expand7_end(expand7_end),
.expand8_end(expand8_end),
.expand9_end(expand9_end),
.en_expand3(en_expand3),
.ensqueeze3(ensqueeze3),
.enexpand4(enexpand4),
.ensqueeze4(ensqueeze4),
.enexpand5(enexpand5),
.ensqueeze5(ensqueeze5),
.enexpand6(enexpand6),
.ensqueeze6(ensqueeze6),
.enexpand7(enexpand7),
.ensqueeze7(ensqueeze7),
.enexpand8(enexpand8),
.ensqueeze8(ensqueeze8),
.enexpand9(enexpand9),
.ensqueeze9(ensqueeze9),
.conv10_1end(conv10_1end),
.enconv10_1(enconv10_1),
.enconv10_2(enconv10_2),
.ensqueeze2(ensqueeze2),
.squeeze2(squeeze2in),
.squeeze3(squeeze3in),
.squeeze4(squeeze4in),
.squeeze5(squeeze5in),
.squeeze6(squeeze6in),
.squeeze7(squeeze7in),
.squeeze8(squeeze8in),
.squeeze9(squeeze9in),
.conv10_1(conv10_1in),
.conv10_2(conv10_2in),
.doutb(doutb1)
);
SecondSharedMemory BRAM2(
.clk(clk),
.rst(rst),
.squeeze2(squeeze2out),
.squeeze3(squeeze3out),
.squeeze4(squeeze4out),
.squeeze5(squeeze5out),
.squeeze6(squeeze6out),
.squeeze7(squeeze7out),
.squeeze8(squeeze8out),
.squeeze9(squeeze9out),
.conv10_1(conv10_1out),
.conv10_2(conv10_2out),
.clksqueeze2(clksqueeze2),
.clksqueeze3(clksqueeze3),
.clksqueeze4(clksqueeze4),
.clksqueeze5(clksqueeze5),
.clksqueeze6(clksqueeze6),
.clksqueeze7(clksqueeze7),
.clksqueeze8(clksqueeze8),
.clksqueeze9(clksqueeze9),
.clkconv10_1(clkconv10_1),
.clkconv10_2(clkconv10_2),
.ensqueeze2(ensqueeze2),
.squeeze2_end(squeeze2_end),//squeeze2 has finished
.ensqueeze3(ensqueeze3),
.squeeze3_end(squeeze3_end),
.ensqueeze4(ensqueeze4),
.squeeze4_end(squeeze4_end),
.ensqueeze5(ensqueeze5),
.squeeze5_end(squeeze5_end),
.ensqueeze6(ensqueeze6),
.squeeze6_end(squeeze6_end),
.ensqueeze7(ensqueeze7),
.squeeze7_end(squeeze7_end),
.ensqueeze8(ensqueeze8),
.squeeze8_end(squeeze8_end),
.ensqueeze9(ensqueeze9),
.squeeze9_end(squeeze9_end),
.conv10_1end(conv10_1end),
.enconv10_1(enconv10_1),
.enconv10_2(enconv10_2),
.enexpand2(enexpand2),
.en_expand3(en_expand3),
.enexpand4(enexpand4),
.enexpand5(enexpand5),
.enexpand6(enexpand6),
.enexpand7(enexpand7),
.enexpand8(enexpand8),
.enexpand9(enexpand9),
.expand21x1(expand21x1in),
.expand23x3(expand23x3in),
.expand31x1(expand31x1in),
.expand33x3(expand33x3in),
.expand41x1(expand41x1in),
.expand43x3(expand43x3in),
.expand51x1(expand51x1in),
.expand53x3(expand53x3in),
.expand61x1(expand61x1in),
.expand63x3(expand63x3in),
.expand71x1(expand71x1in),
.expand73x3(expand73x3in),
.expand81x1(expand81x1in),
.expand83x3(expand83x3in),
.expand91x1(expand91x1in),
.expand93x3(expand93x3in),
.doutb (doutb2));
reg [15:0] python [0:2**22] ; 
initial begin
	$readmemb("in_fire2Squeeze3x3_MOD.txt",python) ; 
end

int addr=0; 
reg [15:0] python_in ;
///////////////////////////
always @(posedge clk ) begin
	if (!rst) begin
		addr <= 0 ; 
		python_in<= python[addr] ;
	end
	else if(ensqueeze21)begin
	    python_in<= python[addr] ;
		addr<= addr +1 ; 
	end
end///////
fire2_3_expand_3 fire3_3_expand_3tb(.clk(clk),.rst(rst),.ram_feedback_2(0),.fire2_expand_3_en(enexpand2),.ifm_2(expand23x3in),.fire2_expand_3_finish(expand2_end),.ofm_2(expand23x3out),.fire2_expand_3_sample(clkexpand23x3)); 

always begin 
#10
clk= ~clk;
end

initial begin 
f= $fopen("squeeze2.txt","w");
g=$fopen("outputsqueeze2.txt","w");
clk=0;
enconv1=0;
rst = 1 ;
#10 rst = 0 ; 
#30 rst=1;
enconv1=1;
//rst=0;
//ensqueeze21=1;
//en_expand3=0;
end 
always @(posedge clk) begin
    begin
        if(conv1_end) enconv1<=0;
        if(squeeze2_end)
         ensqueeze2<=0;
             begin
                $fwrite(f,"%b\n",squeeze2in);
             end

end

end

endmodule
