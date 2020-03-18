`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2019 09:28:21 AM
// Design Name: 
// Module Name: mem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module FirstSharedMemory#(
    parameter ram_num=64,
    parameter num_instances=8,
	parameter width= 16 ,
	parameter address= 10
)

(
input clk,
input[width-1:0] conv1[0:ram_num-1],
input [width-1:0] expand21x1[0:ram_num-1],
input [width-1:0] expand23x3[0:ram_num-1],
input [width-1:0] expand31x1[0:ram_num-1],
input [width-1:0] expand33x3[0:ram_num-1],
input [width-1:0] expand41x1[0:2*ram_num-1],
input [width-1:0] expand43x3[0:2*ram_num-1],
input [width-1:0] expand51x1[0:2*ram_num-1],
input [width-1:0] expand53x3[0:2*ram_num-1],
input [width-1:0] expand61x1[0:4*ram_num-1],
input [width-1:0] expand63x3[0:4*ram_num-1],
input [width-1:0] expand71x1[0:3*ram_num-1],
input [width-1:0] expand73x3[0:3*ram_num-1],
input [width-1:0] expand81x1[0:4*ram_num-1],
input [width-1:0] expand83x3[0:4*ram_num-1],
input [width-1:0] expand91x1[0:368-1],
input [width-1:0] expand93x3[0:368-1],
input clkconv1,
input clkexpand21x1,
input clkexpand23x3,
input clkexpand31x1,
input clkexpand33x3,
input clkexpand41x1,
input clkexpand43x3,
input clkexpand51x1,
input clkexpand53x3,
input clkexpand61x1,
input clkexpand63x3,
input clkexpand71x1,
input clkexpand73x3,
input clkexpand81x1,
input clkexpand83x3,
input clkexpand91x1,
input clkexpand93x3,
input enconv1,
input conv1_end,//conv1 has finished
input enexpand2,
input expand2_end,
input enexpand3,
input expand3_end,
input enexpand4,
input expand4_end,
input enexpand5,
input expand5_end,
input enexpand6,
input expand6_end,
input enexpand7,
input expand7_end,
input enexpand8,
input expand8_end,
input enexpand9,
input expand9_end,
input conv10_1end,
output reg ensqueeze2,//to start squeeze2
output reg ensqueeze3,//to start squeeze3
output reg ensqueeze4,//to start squeeze4
output reg ensqueeze5,//to start squeeze5
output reg ensqueeze6,//to start squeeze6
output reg ensqueeze7,//to start squeeze7
output reg ensqueeze8,//to start squeeze8
output reg ensqueeze9,//to start squeeze9
output reg enconv10_1,//to start conv10_1
output reg enconv10_2,//to start conv10_2
output reg [width-1:0] squeeze2,
output reg [width-1:0] squeeze3,
output reg [width-1:0] squeeze4,
output reg [width-1:0] squeeze5,
output reg [width-1:0] squeeze6,
output reg [width-1:0] squeeze7,
output reg [width-1:0] squeeze8,
output reg [width-1:0] squeeze9,
output reg [width-1:0] conv10_1,
output reg [width-1:0] conv10_2,
output reg [width-1:0] doutb [0:2*num_instances][0:ram_num-1]
    );

   
reg clock1;
reg clock2;
reg [1:0] rw;
reg [address-1:0] addra1 [0:ram_num-1];
reg [address-1:0] addrb [0:ram_num-1];
reg [address-1:0] addra2 [0:ram_num-1];
reg [width-1:0] dina1 [0:num_instances-1][0:ram_num-1];
reg [width-1:0] douta [0:2*num_instances][0:ram_num-1];
reg [width-1:0] dina2 [0:num_instances][0:ram_num-1];
reg [ram_num-1:0] ena2[0:num_instances];
reg [ram_num-1:0] web;
reg [ram_num-1:0] enb;
reg [ram_num-1:0] wea1[0:num_instances-1];
reg [ram_num-1:0] wea2[0:num_instances];
reg [ram_num-1:0] ena1[0:num_instances-1];
   
genvar i;
generate // 2 ram blocks ,each contains 8 instances . port a signals are used , port b signals aren't used.
    for (i=0; i < num_instances ; i=i+1) begin :ram_3d1 
        ram_3d #(
        .ram_num(ram_num),
        .width(width),
        .address(address))
        u(
        .clk(clk), 
        .wea(wea1[i]), 
        .ena(ena1[i]), 
        .web(web), 
        .enb(enb), 
        .addra(addra1),
        .addrb(addrb),
	.dinb('{default:16'b0}),
        .dina(dina1[i]),
        .douta(douta[i]),
        .doutb(doutb[i])
        );
    end



    for (i=0; i < num_instances+1 ; i=i+1) begin :ram_3d2 
        ram_3d #(
        .ram_num(ram_num),
        .width(width),
        .address(address))
        u(
        .clk(clk), 
        .wea(wea2[i]), 
        .ena(ena2[i]), 
        .web(web), 
        .enb(enb), 
        .addra(addra2),
        .addrb(addrb),
        .dina(dina2[i]),
	.dinb('{default:16'b0}),
        .douta(douta[i+8]),
        .doutb(doutb[i+8])
        );
    end
    
    
endgenerate

/////////// write signals
reg[2:0] set1_counter=0; 
reg[3:0] set2_counter=0;
reg flag1=0;
reg flag2=0;
reg flag3=0;
reg flag4=0;
reg [6:0] ram_numcounter;
reg [2:0] norm_numofchannels;
reg conv1rst,squeeze2rst,expand2rst,squeeze3rst,expand3rst,squeeze4rst,expand4rst,squeeze5rst,expand5rst,squeeze6rst,expand6rst,squeeze7rst,expand7rst,squeeze8rst,expand8rst,squeeze9rst,expand9rst,conv10_1rst,conv10_2rst=1;
reg[9:0] startdata;
wire newlayer;
//wire readinglayer;
reg flagreset;
/////////////// read signals
reg[14:0] index;//real index in ram
reg[14:0] index_shifted;//real index in ram
reg[14:0] win;// first index in windows
reg[14:0] winref;
reg[11:0] numwin;//total number of windows
reg[7:0] rowcounter1;//to put internal padding
reg[7:0] rowcounter2;//to put internal padding
reg[5:0] rowwin;///////////////number of windows
reg[5:0] countwin;//number of windows on a row
reg[5:0] channels;
reg[5:0] channels1;
reg[5:0] channels2;
reg[5:0] channels3;
reg[4:0] a0;
reg[4:0] a1;
reg[1:0] stride_squeeze;//////////////stride for each reading layer
reg[11:0] no_of_win_squeeze; /////////no of win for each reading
reg[7:0] lengthofrow;///////////no of elements in row
reg[9:0] channels_counter;////////count no of channels
reg[9:0] numchannels;/////////total no of input channels for each reading layer
reg[1:0] rowfilter;////////no of rows in the filter
reg[1:0] colfilter;////////no of cols in the filter
reg[1:0] row,col;
reg [2:0] startcounter;//after 4 cycles 
reg flagread;//enable reading
reg flagread_shifted;
reg flagread_shiftedagain;
reg flagread_shiftedagainagain;
reg resetmem;//initialize memory with zeros
reg[14:0] truncated_index;//index for new ram
reg shift1conv1;
reg shift2conv1;
reg shift1expand2;
reg shift2expand2;
reg shift1squeeze2;
reg shift2squeeze2;
reg shift1expand3;
reg shift2expand3;
reg shift1squeeze3;
reg shift2squeeze3;
reg shift1expand4;
reg shift2expand4;
reg shift1squeeze4;
reg shift2squeeze4;
reg shift1expand5;
reg shift2expand5;
reg shift1squeeze5;
reg shift2squeeze5;
reg shift1expand6;
reg shift2expand6;
reg shift1squeeze6;
reg shift2squeeze6;
reg shift1expand7;
reg shift2expand7;
reg shift1squeeze7;
reg shift2squeeze7;
reg shift1expand8;
reg shift2expand8;
reg shift1squeeze8;
reg shift2squeeze8;
reg shift1expand9;
reg shift2expand9;
reg shift1squeeze9;
reg shift2squeeze9;
reg shift1conv10_1;
reg shift2conv10_1;
reg shift1conv10_2;
reg shift2conv10_2;
reg conv1_endshifted;
reg expand2_endshifted;
reg expand3_endshifted;
reg expand4_endshifted;
reg expand5_endshifted;
reg expand6_endshifted;
reg expand7_endshifted;
reg expand8_endshifted;
reg expand9_endshifted;
reg conv10_endshifted;
always@(posedge clk)begin
conv1_endshifted<=conv1_end;
expand2_endshifted<=expand2_end;
expand3_endshifted<=expand3_end;
expand4_endshifted<=expand4_end;
expand5_endshifted<=expand5_end;
expand6_endshifted<=expand6_end;
expand7_endshifted<=expand7_end;
expand8_endshifted<=expand8_end;
expand9_endshifted<=expand9_end;
conv10_endshifted<=conv10_1end;
end
   initial begin
        
        shift1conv1=1;
        shift2conv1=1;
        conv1rst=1;
        shift1expand2=1;
        shift2expand2=1;
        expand2rst=1;
        shift1squeeze2=1;
        shift2squeeze2=1;
        squeeze2rst=1;
        shift1expand3=1;
        shift2expand3=1;
        expand3rst=1;
        shift1squeeze3=1;
        shift2squeeze3=1;
        squeeze3rst=1;
        shift1expand4=1;
        shift2expand4=1;
        expand4rst=1;
        shift1squeeze4=1;
        shift2squeeze4=1;
        squeeze4rst=1;
        shift1expand5=1;
        shift2expand5=1;
        expand5rst=1;
        shift1squeeze5=1;
        shift2squeeze5=1;
        squeeze5rst=1;
        shift1expand6=1;
        shift2expand6=1;
        expand6rst=1;
        shift1squeeze6=1;
        shift2squeeze6=1;
        squeeze6rst=1;
        shift1expand7=1;
        shift2expand7=1;
        expand7rst=1;
        shift1squeeze7=1;
        shift2squeeze7=1;
        squeeze7rst=1;
        shift1squeeze8=1;
        shift2squeeze8=1;
        squeeze8rst=1;
        shift1expand8=1;
        shift2expand8=1;
        expand8rst=1;
        shift1squeeze8=1;
        shift2squeeze8=1;
        squeeze9rst=1;
        shift1expand9=1;
        shift2expand9=1;
        expand9rst=1;
        shift1squeeze9=1;
        shift2squeeze9=1;
        squeeze9rst=1;
        shift1conv10_2=1;
        shift2conv10_2=1;
        conv10_2rst=1;
        shift1conv10_1=1;
        shift2conv10_1=1;
        conv10_1rst=1;
        set1_counter=0;
        flag1=0;
        flag2=0;
        flag3=0;
        set2_counter=0;
        rowcounter1=0;
        rowcounter2=0;
        resetmem=0;
        flag4=0;
        flagreset=0;
       
        for(int addressrams_counter=0;addressrams_counter<ram_num;addressrams_counter++) begin
        
            addra1[addressrams_counter]=10'b1111111111;
            addra2[addressrams_counter]=10'b1111111111;
            for(int instances_counter=0;instances_counter<num_instances;instances_counter++) begin
                ena1[instances_counter][addressrams_counter]=0;
                ena2[instances_counter][addressrams_counter]=0;
                wea1[instances_counter][addressrams_counter]=0;
                wea2[instances_counter][addressrams_counter]=0;
                enb[addressrams_counter]=0;
                web[addressrams_counter]=0;
            end
            ena2[8][addressrams_counter]=0;
            wea2[8][addressrams_counter]=0;
            ensqueeze2=0;
        ensqueeze3=0;
        ensqueeze4=0;
        ensqueeze5=0;
        ensqueeze6=0;
        ensqueeze7=0;
        ensqueeze8=0;
        ensqueeze9=0;
        enconv10_1=0;
        enconv10_2=0;
        startcounter=0;
        squeeze2=0;
        squeeze3=0;
        squeeze4=0;
        squeeze5=0;
        squeeze6=0;
        squeeze7=0;
        squeeze8=0;
        squeeze9=0;
        conv10_1=0;
        conv10_2=0;
        index_shifted=0;
        truncated_index=0;
        end
   end
/////////// reset signals control for all layers
always@(posedge clk ) begin
    if(enconv1)begin
        shift1conv1<=0;
        shift2conv1<=shift1conv1;
        conv1rst<=shift2conv1;
        end
end
always@(posedge clk  ) begin
   if(enexpand2)begin
        shift1expand2<=0;
        shift2expand2<=shift1expand2;
        expand2rst<=shift2expand2;
        end
    end
always@(posedge clk  ) begin
    if(conv1_endshifted)begin
        shift1squeeze2<=0;
        shift2squeeze2<=shift1squeeze2;
        squeeze2rst<=shift2squeeze2;
    end
end
always@(posedge clk  ) begin
    if(enexpand3)begin
        shift1expand3<=0;
        shift2expand3<=shift1expand3;
        expand3rst<=shift2expand3;
        end
    end
always@(posedge clk  ) begin
    if(expand2_endshifted)begin
        shift1squeeze3<=0;
        shift2squeeze3<=shift1squeeze3;
        squeeze3rst<=shift2squeeze3;
    end
end
always@(posedge clk  ) begin
    if(enexpand4)begin
        shift1expand4<=0;
        shift2expand4<=shift1expand4;
        expand4rst<=shift2expand4;
        end
    end
always@(posedge clk  ) begin
    if(expand3_endshifted)begin
        shift1squeeze4<=0;
        shift2squeeze4<=shift1squeeze4;
        squeeze4rst<=shift2squeeze4;
    end
end
always@(posedge clk  ) begin
    if(enexpand5)begin
        shift1expand5<=0;
        shift2expand5<=shift1expand5;
        expand5rst<=shift2expand5;
        end
    end
always@(posedge clk  ) begin
    if(expand4_endshifted)begin
        shift1squeeze5<=0;
        shift2squeeze5<=shift1squeeze5;
        squeeze5rst<=shift2squeeze5;
    end
end
always@(posedge clk  ) begin
    if(enexpand6)begin
        shift1expand6<=0;
        shift2expand6<=shift1expand6;
        expand6rst<=shift2expand6;
        end
    end
always@(posedge clk  ) begin
    if(expand5_endshifted)begin
        shift1squeeze6<=0;
        shift2squeeze6<=shift1squeeze6;
        squeeze6rst<=shift2squeeze6;
    end
end
always@(posedge clk  ) begin
    if(enexpand7)begin
        shift1expand7<=0;
        shift2expand7<=shift1expand7;
        expand7rst<=shift2expand7;
        end
    end
always@(posedge clk  ) begin
    if(expand6_endshifted)begin
        shift1squeeze7<=0;
        shift2squeeze7<=shift1squeeze7;
        squeeze7rst<=shift2squeeze7;
    end
end
always@(posedge clk  ) begin
    if(enexpand8)begin
        shift1expand8<=0;
        shift2expand8<=shift1expand8;
        expand8rst<=shift2expand8;
        end
    end
always@(posedge clk  ) begin
    if(expand7_endshifted)begin
        shift1squeeze8<=0;
        shift2squeeze8<=shift1squeeze8;
        squeeze8rst<=shift2squeeze8;
    end
end
always@(posedge clk  ) begin
    if(enexpand9)begin
        shift1expand9<=0;
        shift2expand9<=shift1expand9;
        expand9rst<=shift2expand9;
        end
    end
always@(posedge clk  ) begin
    if(expand8_endshifted)begin
        shift1squeeze9<=0;
        shift2squeeze9<=shift1squeeze9;
        squeeze9rst<=shift2squeeze9;
    end
end
always@(posedge clk  ) begin
    if(expand9_endshifted)begin
        shift1conv10_1<=0;
        shift2conv10_1<=shift1conv10_1;
        conv10_1rst<=shift2conv10_1;
        end
end
always@(posedge clk  ) begin
    if(conv10_endshifted)begin
        shift1conv10_2<=0;
        shift2conv10_2<=shift1conv10_2;
        conv10_2rst<=shift2conv10_2;
        end
end
///////////////////////////////////end of reset signals
      assign  newlayer=(enconv1 && conv1rst)|| (enexpand2 && expand2rst)|| (conv1_endshifted && squeeze2rst)|| (enexpand3 && expand3rst)|| (expand2_endshifted && squeeze3rst)|| (enexpand4 && expand4rst)|| (expand3_endshifted && squeeze4rst)|| (enexpand5 && expand5rst)|| (expand4_endshifted && squeeze5rst)|| (enexpand6 && expand6rst)|| (expand5_endshifted && squeeze6rst)|| (enexpand7 && expand7rst)|| (expand6_endshifted && squeeze7rst)|| (enexpand8 && expand8rst)|| (expand7_endshifted && squeeze8rst)|| (enexpand9 && expand9rst)|| (expand8_endshifted && squeeze9rst)|| (expand9_endshifted && conv10_1rst)||(conv10_endshifted&&conv10_2rst);

////////////////////////////////////////////////////////first shared memory/////////////////////////////////////////////////////////////////////////////////////////////////////
// layer selection ,clock and input contection to ram  
always@(*) begin

   //case({enconv1,enexpand2,enexpand23x3,conv1_endshifted,enexpand3,enexpand33x3,ensqueeze3,enexpand4,enexpand43x3,ensqueeze4,enexpand5,enexpand53x3,ensqueeze5,enexpand6,enexpand63x3,ensqueeze6,enexpand7,enexpand73x3,ensqueeze7,enexpand8,enexpand83x3,ensqueeze8,enexpand9,enexpand93x3,ensqueeze9,enconv10_1,enconv10_2}) 
   case({enconv1,enexpand2,enexpand3,enexpand4,enexpand5,enexpand6,enexpand7,enexpand8,enexpand9,conv1_endshifted,expand2_endshifted,expand3_endshifted,expand4_endshifted,expand5_endshifted,expand6_endshifted,expand7_endshifted,expand8_endshifted,expand9_endshifted,conv10_endshifted}) 
        19'b1000000000000000000: begin//conv1 128*128*64 needs 1024 BRAMs
           clock1 = clkconv1;
           clock2 = clkconv1;
           rw=1;
           startdata=130;
           rowwin=0;
           stride_squeeze=0;
           no_of_win_squeeze=0; 
           lengthofrow=127;
           numchannels=0;
           norm_numofchannels=1;
           rowfilter=0;
           colfilter=0;

           for ( int i = 0 ; i < num_instances ; i++) begin
               dina1[i]=conv1;
               dina2[i]=conv1;
           end
           dina2[8]=conv1;
        end
        
        
        19'b0100000000000000000:begin//fire2 expand 64*64*16 needs 64 BRAMs
           clock1 = clkexpand21x1;
           clock2 = clkexpand23x3;
           rw=1;
           startdata=-1;
           rowwin=0;
           stride_squeeze=0;
           no_of_win_squeeze=0; 
           lengthofrow=1;
           numchannels=0;
           rowfilter=0;
           norm_numofchannels=1;
           colfilter=0;

	       for ( int i = 0 ; i < num_instances ; i++) begin
               dina1[i]=expand21x1;
               dina2[i]=expand23x3;
           end
           dina2[8]=expand23x3;
           
        end
        
        19'b0010000000000000000:begin//fire3 expand 64*64*16 needs 64 BRAMs
           clock1 = clkexpand31x1;
           clock2 = clkexpand33x3;
           rw=1;
           startdata=66;
           rowwin=0;
           numchannels=0;
           stride_squeeze=0;
           no_of_win_squeeze=0; 
           lengthofrow=63;
           norm_numofchannels=1;
           rowfilter=0;
           colfilter=0;

           for ( int i = 0 ; i < num_instances ; i++) begin
               dina1[i]=expand31x1;
               dina2[i]=expand33x3;
           end
           dina2[8]=expand33x3;
       
        end   
        
        19'b0001000000000000000:begin//fire4 expand 32*32*32 needs 32 BRAMs
           clock1 = clkexpand41x1;
           clock2 = clkexpand43x3;
           rw=1;
           startdata=-1;
           rowwin=0;
           numchannels=0;
           stride_squeeze=0;
           no_of_win_squeeze=0; 
           lengthofrow=1;
           rowfilter=0;
           norm_numofchannels=2;
           colfilter=0;

	       for ( int i = 0 ; i < num_instances ; i=i+2) begin
               dina1[i]=expand41x1[0:ram_num-1];
               dina1[i+1]=expand41x1[ram_num:2*ram_num-1];
               dina2[i]=expand43x3[0:ram_num-1];
               dina2[i+1]=expand43x3[ram_num:2*ram_num-1];
           end
           dina2[8]=expand43x3[0:ram_num-1];
        end 
        
        19'b0000100000000000000:begin//fire5 expand 32*32*32 needs 32 BRAMs
           clock1 = clkexpand51x1;
           clock2 = clkexpand53x3;
           rw=1;
           startdata=34;
           rowwin=0;
           norm_numofchannels=2;
           numchannels=0;
           stride_squeeze=0;
           no_of_win_squeeze=0; 
           lengthofrow=31;
           rowfilter=0;
           colfilter=0;

	       for ( int i = 0 ; i < num_instances ; i=i+2) begin
               dina1[i]=expand51x1[0:ram_num-1];
               dina1[i+1]=expand51x1[ram_num:2*ram_num-1];
               dina2[i]=expand53x3[0:ram_num-1];
               dina2[i+1]=expand53x3[ram_num:2*ram_num-1];
           end
           dina2[8]=expand53x3[0:ram_num-1];
        end 
        
        19'b0000010000000000000:begin//fire6 expand 64*16*16 needs 16 BRAMs
           clock1 = clkexpand61x1;
           clock2 = clkexpand63x3;
           rw=1;
           startdata=-1;
           rowwin=0;
           numchannels=0;
           stride_squeeze=0;
           no_of_win_squeeze=0; 
           lengthofrow=1;
           rowfilter=0;
           norm_numofchannels=4;
           colfilter=0;

	       for ( int i = 0 ; i < num_instances ; i=i+4) begin
               dina1[i]=expand61x1[0:ram_num-1];
               dina1[i+1]=expand61x1[ram_num:2*ram_num-1];
               dina1[i+2]=expand61x1[2*ram_num:3*ram_num-1];
               dina1[i+3]=expand61x1[3*ram_num:4*ram_num-1];
               dina2[i]=expand63x3[0:ram_num-1];
               dina2[i+1]=expand63x3[ram_num:2*ram_num-1];
               dina2[i+2]=expand63x3[2*ram_num:3*ram_num-1];
               dina2[i+3]=expand63x3[3*ram_num:4*ram_num-1];
           end
           dina2[8]=expand63x3[0:ram_num-1];
        end 
        
        19'b0000001000000000000:begin//fire7 expand 64*16*16 needs 16 BRAMs
           clock1 = clkexpand71x1;
           clock2 = clkexpand73x3;
           rw=1;
           startdata=18;
           numchannels=0;
           rowwin=0;
           stride_squeeze=0;
           no_of_win_squeeze=0; 
           lengthofrow=15;
           rowfilter=0;
           norm_numofchannels=3;
           colfilter=0;

	       for ( int i = 0 ; i < num_instances-2 ; i=i+3) begin
               dina1[i]=expand71x1[0:ram_num-1];
               dina1[i+1]=expand71x1[ram_num:2*ram_num-1];
               dina1[i+2]=expand71x1[2*ram_num:3*ram_num-1];
               dina2[i]=expand73x3[0:ram_num-1];
               dina2[i+1]=expand73x3[ram_num:2*ram_num-1];
               dina2[i+2]=expand73x3[2*ram_num:3*ram_num-1];
           end
           dina1[6]=expand71x1[0:ram_num-1];
           dina1[7]=expand71x1[ram_num:2*ram_num-1];
           dina2[6]=expand73x3[0:ram_num-1];
           dina2[7]=expand73x3[ram_num:2*ram_num-1];
           dina2[8]=expand73x3[0:ram_num-1];
        end 
        
        19'b0000000100000000000:begin//fire8 expand 112*8*8 needs 7 BRAMs
           clock1 = clkexpand81x1;
           clock2 = clkexpand83x3;
           rw=1;
           startdata=-1;
           rowwin=0;
           numchannels=0;
           stride_squeeze=0;
           no_of_win_squeeze=0; 
           lengthofrow=1;
           norm_numofchannels=4;
           rowfilter=0;
           colfilter=0;

	       for ( int i = 0 ; i < num_instances ; i=i+4) begin
               dina1[i]=expand81x1[0:ram_num-1];
               dina1[i+1]=expand81x1[ram_num:2*ram_num-1];
               dina1[i+2]=expand81x1[2*ram_num:3*ram_num-1];
               dina1[i+3]=expand81x1[3*ram_num:4*ram_num-1];
               dina2[i]=expand83x3[0:ram_num-1];
               dina2[i+1]=expand83x3[ram_num:2*ram_num-1];
               dina2[i+2]=expand83x3[2*ram_num:3*ram_num-1];
               dina2[i+3]=expand83x3[3*ram_num:4*ram_num-1];
           end
           dina2[8]=expand83x3[0:ram_num-1];
        end 
        
        19'b0000000010000000000:begin//fire9 expand 112*8*8 needs 7 BRAMs
           clock1 = clkexpand91x1;
           clock2 = clkexpand93x3;
           rw=1;
           startdata=-1;
           rowwin=0;
           numchannels=0;
           stride_squeeze=0;
           no_of_win_squeeze=0; 
           lengthofrow=1;
           rowfilter=0;
           norm_numofchannels=6;
           colfilter=0;

	       dina1[0]=expand91x1[0:ram_num-1];
           dina1[1]=expand91x1[ram_num:2*ram_num-1];
           dina1[2]=expand91x1[2*ram_num:3*ram_num-1];
           dina1[3]=expand91x1[3*ram_num:4*ram_num-1];
           dina1[4]=expand91x1[4*ram_num:5*ram_num-1];
           dina1[5][0:48-1]=expand91x1[5*ram_num:368-1];
           dina2[0]=expand93x3[0:ram_num-1];
           dina2[1]=expand93x3[ram_num:2*ram_num-1];
           dina2[2]=expand93x3[2*ram_num:3*ram_num-1];
           dina2[3]=expand93x3[3*ram_num:4*ram_num-1];
           dina2[4]=expand93x3[4*ram_num:5*ram_num-1];
           dina2[5][0:48-1]=expand93x3[5*ram_num:368-1];
           for (int j=48;j<ram_num;j++)begin
               dina1[5][j]=0;
               dina2[5][j]=0;
           end    
           for ( int i = 6 ; i < num_instances ; i++) begin
                
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina1[i][j]=0;
                   dina2[i][j]=0;
                end
                
           end
           dina2[8]=expand93x3[0:ram_num-1];
        end
        
        19'b0000000001000000000:begin//reading layer conv1_endshiftedshifted (3x3)
           clock1 = 0;
           clock2 = 0;
           rw=0;
           norm_numofchannels=0;
           startdata=-1;
           rowwin=63;
           stride_squeeze=2;
           no_of_win_squeeze=4095; 
           lengthofrow=130;
           numchannels=63;
           rowfilter=2;
           colfilter=2;
           
           for ( int i = 0 ; i < num_instances ; i++) begin
                
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina1[i][j]=0;
                   dina2[i][j]=0;
                end
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina2[8][j]=0;
                end
           end      
        end
        19'b0000000000100000000:begin//reading layer expand2_endshifted (1x1)
           clock1 = 0;
           clock2 = 0;
           rw=0;
           startdata=-1;
           rowwin=63;
           stride_squeeze=1;
           no_of_win_squeeze=4095;
           numchannels=127; 
           lengthofrow=64;
           rowfilter=0;
           colfilter=0;
           norm_numofchannels=0;

           for ( int i = 0 ; i < num_instances ; i++) begin
                
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina1[i][j]=0;
                   dina2[i][j]=0;
                end
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina2[8][j]=0;
                end
           end      
        end
        19'b0000000000010000000:begin//reading layer expand3_end (3x3)
           clock1 = 0;
           clock2 = 0;
           rw=0;
           startdata=-1;
           numchannels=127;
           rowwin=31;
           stride_squeeze=2;
           no_of_win_squeeze=1023; 
           lengthofrow=66;
           rowfilter=2;
           colfilter=2;
           norm_numofchannels=0;

           for ( int i = 0 ; i < num_instances ; i++) begin
                
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina1[i][j]=0;
                   dina2[i][j]=0;
                end
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina2[8][j]=0;
                end
           end      
        end
        19'b0000000000001000000:begin//reading layer expand4_end (1X1)
           clock1 = 0;
           clock2 = 0;
           rw=0;
           startdata=-1;
           rowwin=31;
           numchannels=255;
           stride_squeeze=1;
           no_of_win_squeeze=1023; 
           lengthofrow=32;
           norm_numofchannels=0;
           rowfilter=0;
           colfilter=0;

           for ( int i = 0 ; i < num_instances ; i++) begin
                
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina1[i][j]=0;
                   dina2[i][j]=0;
                end
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina2[8][j]=0;
                end
           end      
        end
        19'b0000000000000100000:begin//reading layer expand5_end (3x3)
           clock1 = 0;
           clock2 = 0;
           rw=0;
           startdata=-1;
           numchannels=255;
           rowwin=15;
           stride_squeeze=2;
           no_of_win_squeeze=255; 
           lengthofrow=34;
           rowfilter=2;
           colfilter=2;
           norm_numofchannels=0;

           for ( int i = 0 ; i < num_instances ; i++) begin
                
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina1[i][j]=0;
                   dina2[i][j]=0;
                end
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina2[8][j]=0;
                end
           end      
        end
        19'b0000000000000010000:begin//reading layer expand6_end (1x1)
           clock1 = 0;
           clock2 = 0;
           rw=0;
           startdata=-1;
           numchannels=511;
           rowwin=15;
           stride_squeeze=1;
           no_of_win_squeeze=255; 
           lengthofrow=16;
           rowfilter=0;
           norm_numofchannels=0;
           colfilter=0;

           for ( int i = 0 ; i < num_instances ; i++) begin
                
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina1[i][j]=0;
                   dina2[i][j]=0;
                end
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina2[8][j]=0;
                end
           end      
        end
        19'b0000000000000001000:begin//reading layer expand7_end (3x3)
           clock1 = 0;
           clock2 = 0;
           rw=0;
           startdata=-1;
           numchannels=383;
           rowwin=7;
           stride_squeeze=2;
           norm_numofchannels=0;
           no_of_win_squeeze=63; 
           lengthofrow=18;
           rowfilter=2;
           colfilter=2;

           for ( int i = 0 ; i < num_instances ; i++) begin
                
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina1[i][j]=0;
                   dina2[i][j]=0;
                end
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina2[8][j]=0;
                end
           end      
        end
        19'b0000000000000000100:begin//reading layer expand8_end (1x1)
           clock1 = 0;
           clock2 = 0;
           rw=0;
           startdata=-1;
           numchannels=511;
           norm_numofchannels=0;
           rowwin=7;
           stride_squeeze=1;
           no_of_win_squeeze=63; 
           lengthofrow=8;
           rowfilter=0;
           colfilter=0;

           for ( int i = 0 ; i < num_instances ; i++) begin
                
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina1[i][j]=0;
                   dina2[i][j]=0;
                end
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina2[8][j]=0;
                end
           end      
        end
        19'b0000000000000000010:begin//reading layer expand9_end (3x3)
           clock1 = 0;
           clock2 = 0;
           rw=0;
           startdata=-1;
           norm_numofchannels=0;
           rowwin=7;
           numchannels=735;
           stride_squeeze=1;
           no_of_win_squeeze=63; 
           lengthofrow=8;
           rowfilter=0;
           colfilter=0;

           for ( int i = 0 ; i < num_instances ; i++) begin
                
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina1[i][j]=0;
                   dina2[i][j]=0;
                end
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina2[8][j]=0;
                end
           end      
        end
        19'b0000000000000000001:begin//reading layer expand9_end (3x3)
           clock1 = 0;
           clock2 = 0;
           rw=0;
           startdata=-1;
           rowwin=7;
           numchannels=735;
           stride_squeeze=1;
           no_of_win_squeeze=63; 
           lengthofrow=8;
           rowfilter=0;
           colfilter=0;
           norm_numofchannels=0;

           for ( int i = 0 ; i < num_instances ; i++) begin
                
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina1[i][j]=0;
                   dina2[i][j]=0;
                end
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina2[8][j]=0;
                end
           end      
        end
        default: begin
            clock1 = 0;
            clock2 = 0;
            rw=2;
            startdata=0;
            rowwin=0;
            stride_squeeze=0;
            no_of_win_squeeze=0; 
            numchannels=0;
            lengthofrow=0;
            rowfilter=0;
            colfilter=0;
            norm_numofchannels=0;

            for ( int i = 0 ; i < num_instances ; i++) begin
                
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina1[i][j]=0;
                   dina2[i][j]=0;
                end
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina2[8][j]=0;
                end
            end
            
        end
	  
    endcase
end 
always@(posedge clk  ) begin
    if(rw==1) begin
        if(newlayer) begin
            set1_counter<=0;
            flag1<=0;
            flag2<=0;
            flag3<=0;
            flag4<=0;
            set2_counter<=0;
            rowcounter1<=0;
            rowcounter2<=0;
            flagreset<=0;
            if(enconv1) begin
                
                for(int addressrams_counter=0;addressrams_counter<ram_num;addressrams_counter++) begin
                    addrb[addressrams_counter]<=startdata;
                    addra1[addressrams_counter]<=startdata;
                    addra2[addressrams_counter]<=10'b1111111111;
                    for(int instances_counter=0;instances_counter<num_instances;instances_counter++) begin
                        ena1[instances_counter][addressrams_counter]<=0;
                        ena2[instances_counter][addressrams_counter]<=0;
                        wea1[instances_counter][addressrams_counter]<=0;
                        wea2[instances_counter][addressrams_counter]<=0;
                    end
                    ena2[8][addressrams_counter]<=0;
                    wea2[8][addressrams_counter]<=0;
                end
            end
            else begin
                resetmem<=1;
                for(int addressrams_counter=0;addressrams_counter<ram_num;addressrams_counter++) begin
                    addrb[addressrams_counter]<=startdata;
                    addra1[addressrams_counter]<=startdata;
                    addra2[addressrams_counter]<=startdata;
                    enb[addressrams_counter]<=0;
                    web[addressrams_counter]<=0;
                    for(int instances_counter=0;instances_counter<num_instances;instances_counter++) begin
                        ena1[instances_counter][addressrams_counter]<=0;
                        ena2[instances_counter][addressrams_counter]<=0;
                        wea1[instances_counter][addressrams_counter]<=0;
                        wea2[instances_counter][addressrams_counter]<=0;
                    end
                    ena2[8][addressrams_counter]<=0;
                    wea2[8][addressrams_counter]<=0;
                end
            end
        end
        if(resetmem) begin
        
            for(int addressrams_counter=0;addressrams_counter<ram_num;addressrams_counter++) begin
                
                    addrb[addressrams_counter]<=addrb[addressrams_counter]+1;
                    enb[addressrams_counter]<=1;
                    web[addressrams_counter]<=1;
            end
            flagreset<=1;
            if(addrb[0]==startdata && flagreset) begin
                resetmem<=0;
                flagreset<=0;
                for(int addressrams_counter=0;addressrams_counter<ram_num;addressrams_counter++) begin
                    enb[addressrams_counter]<=0;
                    web[addressrams_counter]<=0;
                end
                end
        end
        if(clock1) begin
            if(!flag1) begin
               if(enconv1||enexpand2||enexpand3)begin
                    for(int rams=0;rams<ram_num;rams++)begin
                    ena1[set1_counter][rams]<=1;
                    wea1[set1_counter][rams]<=1;
                   end
              end
              else if(enexpand4||enexpand5)begin
                    for(int rams=0;rams<ram_num;rams++)begin
                    ena1[set1_counter][rams]<=1;
                    wea1[set1_counter][rams]<=1;
                    ena1[set1_counter+1][rams]<=1;
                    wea1[set1_counter+1][rams]<=1;
                   end
              end
              else if(enexpand6||enexpand8)begin
                    for(int rams=0;rams<ram_num;rams++)begin
                    ena1[set1_counter][rams]<=1;
                    wea1[set1_counter][rams]<=1;
                    ena1[set1_counter+1][rams]<=1;
                    wea1[set1_counter+1][rams]<=1;
                    ena1[set1_counter+2][rams]<=1;
                    wea1[set1_counter+2][rams]<=1;
                    ena1[set1_counter+3][rams]<=1;
                    wea1[set1_counter+3][rams]<=1;
                   end
              end
              else if(enexpand7)begin
                for(int rams=0;rams<ram_num;rams++)begin
                    ena1[set1_counter][rams]<=1;
                    wea1[set1_counter][rams]<=1;
                    ena1[set1_counter+1][rams]<=1;
                    wea1[set1_counter+1][rams]<=1;
                    ena1[set1_counter+2][rams]<=1;
                    wea1[set1_counter+2][rams]<=1;
                end
              end
              else if(enexpand9)begin
                    for(int rams=0;rams<ram_num;rams++)begin
                    ena1[set1_counter][rams]<=1;
                    wea1[set1_counter][rams]<=1;
                    ena1[set1_counter+1][rams]<=1;
                    wea1[set1_counter+1][rams]<=1;
                    ena1[set1_counter+2][rams]<=1;
                    wea1[set1_counter+2][rams]<=1;
                    ena1[set1_counter+3][rams]<=1;
                    wea1[set1_counter+3][rams]<=1;
                    ena1[set1_counter+4][rams]<=1;
                    wea1[set1_counter+4][rams]<=1;
                    ena1[set1_counter+5][rams]<=1;
                    wea1[set1_counter+5][rams]<=1;
                   end
              end
              
              
               
              if(addra1[0]==1022 || (addra1[0]==1020 && flag3)||(addra1[0]==1020 && rowcounter1>lengthofrow-1)) begin
                   if({1'b0,set1_counter}>num_instances-2)begin
                        flag1<=1;
                        end
                   else  
                        set1_counter<=set1_counter+norm_numofchannels;
               end
               if(rowcounter1>lengthofrow-1 && addra1[0]!=1020) begin
                   flag3<=1;
               end
               if(rowcounter1==lengthofrow)begin
                        rowcounter1<=0;
                   end
                   else if(enconv1||enexpand3||enexpand5||enexpand7) rowcounter1<=rowcounter1+1;
               if(flag3)begin
                  
                   
                   for(int addressrams_counter=0;addressrams_counter<ram_num;addressrams_counter++) begin
    
                       addra1[addressrams_counter]<=addra1[addressrams_counter]+3;
                   end
                   flag3<=0;
               end
               else begin
                   for(int addressrams_counter=0;addressrams_counter<ram_num;addressrams_counter++) begin
    
                       addra1[addressrams_counter]<=addra1[addressrams_counter]+1;
                       
                   end
               end
            end
        end
        else begin
            for (int i=0;i<num_instances;i++)begin
                ena1[i]<=0;
                wea1[i]<=0;
            end
        end

        
        if(clock2) begin
            if(enconv1) begin
                if(flag1) begin
                    if(!flag2) begin
                       if(enconv1||enexpand2||enexpand3)begin
                    for(int rams=0;rams<ram_num;rams++)begin
                    ena2[set2_counter][rams]<=1;
                    wea2[set2_counter][rams]<=1;
                   end
              end
              else if(enexpand4||enexpand5)begin
                    for(int rams=0;rams<ram_num;rams++)begin
                    ena2[set2_counter][rams]<=1;
                    wea2[set2_counter][rams]<=1;
                    ena2[set2_counter+1][rams]<=1;
                    wea2[set2_counter+1][rams]<=1;
                   end
              end
              else if(enexpand6||enexpand8)begin
                    for(int rams=0;rams<ram_num;rams++)begin
                    ena2[set2_counter][rams]<=1;
                    wea2[set2_counter][rams]<=1;
                    ena2[set2_counter+1][rams]<=1;
                    wea2[set2_counter+1][rams]<=1;
                    ena2[set2_counter+2][rams]<=1;
                    wea2[set2_counter+2][rams]<=1;
                    ena2[set2_counter+3][rams]<=1;
                    wea2[set2_counter+3][rams]<=1;
                   end
              end
              else if(enexpand7)begin
                for(int rams=0;rams<ram_num;rams++)begin
                    ena2[set2_counter][rams]<=1;
                    wea2[set2_counter][rams]<=1;
                    ena2[set2_counter+1][rams]<=1;
                    wea2[set2_counter+1][rams]<=1;
                    ena2[set2_counter+2][rams]<=1;
                    wea2[set2_counter+2][rams]<=1;
                end
              end
              else if(enexpand9)begin
                    for(int rams=0;rams<ram_num;rams++)begin
                    ena2[set2_counter][rams]<=1;
                    wea2[set2_counter][rams]<=1;
                    ena2[set2_counter+1][rams]<=1;
                    wea2[set2_counter+1][rams]<=1;
                    ena2[set2_counter+2][rams]<=1;
                    wea2[set2_counter+2][rams]<=1;
                    ena2[set2_counter+3][rams]<=1;
                    wea2[set2_counter+3][rams]<=1;
                    ena2[set2_counter+4][rams]<=1;
                    wea2[set2_counter+4][rams]<=1;
                    ena2[set2_counter+5][rams]<=1;
                    wea2[set2_counter+5][rams]<=1;
                   end
              end                       
              if(rowcounter2>lengthofrow-1&&addra2[0]!=1020) begin
                           flag4<=1;
                       end
                       if(rowcounter2==lengthofrow)begin
                        rowcounter2<=0;
                   end
                   else if(enconv1||enexpand3||enexpand5||enexpand7) rowcounter2<=rowcounter2+1;
                       if(flag4)begin
                           for(int addressrams_counter=0;addressrams_counter<ram_num;addressrams_counter++) begin
            
                               addra2[addressrams_counter]<=addra2[addressrams_counter]+3;
                           end
                           flag4<=0;
                       end
                       else begin
                           for(int addressrams_counter=0;addressrams_counter<ram_num;addressrams_counter++) begin
            
                               addra2[addressrams_counter]<=addra2[addressrams_counter]+1;
                               
                           end
                       end
                       
                       if(addra2[0]==1022|| (addra2[0]==1020 && flag4)||(addra2[0]==1020 && rowcounter2>lengthofrow-1 )) begin
                           if(set2_counter>num_instances-1)
                                flag2<=1;
                           else  
                                set2_counter<=set2_counter+norm_numofchannels;
                       end
                       if(addra2[0]==383 &&set2_counter==8) flag2<=1;
                    end
                end
            end
            else  begin
                if(!flag2) begin
                   if(enconv1||enexpand2||enexpand3)begin
                    for(int rams=0;rams<ram_num;rams++)begin
                    ena2[set2_counter][rams]<=1;
                    wea2[set2_counter][rams]<=1;
                   end
              end
              else if(enexpand4||enexpand5)begin
                    for(int rams=0;rams<ram_num;rams++)begin
                    ena2[set2_counter][rams]<=1;
                    wea2[set2_counter][rams]<=1;
                    ena2[set2_counter+1][rams]<=1;
                    wea2[set2_counter+1][rams]<=1;
                   end
              end
              else if(enexpand6||enexpand8)begin
                    for(int rams=0;rams<ram_num;rams++)begin
                    ena2[set2_counter][rams]<=1;
                    wea2[set2_counter][rams]<=1;
                    ena2[set2_counter+1][rams]<=1;
                    wea2[set2_counter+1][rams]<=1;
                    ena2[set2_counter+2][rams]<=1;
                    wea2[set2_counter+2][rams]<=1;
                    ena2[set2_counter+3][rams]<=1;
                    wea2[set2_counter+3][rams]<=1;
                   end
              end
              else if(enexpand7)begin
                for(int rams=0;rams<ram_num;rams++)begin
                    ena2[set2_counter][rams]<=1;
                    wea2[set2_counter][rams]<=1;
                    ena2[set2_counter+1][rams]<=1;
                    wea2[set2_counter+1][rams]<=1;
                    ena2[set2_counter+2][rams]<=1;
                    wea2[set2_counter+2][rams]<=1;
                end
              end
              else if(enexpand9)begin
                    for(int rams=0;rams<ram_num;rams++)begin
                    ena2[set2_counter][rams]<=1;
                    wea2[set2_counter][rams]<=1;
                    ena2[set2_counter+1][rams]<=1;
                    wea2[set2_counter+1][rams]<=1;
                    ena2[set2_counter+2][rams]<=1;
                    wea2[set2_counter+2][rams]<=1;
                    ena2[set2_counter+3][rams]<=1;
                    wea2[set2_counter+3][rams]<=1;
                    ena2[set2_counter+4][rams]<=1;
                    wea2[set2_counter+4][rams]<=1;
                    ena2[set2_counter+5][rams]<=1;
                    wea2[set2_counter+5][rams]<=1;
                   end
              end                 
                   if(rowcounter2>lengthofrow-1 && addra2[0]!=1020) begin
                       flag4<=1;
                   end
                   if(rowcounter2>lengthofrow-1)begin
                        rowcounter2<=0;
                   end
                   else if(enconv1||enexpand3||enexpand5||enexpand7) rowcounter2<=rowcounter2+1;
                   if(flag4)begin
                       for(int addressrams_counter=0;addressrams_counter<ram_num;addressrams_counter++) begin
        
                           addra2[addressrams_counter]<=addra2[addressrams_counter]+3;
                       end
                       flag4<=0;
                   end
                   else begin
                       for(int addressrams_counter=0;addressrams_counter<ram_num;addressrams_counter++) begin
        
                           addra2[addressrams_counter]<=addra2[addressrams_counter]+1;
                           
                       end
                   end
                   if(addra2[0]==1022|| (addra2[0]==1020 && flag4)||(addra2[0]==1020 &&  rowcounter2>lengthofrow-1 )) begin
                       if(set2_counter>num_instances-1)
                            flag2<=1;
                       else  
                            set2_counter<=set2_counter+norm_numofchannels;
                   end
                end
            end
        end
        else begin
            for (int i=0;i<num_instances;i++)begin
                ena2[i]<=0;
                wea2[i]<=0;
            end
            ena2[8]<=0;
            wea2[8]<=0;
        end
    end
    else if(rw==0) begin
        if(newlayer)begin
            index<=0;
            win<=0;
	    winref<=0;
            channels<=0;
            channels_counter<=0;
            channels1<=0;
            channels2<=0;
            channels3<=0;
            resetmem<=0;
            a0<=0;
            a1<=0;
            row<=0;
            col<=0;
            numwin<=0;
            countwin<=0;
            flagread<=0;
            flagread_shiftedagain<=0;
            flagread_shifted<=0;
            flagread_shiftedagainagain<=0;
            for(int addressrams_counter=0;addressrams_counter<ram_num;addressrams_counter++) begin
            
                addra1[addressrams_counter]<=0;
                addra2[addressrams_counter]<=0;
                enb[addressrams_counter]<=0;
                web[addressrams_counter]<=0;
                for(int instances_counter=0;instances_counter<num_instances;instances_counter++) begin
                    ena1[instances_counter][addressrams_counter]<=0;
                    ena2[instances_counter][addressrams_counter]<=0;
                    wea1[instances_counter][addressrams_counter]<=0;
                    wea2[instances_counter][addressrams_counter]<=0;
                end
                ena2[8][addressrams_counter]<=0;
                wea2[8][addressrams_counter]<=0;
            end
        end
        ///////////////////////////////////////start reading/////////////////////////////////////////////
        ///////////////////////////////////////start reading/////////////////////////////////////////////
        else if(!flagread_shiftedagainagain) begin
            flagread_shifted<=flagread;
            flagread_shiftedagain<=flagread_shifted;
            flagread_shiftedagainagain<=flagread_shiftedagain;
            channels1<=channels;
            channels2<=channels1;
            channels3<=channels2;
            if(index_shifted<2**address) begin
                addra1[channels1]<=truncated_index[9:0];
                a0<=0;
                a1<=a0;
                for(int instances=0;instances<num_instances;instances++)begin
                    if(instances==0)begin
                        ena1[instances][channels1]<=1;
                        ena2[instances][channels1]<=0;
                        for (ram_numcounter=0;{1'b0,ram_numcounter}<ram_num;ram_numcounter++)begin
                            if(ram_numcounter[5:0]!=channels1)begin
                                ena1[instances][ram_numcounter[5:0]]<=0;
                                ena2[instances][ram_numcounter[5:0]]<=0;
                            end
                        end
                    end
                    else begin 
                        for (int i=0;i<ram_num;i++)begin
                            ena1[instances][i]<=0;
                            ena2[instances][i]<=0;
                        end
                    end
                    for (int i=0;i<ram_num;i++)begin
                            ena2[8][i]<=0;
                    end
                end          
                
            end
            else if(index_shifted<2*(2**address)) begin
                addra1[channels1]<=truncated_index[9:0];
                a0<=1;
                a1<=a0;
                for(int instances=0;instances<num_instances;instances++)begin
                    if(instances==1)begin
                        ena1[instances][channels1]<=1;
                        ena2[instances][channels1]<=0;
                        for (ram_numcounter=0;{1'b0,ram_numcounter}<ram_num;ram_numcounter++)begin
                            if(ram_numcounter[5:0]!=channels1)begin
                                ena1[instances][ram_numcounter[5:0]]<=0; 
                                ena2[instances][ram_numcounter[5:0]]<=0;
                            end
                        end
                    end
                    else begin 
                         
                         
                        for (int i=0;i<ram_num;i++)begin
                            ena1[instances][i]<=0;
                            ena2[instances][i]<=0;
                        end
                    end
                    for (int i=0;i<ram_num;i++)begin
                            ena2[8][i]<=0;
                    end
                end 
            end
            else if(index_shifted<3*(2**address)) begin
                addra1[channels1]<=truncated_index[9:0];
                a0<=2;
                a1<=a0;
                for(int instances=0;instances<num_instances;instances++)begin
                    if(instances==2)begin
                        ena1[instances][channels1]<=1;
                        ena2[instances][channels1]<=0;
                        for (ram_numcounter=0;{1'b0,ram_numcounter}<ram_num;ram_numcounter++)begin
                            if(ram_numcounter[5:0]!=channels1)begin
                                ena1[instances][ram_numcounter[5:0]]<=0;
                                ena2[instances][ram_numcounter[5:0]]<=0;
                            end
                        end
                    end
                    else begin 
                         
                         
                        for (int i=0;i<ram_num;i++)begin
                            ena1[instances][i]<=0;
                            ena2[instances][i]<=0;
                        end
                    end
                    for (int i=0;i<ram_num;i++)begin
                            ena2[8][i]<=0;
                    end
                end 
                
            end
            else if(index_shifted<4*(2**address)) begin
                addra1[channels1]<=truncated_index[9:0];
                a0<=3;
                a1<=a0;
                for(int instances=0;instances<num_instances;instances++)begin
                    if(instances==3)begin
                        ena1[instances][channels1]<=1;
                        ena2[instances][channels1]<=0;
                        for (ram_numcounter=0;{1'b0,ram_numcounter}<ram_num;ram_numcounter++)begin
                            if(ram_numcounter[5:0]!=channels1)begin
                                ena1[instances][ram_numcounter[5:0]]<=0;
                                ena2[instances][ram_numcounter[5:0]]<=0;
                            end
                        end
                    end
                    else begin 
                         
                         
                        for (int i=0;i<ram_num;i++)begin
                            ena1[instances][i]<=0;
                            ena2[instances][i]<=0;
                        end
                    end
                    for (int i=0;i<ram_num;i++)begin
                            ena2[8][i]<=0;
                    end
                end 
            end
            else if(index_shifted<5*(2**address)) begin
                addra1[channels1]<=truncated_index[9:0];
                a0<=4;
                a1<=a0;
                for(int instances=0;instances<num_instances;instances++)begin
                    if(instances==4)begin
                        ena1[instances][channels1]<=1;
                        ena2[instances][channels1]<=0;
                        for (ram_numcounter=0;{1'b0,ram_numcounter}<ram_num;ram_numcounter++)begin
                            if(ram_numcounter[5:0]!=channels1)begin
                                ena1[instances][ram_numcounter[5:0]]<=0;
                                ena2[instances][ram_numcounter[5:0]]<=0;
                            end
                        end
                    end
                    else begin 
                         
                         
                        for (int i=0;i<ram_num;i++)begin
                            ena1[instances][i]<=0;
                            ena2[instances][i]<=0;
                        end
                    end
                end 
            end
            else if(index_shifted<6*(2**address)) begin
                addra1[channels1]<=truncated_index[9:0];
                a0<=5;
                a1<=a0;
                for(int instances=0;instances<num_instances;instances++)begin
                    if(instances==5)begin
                        ena1[instances][channels1]<=1;
                        ena2[instances][channels1]<=0;
                        for (ram_numcounter=0;{1'b0,ram_numcounter}<ram_num;ram_numcounter++)begin
                            if(ram_numcounter[5:0]!=channels1)begin
                                ena1[instances][ram_numcounter[5:0]]<=0;
                                ena2[instances][ram_numcounter[5:0]]<=0;
                            end
                        end
                    end
                    else begin 
                         
                         
                        for (int i=0;i<ram_num;i++)begin
                            ena1[instances][i]<=0;
                            ena2[instances][i]<=0;
                        end
                    end
                    for (int i=0;i<ram_num;i++)begin
                            ena2[8][i]<=0;
                    end
                end 
            end
            else if(index_shifted<7*(2**address)) begin
                addra1[channels1]<=truncated_index[9:0];
                a0<=6;
                a1<=a0;
                for(int instances=0;instances<num_instances;instances++)begin
                    if(instances==6)begin
                        ena1[instances][channels1]<=1;
                        ena2[instances][channels1]<=0;
                        for (ram_numcounter=0;{1'b0,ram_numcounter}<ram_num;ram_numcounter++)begin
                            if(ram_numcounter[5:0]!=channels1)begin
                                ena1[instances][ram_numcounter[5:0]]<=0;
                                ena2[instances][ram_numcounter[5:0]]<=0;
                            end
                        end
                    end
                    else begin 
                         
                         
                        for (int i=0;i<ram_num;i++)begin
                            ena1[instances][i]<=0;
                            ena2[instances][i]<=0;
                        end
                    end
                    for (int i=0;i<ram_num;i++)begin
                            ena2[8][i]<=0;
                    end
                end 
            end
            else if(index_shifted<8*(2**address)) begin
                addra1[channels1]<=truncated_index[9:0];
                a0<=7;
                a1<=a0;
                for(int instances=0;instances<num_instances;instances++)begin
                    if(instances==7)begin
                        ena1[instances][channels1]<=1;
                        ena2[instances][channels1]<=0;
                        for (ram_numcounter=0;{1'b0,ram_numcounter}<ram_num;ram_numcounter++)begin
                            if(ram_numcounter[5:0]!=channels1)begin
                                ena1[instances][ram_numcounter[5:0]]<=0;
                                ena2[instances][ram_numcounter[5:0]]<=0;
                            end
                        end
                    end
                    else begin 
                         
                         
                        for (int i=0;i<ram_num;i++)begin
                            ena1[instances][i]<=0;
                            ena2[instances][i]<=0;
                        end
                    end
                    for (int i=0;i<ram_num;i++)begin
                            ena2[8][i]<=0;
                    end
                end
            end
            else if(index_shifted<9*(2**address)) begin
                addra2[channels1]<=truncated_index[9:0];
                a0<=8;
                a1<=a0;
                for(int instances=0;instances<num_instances;instances++)begin
                    if(instances==0)begin
                        ena2[instances][channels1]<=1;
                        ena1[instances][channels1]<=0;
                        for (ram_numcounter=0;{1'b0,ram_numcounter}<ram_num;ram_numcounter++)begin
                            if(ram_numcounter[5:0]!=channels1)begin
                                ena1[instances][ram_numcounter[5:0]]<=0;
                                ena2[instances][ram_numcounter[5:0]]<=0;
                            end
                        end
                    end
                    else begin 
                         
                         
                        for (int i=0;i<ram_num;i++)begin
                            ena1[instances][i]<=0;
                            ena2[instances][i]<=0;
                        end
                    end
                    ena2[8][channels1]<=0;
                    for (int i=0;i<ram_num;i++)begin
                            ena2[8][i]<=0;
                    end
                end
            end
            else if(index_shifted<10*(2**address)) begin
                addra2[channels1]<=truncated_index[9:0];
                a0<=9;
                a1<=a0;
                for(int instances=0;instances<num_instances;instances++)begin
                    if(instances==1)begin
                        ena2[instances][channels1]<=1;
                        ena1[instances][channels1]<=0;
                        for (ram_numcounter=0;{1'b0,ram_numcounter}<ram_num;ram_numcounter++)begin
                            if(ram_numcounter[5:0]!=channels1)begin
                                ena1[instances][ram_numcounter[5:0]]<=0;
                                ena2[instances][ram_numcounter[5:0]]<=0;
                            end
                        end
                    end
                    else begin 
                         
                         
                        for (int i=0;i<ram_num;i++)begin
                            ena1[instances][i]<=0;
                            ena2[instances][i]<=0;
                        end
                    end
                    ena2[8][channels1]<=0;
                    for (int i=0;i<ram_num;i++)begin
                            ena2[8][i]<=0;
                    end
                end
            end
            else if(index_shifted<11*(2**address)) begin
                addra2[channels1]<=truncated_index[9:0];
                a0<=10;
                a1<=a0;
                for(int instances=0;instances<num_instances;instances++)begin
                    if(instances==2)begin
                        ena2[instances][channels1]<=1;
                        ena1[instances][channels1]<=0;
                        for (ram_numcounter=0;{1'b0,ram_numcounter}<ram_num;ram_numcounter++)begin
                            if(ram_numcounter[5:0]!=channels1)begin
                                ena1[instances][ram_numcounter[5:0]]<=0;
                                ena2[instances][ram_numcounter[5:0]]<=0;
                            end
                        end
                    end
                    else begin 
                         
                         
                        for (int i=0;i<ram_num;i++)begin
                            ena1[instances][i]<=0;
                            ena2[instances][i]<=0;
                        end
                    end
                    ena2[8][channels1]<=0;
                    for (int i=0;i<ram_num;i++)begin
                            ena2[8][i]<=0;
                    end
                end
            end
            else if(index_shifted<12*(2**address)) begin
                addra2[channels1]<=truncated_index[9:0];
                a0<=11;
                a1<=a0;
                for(int instances=0;instances<num_instances;instances++)begin
                    if(instances==3)begin
                        ena2[instances][channels1]<=1;
                        ena1[instances][channels1]<=0;
                        for (ram_numcounter=0;{1'b0,ram_numcounter}<ram_num;ram_numcounter++)begin
                            if(ram_numcounter[5:0]!=channels1)begin
                                ena1[instances][ram_numcounter[5:0]]<=0;
                                ena2[instances][ram_numcounter[5:0]]<=0;
                            end
                        end
                    end
                    else begin 
                         
                         
                        for (int i=0;i<ram_num;i++)begin
                            ena1[instances][i]<=0;
                            ena2[instances][i]<=0;
                        end
                    end
                    ena2[8][channels1]<=0;
                    for (int i=0;i<ram_num;i++)begin
                            ena2[8][i]<=0;
                    end
                end
            end
            else if(index_shifted<13*(2**address)) begin
                addra2[channels1]<=truncated_index[9:0];
                a0<=12;
                a1<=a0;
                for(int instances=0;instances<num_instances;instances++)begin
                    if(instances==4)begin
                        ena2[instances][channels1]<=1;
                        ena1[instances][channels1]<=0;
                        for (ram_numcounter=0;{1'b0,ram_numcounter}<ram_num;ram_numcounter++)begin
                            if(ram_numcounter[5:0]!=channels1)begin
                                ena1[instances][ram_numcounter[5:0]]<=0;
                                ena2[instances][ram_numcounter[5:0]]<=0;
                            end
                        end
                    end
                    else begin 
                         
                         
                        for (int i=0;i<ram_num;i++)begin
                            ena1[instances][i]<=0;
                            ena2[instances][i]<=0;
                        end
                    end
                    ena2[8][channels1]<=0;
                    for (int i=0;i<ram_num;i++)begin
                            ena2[8][i]<=0;
                    end
                end
            end
            else if(index_shifted<14*(2**address)) begin
                addra2[channels1]<=truncated_index[9:0];
                a0<=13;
                a1<=a0;
                for(int instances=0;instances<num_instances;instances++)begin
                    if(instances==5)begin
                        ena2[instances][channels1]<=1;
                        ena1[instances][channels1]<=0;
                        for (ram_numcounter=0;{1'b0,ram_numcounter}<ram_num;ram_numcounter++)begin
                            if(ram_numcounter[5:0]!=channels1)begin
                                ena1[instances][ram_numcounter[5:0]]<=0;
                                ena2[instances][ram_numcounter[5:0]]<=0;
                            end
                        end
                    end
                    else begin 
                         
                         
                        for (int i=0;i<ram_num;i++)begin
                            ena1[instances][i]<=0;
                            ena2[instances][i]<=0;
                        end
                    end
                    ena2[8][channels1]<=0;
                    for (int i=0;i<ram_num;i++)begin
                            ena2[8][i]<=0;
                    end
                end
            end
            else if(index_shifted<15*(2**address)) begin
                addra2[channels1]<=truncated_index[9:0];
                a0<=14;
                a1<=a0;
                for(int instances=0;instances<num_instances;instances++)begin
                    if(instances==6)begin
                        ena2[instances][channels1]<=1;
                        ena1[instances][channels1]<=0;
                        for (ram_numcounter=0;{1'b0,ram_numcounter}<ram_num;ram_numcounter++)begin
                            if(ram_numcounter[5:0]!=channels1)begin
                                ena1[instances][ram_numcounter[5:0]]<=0;
                                ena2[instances][ram_numcounter[5:0]]<=0;
                            end
                        end
                    end
                    else begin 
                         
                         
                        for (int i=0;i<ram_num;i++)begin
                            ena1[instances][i]<=0;
                            ena2[instances][i]<=0;
                        end
                    end
                    ena2[8][channels1]<=0;
                    for (int i=0;i<ram_num;i++)begin
                            ena2[8][i]<=0;
                    end
                end
            end
            else if(index_shifted<16*(2**address)) begin
                addra2[channels1]<=truncated_index[9:0];
                a0<=15;
                a1<=a0;
                for(int instances=0;instances<num_instances;instances++)begin
                    if(instances==7)begin
                        ena2[instances][channels1]<=1;
                        ena1[instances][channels1]<=0;
                        for (ram_numcounter=0;{1'b0,ram_numcounter}<ram_num;ram_numcounter++)begin
                            if(ram_numcounter[5:0]!=channels1)begin
                                ena1[instances][ram_numcounter[5:0]]<=0;
                                ena2[instances][ram_numcounter[5:0]]<=0;
                            end
                        end
                    end
                    else begin 
                         
                         
                        for (int i=0;i<ram_num;i++)begin
                            ena1[instances][i]<=0;
                            ena2[instances][i]<=0;
                        end
                    end
                    ena2[8][channels1]<=0;
                    for (int i=0;i<ram_num;i++)begin
                            ena2[8][i]<=0;
                    end
                end
            end
            else if(index_shifted<17*(2**address)) begin
                addra2[channels1]<=truncated_index[9:0];
                a0<=16;
                a1<=a0;
                for(int instances=0;instances<num_instances;instances++)begin
                        for (ram_numcounter=0;{1'b0,ram_numcounter}<ram_num;ram_numcounter++)begin
                            ena1[instances][ram_numcounter[5:0]]<=0;
                            ena2[instances][ram_numcounter[5:0]]<=0;
                        end
                end
                ena2[8][channels1]<=1;
                for (ram_numcounter=0;{1'b0,ram_numcounter}<ram_num;ram_numcounter++)begin
                        if(ram_numcounter[5:0]!=channels1)
                            ena2[8][ram_numcounter[5:0]]<=0;
                end
            
                    
            end/// layers end   
            
            if(col==colfilter) begin
                    
                  
                    if(row==rowfilter)begin
                        row<=0;
                        if({1'b0,channels}==ram_num-2|| (channels_counter==366 && numchannels>734)||(channels_counter==734 && numchannels>734))begin
                            if(channels_counter>numchannels-2)begin
                                if(countwin>rowwin-1 )begin//rowwin
                                    countwin<=0;
                                    if(stride_squeeze>1) 
                                        win<=win+2*stride_squeeze+{7'b0,lengthofrow};//stride 
                                    else if(stride_squeeze>0)
                                        win<=win+{13'b0,stride_squeeze};//stride 
                                    end
                                    else begin
                                        countwin<=countwin+1;
                                        win<=win+{13'b0,stride_squeeze}; //stride 
                                        
                                end
                            end
                        end
                        if({1'b0,channels}==ram_num-1 || (channels_counter==367 && numchannels>734)||(channels_counter==735 && numchannels>734))begin//for squeeze 2 no of channels =ram num
                            if(channels_counter<numchannels)begin//for squeeze 2 channels = channels_counter
                                channels<=0;
                                col<=0;
                                channels_counter<=channels_counter+1;
                                if(channels_counter<ram_num )begin
                                    if(numchannels==2*ram_num-1)begin//true for 128ch layers (fire 2,3)
                                        index<=win+8192;
                                        winref<=win+8192;
                                        end
                                    else if(index<8192)begin
                                            if(numchannels==4*ram_num-1&&(win>=1024)) index<=win+1024+1024;
                                            else index<=win+1024;
					                        winref<=win+1024;
                                            end
                                        else begin
                                            index<=win+8192+1024;
                                            winref<=win+8192+1024;					
                                        end  
                                end
                                else if(channels_counter<2*ram_num) begin
                                    if(numchannels==4*ram_num-1)begin//true for 256ch layers (fire 4,5)
                                        if(win>=1024) index<=win+8192+1024;
                                        else index<=win+8192;
                                        winref<=win+8192;
                                        end
                                    else if(index<8192)begin
                                               index<=win+2048;
					       winref<=win+2048;
				    end
                                            else begin
						index<=win+8192+1024;
						winref<=win+8192+1024;
                                           end
                                end
                                else if(channels_counter<3*ram_num) begin
                                    if(numchannels==6*ram_num-1)begin//true for 384ch layers (fire 7)
                                        index<=win+8192;
					winref<=win+8192;
				    end
                                    else if(index<8192)begin
                                            index<=win+3072;
					    winref<=win+3072;
					end
                                        else begin
                                            if(numchannels==4*ram_num-1&&(win>=1024)) index<=win+8192+2048;                
                                            else index<=win+8192+1024;
                                            winref<=win+8192+1024;
                                        end 
                                end
                                else if(channels_counter<4*ram_num) begin
                                    if(numchannels==8*ram_num-1)begin//true for 512ch layers (fire 6,8) and last inst (736ch)
                                        index<=win+8192;
                                        winref<=win+8192;
                                    end
                                    else if(index<8192)begin
                                            index<=win+4096;//5th instance in set1 (736ch)
                                            winref<=win+4096;    
                                         end
                                            else begin
                                                index<=win+8192+1024; 
                                                winref<=win+8192+1024; 
                                                                
                                            end
                                end
                                else if(channels_counter<5*ram_num) begin //2nd instance in set2 (512ch)
                                         if(index<8192)begin
                                            index<=win+5120;//6th instance in set1 (736ch)
                                            winref<=win+5120;
                                        end
                                        else begin
                                            if(numchannels==8*ram_num-1)begin
                                                index<=win+8192+1024; 
                                                winref<=win+8192+1024;
                                            end
                                            else begin
                                                index<=win+8192+2048; 
                                                winref<=win+8192+2048;
                                            end
                                        end 
                                     end  
                                else if(channels_counter<6*ram_num) begin //3rd instance in set2 (512ch)
                                        if (numchannels==735 && channels_counter==367)begin
                                            index<=win+8192;//1st instance in set2 (736ch)
                                            winref<=win+8192;
                                        end
                                        else begin
                                            index<=win+8192+2048;
                                            winref<=win+8192+2048;
                                        end
                                     end
                                else if(channels_counter<7*ram_num) begin //4th instance in set2 (512ch)
                                       if (numchannels==735)begin
                                            index<=win+8192+1024;//2nd instance in set2 (736ch)
                                            winref<=win+8192+1024;
                                        end
                                    else begin
                                    index<=win+8192+3072;
                                    winref<=win+8192+3072;
                                     
                                     end
                                     end
                                else if(channels_counter<8*ram_num) begin//3rd instance in set2 (736ch)
                                        index<=win+8192+2048;
					                    winref<=win+8192+2048;
					 
                                     end    
                                 else if(channels_counter<9*ram_num) begin//4th instance in set2 (736ch)
                                        index<=win+8192+3072; 	
					                    winref<=win+8192+3072; 
                                     end  
                                 else if(channels_counter<10*ram_num) begin//5th instance in set2 (736ch)
                                        index<=win+8192+4096; 
					                    winref<=win+8192+4096; 
                                     end 
                                 else if(channels_counter<11*ram_num) begin//6th instance in set2 (736ch)
                                         index<=win+8192+5120; 
					                      winref<=win+8192+5120; 
                                      end            
                            end
                            else begin//if window end
                                channels<=0;
				                channels_counter<=0;
                                if(numwin==no_of_win_squeeze) begin//no_of_win_squeeze
                                    flagread<=1;
                                end
                                
                                else begin
                                    col<=3;
                                    numwin<=numwin+1;
                                    if(numchannels==4*ram_num-1 &&(win>=1024 &&win<2048)) index<=win-1+1024;
                                    else index<=win-1;
                                    
                                    winref<=win;
                                end
                            end
                        end
                        else begin//IF CHANNELS DIDN'T END
                            col<=0;
                            channels<=channels+1;
                            channels_counter<=channels_counter+1;
                            if(channels_counter<64)begin
                                if(numchannels==4*ram_num-1 &&(winref>=1024&&winref<2048)) index<=winref+1024;
                                else index<=winref;
                            end
                            else if(channels_counter<128)begin
                                if(numchannels==4*ram_num-1 &&(winref>=2048&&winref<3072)) index<=winref+1024;
                                else index<=winref;
                            end
                            else if(channels_counter<192)begin
                                if(numchannels==4*ram_num-1 &&(winref>=9216 &&winref<10240)) index<=winref+1024;
                                else index<=winref;
                            end
                            else if(channels_counter>=192)begin
                                if(numchannels==4*ram_num-1 &&(winref>=10240 &&winref<11264)) index<=winref+1024;
                                else index<=winref;
                            end
                        end
                        
                    end
                    
                    else begin//IF ROW DIDN'T END
                         if(channels_counter<64)begin
                             if(expand5_endshifted&&(index>=992&&index<2048)) index<=index+({7'b0,lengthofrow}-2)+1024;
                             else index<=index+({7'b0,lengthofrow}-2);//shift row 130
                         end
                         else if(channels_counter<128)begin
                            if(expand5_endshifted&&(index>=2016&&index<3072)) index<=index+({7'b0,lengthofrow}-2)+1024;
                            else index<=index+({7'b0,lengthofrow}-2);//shift row 130
                         end
                         else if(channels_counter<192)begin
                             if(expand5_endshifted&&(index>=9184 &&index<10240)) index<=index+({7'b0,lengthofrow}-2)+1024;
                             else index<=index+({7'b0,lengthofrow}-2);//shift row 130
                         end
                         else if(channels_counter>=192)begin
                            if(expand5_endshifted&&(index>=10208 &&index<11264)) index<=index+({7'b0,lengthofrow}-2)+1024;
                            else index<=index+({7'b0,lengthofrow}-2);//shift row 130
                         end
                         row<=row+1;
                         col<=0;
                     end
                end
            else begin
                if(col!=3)begin
                    if(channels_counter<64)begin
                        if(numchannels==4*ram_num-1 &&(index>=1023 &&index<2048)) index<=index+1+1024;
                        else index<=index+1;
                    end
                    else if (channels_counter<128)begin
                        if(numchannels==4*ram_num-1 &&(index>=2047 &&index<3072)) index<=index+1+1024;
                        else index<=index+1;
                    end
                    else if(channels_counter<192)begin
                        if(numchannels==4*ram_num-1 &&(index>=9215 &&index<10240)) index<=index+1+1024;
                        else index<=index+1;
                    end
                    else if (channels_counter>=192)begin
                        if(numchannels==4*ram_num-1 &&(index>=10239 &&index<11264)) index<=index+1+1024;
                        else index<=index+1;
                    end
                end
                else index<=index+1;
                col<=col+1;
            end
        end
        else begin
            for(int addressrams_counter=0;addressrams_counter<ram_num;addressrams_counter++) begin
                addra1[addressrams_counter]<=0;
                addra2[addressrams_counter]<=0;
                for(int instances_counter=0;instances_counter<num_instances;instances_counter++) begin
                    ena1[instances_counter][addressrams_counter]<=0;
                    ena2[instances_counter][addressrams_counter]<=0;
                end
            end
        end
             
    end
end


always@(posedge clk  )begin///////choose enable for reading layer
    if(rw==0)begin
    
        if(startcounter==4)begin
            if(conv1_endshifted)begin
            ensqueeze2<=1;
            squeeze2<=douta[a1][channels3];
            end
            else if(expand2_endshifted)begin
            ensqueeze3<=1;
            squeeze3<=douta[a1][channels3];
            end
            else if(expand3_endshifted)begin
            ensqueeze4<=1;
            squeeze4<=douta[a1][channels3];
            end
            else if(expand4_endshifted)begin
            ensqueeze5<=1;
            squeeze5<=douta[a1][channels3];
            end
            else if(expand5_endshifted)begin
            ensqueeze6<=1;
            squeeze6<=douta[a1][channels3];
            end
            else if(expand6_endshifted)begin
            ensqueeze7<=1;
            squeeze7<=douta[a1][channels3];
            end
            else if(expand7_endshifted)begin
            ensqueeze8<=1;
            squeeze8<=douta[a1][channels3];
            end
            else if(expand8_endshifted)begin
            ensqueeze9<=1;
            squeeze9<=douta[a1][channels3];
            end
            else if(expand9_endshifted)begin
            enconv10_1<=1;
            conv10_1<=douta[a1][channels3];
            end
            else if(conv10_endshifted)begin
            enconv10_2<=1;
            conv10_2<=douta[a1][channels3];
            end
        end
        else begin
            startcounter<=startcounter+1;
        end
    end 
        else begin
            ensqueeze2<=0;
                ensqueeze3<=0;
            ensqueeze4<=0;
            ensqueeze5<=0;
            ensqueeze6<=0;
            ensqueeze7<=0;
            startcounter<=0;
            ensqueeze8<=0;
            ensqueeze9<=0;
            enconv10_1<=0;
            enconv10_2<=0;
        end
end     

always@(posedge clk  )begin/// trancated index sync
    if(!flagread)begin
        index_shifted<=index;
        if(index<2**address) truncated_index<=index;
        else if(index<2*(2**address)) truncated_index<=index-(2**address);
        else if(index<3*(2**address)) truncated_index<=index-(2*(2**address));
        else if(index<4*(2**address)) truncated_index<=index-3*(2**address);
        else if(index<5*(2**address)) truncated_index<=index-4*(2**address);
        else if(index<6*(2**address)) truncated_index<=index-5*(2**address);
        else if(index<7*(2**address)) truncated_index<=index-6*(2**address);
        else if(index<8*(2**address)) truncated_index<=index-7*(2**address);
        else if(index<9*(2**address)) truncated_index<=index-8*(2**address);
        else if(index<10*(2**address)) truncated_index<=index-9*(2**address);
        else if(index<11*(2**address)) truncated_index<=index-10*(2**address);
        else if(index<12*(2**address)) truncated_index<=index-11*(2**address);
        else if(index<13*(2**address)) truncated_index<=index-12*(2**address);
        else if(index<14*(2**address)) truncated_index<=index-13*(2**address);
        else if(index<15*(2**address)) truncated_index<=index-14*(2**address);
        else if(index<16*(2**address)) truncated_index<=index-15*(2**address);
        else if(index<17*(2**address)) truncated_index<=index-16*(2**address);
    end
end
endmodule
