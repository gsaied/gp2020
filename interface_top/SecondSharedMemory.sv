`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/14/2020 06:49:05 PM
// Design Name: 
// Module Name: 2ndSharedMemory
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


module SecondSharedMemory#(
    parameter ram_num=16,
    parameter num_instances1=7,
    parameter num_instances2=7,
	parameter width= 16 ,
	parameter address= 10
)

(
input clk,
input[width-1:0] squeeze2[0:ram_num-1],
input [width-1:0] squeeze3[0:ram_num-1],
input [width-1:0] squeeze4[0:2*ram_num-1],
input [width-1:0] squeeze5[0:2*ram_num-1],
input [width-1:0] squeeze6[0:4*ram_num-1],
input [width-1:0] squeeze7[0:4*ram_num-1],
input [width-1:0] squeeze8[0:7*ram_num-1],
input [width-1:0] squeeze9[0:7*ram_num-1],
input clksqueeze2,
input clksqueeze3,
input clksqueeze4,
input clksqueeze5,
input clksqueeze6,
input clksqueeze7,
input clksqueeze8,
input clksqueeze9,
input ensqueeze2,
input squeeze2_end,//squeeze2 has finished
input ensqueeze3,
input squeeze3_end,
input ensqueeze4,
input squeeze4_end,
input ensqueeze5,
input squeeze5_end,
input ensqueeze6,
input squeeze6_end,
input ensqueeze7,
input squeeze7_end,
input ensqueeze8,
input squeeze8_end,
input ensqueeze9,
input squeeze9_end,
input conv10_1end,
output reg enexpand2,
output reg enexpand3,
output reg enexpand4,
output reg enexpand5,
output reg enexpand6,
output reg enexpand7,
output reg enexpand8,
output reg enexpand9,
output reg [width-1:0] expand21x1,
output reg [width-1:0] expand23x3,
output reg [width-1:0] expand31x1,
output reg [width-1:0] expand33x3,
output reg [width-1:0] expand41x1,
output reg [width-1:0] expand43x3,
output reg [width-1:0] expand51x1,
output reg [width-1:0] expand53x3,
output reg [width-1:0] expand61x1,
output reg [width-1:0] expand63x3,
output reg [width-1:0] expand71x1,
output reg [width-1:0] expand73x3,
output reg [width-1:0] expand81x1,
output reg [width-1:0] expand83x3,
output reg [width-1:0] expand91x1,
output reg [width-1:0] expand93x3,
output reg [width-1:0] doutb [0:13][0:ram_num-1]
    );
   
   
reg clock1;
reg clock2;
reg[1:0] rw;
reg [address-1:0] addra1 [0:ram_num-1];
reg [address-1:0] addrb1 [0:ram_num-1];
reg [address-1:0] addrb2 [0:ram_num-1];
reg [address-1:0] addra2 [0:ram_num-1];
reg [width-1:0] dina1 [0:num_instances1-1][0:ram_num-1];
reg [width-1:0] douta1 [0:num_instances1-1][0:ram_num-1];
reg [width-1:0] douta2 [0:num_instances2-1][0:ram_num-1];
reg [width-1:0] dina2 [0:num_instances2-1][0:ram_num-1];
reg [width-1:0] dinb [0:ram_num-1];
reg [ram_num-1:0] ena2[0:num_instances2-1];
reg [ram_num-1:0] web;
reg [ram_num-1:0] enb;
reg [ram_num-1:0] wea1[0:num_instances1-1];
reg [ram_num-1:0] wea2[0:num_instances2-1];
reg [ram_num-1:0] ena1[0:num_instances1-1];
   
genvar i;
generate // 2 ram blocks ,each contains 8 instances . port a signals are used , port b signals aren't used.
    for (i=0; i < num_instances1 ; i=i+1) begin :ram_3d1 
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
        .addrb(addrb1),
        .dina(dina1[i]),
        .douta(douta1[i]),
        .doutb(doutb[i])
        );
    end



    for (i=0; i < num_instances2 ; i=i+1) begin :ram_3d2 
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
        .addrb(addrb2),
        .dina(dina2[i]),
        .douta(douta2[i]),
        .doutb(doutb[i+7])
        );
    end
    
    
endgenerate

/////////// write signals
reg[2:0] set1_counter=0; 
reg[2:0] set2_counter=0;
reg flag1=0;
reg flag2=0;
reg flag3=0;
reg flag4=0;
reg squeeze2rst,expand2rst,squeeze3rst,expand3rst,squeeze4rst,expand4rst,squeeze5rst,expand5rst,squeeze6rst,expand6rst,squeeze7rst,expand7rst,squeeze8rst,expand8rst,squeeze9rst,expand9rst,conv10_1rst,conv10_2rst=1;
reg[9:0] startdata;
reg[2:0] norm_numofchannels;
reg [4:0] ram_numcounter;
wire newlayer;
reg flagreset;
//wire readinglayer;
/////////////// read signals
reg[14:0] index1;//real index in ram
reg[14:0] index1_shifted;//real index in ram
reg[14:0] win1;// first index in windows
reg[11:0] numwin1;//total number of windows
reg[6:0] rowcounter;//to put internal padding
reg[3:0] channels_1;
reg[3:0] channels1_1;
reg[3:0] channels2_1;
reg[3:0] channels3_1;
reg[2:0] a01;
reg[2:0] a11;
reg[14:0] index2;//real index in ram
reg[14:0] index2_shifted;//real index in ram
reg[14:0] win2;// first index in windows
reg[14:0] winref1;
reg[14:0] winref2;
reg[11:0] numwin2;//total number of windows
reg[3:0] channels_2;
reg[3:0] channels1_2;
reg[3:0] channels2_2;
reg[3:0] channels3_2;
reg[5:0] rowwin;///////////////number of windows
reg[5:0] countwin;//number of windows on a row
reg[2:0] a02;
reg[2:0] a12;
reg[1:0] stride_expand;//////////////stride for each reading layer
reg[11:0] no_of_win_expand; /////////no of win for each reading
reg[6:0] lengthofrow;///////////no of elements in row
reg[8:0] channels1_counter;////////count no of channels
reg[8:0] channels2_counter;////////count no of channels
reg[8:0] numchannels;/////////total no of input channels for each reading layer
reg[1:0] row1,col1;
reg[1:0] row2,col2;
reg [1:0] startcounter;//after 4 cycles 
reg flagread2;//enable reading
reg flagread2_shifted;
reg flagread2_shiftedagain;
reg flagread2_shiftedagainagain;
reg flagread1;//enable reading
reg flagread1_shifted;
reg flagread1_shiftedagain;
reg flagread1_shiftedagainagain;
reg resetmem;//initialize memory with zeros
reg[14:0] truncated_index2;//index for new ram
reg[14:0] truncated_index1;//index for new ram
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

initial begin
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
        set1_counter=0;
        flag1=0;
        flag2=0;
        set2_counter=0;
        resetmem=0;
        rowcounter=0;
        flag4=0;
        flagreset=0;
        for(int j=0;j<ram_num;j++)begin
               dinb[j]=0;
        end
        for(int addressrams_counter=0;addressrams_counter<ram_num;addressrams_counter++) begin
        
            addra1[addressrams_counter]=10'b1111111111;
            addra2[addressrams_counter]=10'b1111111111;
	    enb[addressrams_counter]=0;
            web[addressrams_counter]=0;
            for(int instances_counter=0;instances_counter<num_instances1;instances_counter++) begin
                ena1[instances_counter][addressrams_counter]=0;
                wea1[instances_counter][addressrams_counter]=0;
                
            end
	    for(int instances_counter=0;instances_counter<num_instances2;instances_counter++) begin
                ena2[instances_counter][addressrams_counter]=0;
                wea2[instances_counter][addressrams_counter]=0;
                
            end
        end
        enexpand2=0;
        enexpand3=0;
        enexpand4=0;
        enexpand5=0;
        enexpand6=0;
        enexpand7=0;
        enexpand8=0;
        enexpand9=0;
        startcounter=0;
        expand21x1=0;
        expand31x1=0;
        expand41x1=0;
        expand51x1=0;
        expand61x1=0;
        expand71x1=0;
        expand81x1=0;
        expand91x1=0;
        expand23x3=0;
        expand33x3=0;
        expand43x3=0;
        expand53x3=0;
        expand63x3=0;
        expand73x3=0;
        expand83x3=0;
        expand93x3=0;
        index2_shifted=0;
        truncated_index2=0;
        index1_shifted=0;
        truncated_index1=0;
end
/////////// reset signals control for all layers
always@(posedge clk  ) begin
    if(squeeze2_end)begin
        shift1expand2<=0;
        shift2expand2<=shift1expand2;
        expand2rst<=shift2expand2;
        end
    end
always@(posedge clk  ) begin
    if(ensqueeze2)begin
        shift1squeeze2<=0;
        shift2squeeze2<=shift1squeeze2;
        squeeze2rst<=shift2squeeze2;
    end
end
always@(posedge clk  ) begin
    if(squeeze3_end)begin
        shift1expand3<=0;
        shift2expand3<=shift1expand3;
        expand3rst<=shift2expand3;
        end
    end
always@(posedge clk  ) begin
    if(ensqueeze3)begin
        shift1squeeze3<=0;
        shift2squeeze3<=shift1squeeze3;
        squeeze3rst<=shift2squeeze3;
    end
end
always@(posedge clk  ) begin
    if(squeeze4_end)begin
        shift1expand4<=0;
        shift2expand4<=shift1expand4;
        expand4rst<=shift2expand4;
        end
    end
always@(posedge clk  ) begin
    if(ensqueeze4)begin
        shift1squeeze4<=0;
        shift2squeeze4<=shift1squeeze4;
        squeeze4rst<=shift2squeeze4;
    end
end
always@(posedge clk  ) begin
    if(squeeze5_end)begin
        shift1expand5<=0;
        shift2expand5<=shift1expand5;
        expand5rst<=shift2expand5;
        end
    end
always@(posedge clk  ) begin
    if(ensqueeze5)begin
        shift1squeeze5<=0;
        shift2squeeze5<=shift1squeeze5;
        squeeze5rst<=shift2squeeze5;
    end
end
always@(posedge clk  ) begin
    if(squeeze6_end)begin
        shift1expand6<=0;
        shift2expand6<=shift1expand6;
        expand6rst<=shift2expand6;
        end
    end
always@(posedge clk  ) begin
    if(ensqueeze6)begin
        shift1squeeze6<=0;
        shift2squeeze6<=shift1squeeze6;
        squeeze6rst<=shift2squeeze6;
    end
end
always@(posedge clk  ) begin
    if(squeeze7_end)begin
        shift1expand7<=0;
        shift2expand7<=shift1expand7;
        expand7rst<=shift2expand7;
        end
    end
always@(posedge clk  ) begin
    if(ensqueeze7)begin
        shift1squeeze7<=0;
        shift2squeeze7<=shift1squeeze7;
        squeeze7rst<=shift2squeeze7;
    end
end
always@(posedge clk  ) begin
    if(squeeze8_end)begin
        shift1expand8<=0;
        shift2expand8<=shift1expand8;
        expand8rst<=shift2expand8;
        end
    end
always@(posedge clk  ) begin
    if(ensqueeze8)begin
        shift1squeeze8<=0;
        shift2squeeze8<=shift1squeeze8;
        squeeze8rst<=shift2squeeze8;
    end
end
always@(posedge clk  ) begin
    if(squeeze9_end)begin
        shift1expand9<=0;
        shift2expand9<=shift1expand9;
        expand9rst<=shift2expand9;
        end
    end
always@(posedge clk  ) begin
    if(ensqueeze9)begin
        shift1squeeze9<=0;
        shift2squeeze9<=shift1squeeze9;
        squeeze9rst<=shift2squeeze9;
    end
end

///////////////////////////////////end of reset signals
      assign  newlayer=(squeeze2_end && expand2rst)|| (ensqueeze2 && squeeze2rst)|| (squeeze3_end && expand3rst)|| (ensqueeze3 && squeeze3rst)|| (squeeze4_end && expand4rst)|| (ensqueeze4 && squeeze4rst)|| (squeeze5_end && expand5rst)|| (ensqueeze5 && squeeze5rst)|| (squeeze6_end && expand6rst)|| (ensqueeze6 && squeeze6rst)|| (squeeze7_end && expand7rst)|| (ensqueeze7 && squeeze7rst)|| (squeeze8_end && expand8rst)|| (ensqueeze8 && squeeze8rst)|| (squeeze9_end && expand9rst)|| (ensqueeze9 && squeeze9rst);

////////////////////////////////////////////////////////first shared memory/////////////////////////////////////////////////////////////////////////////////////////////////////
// layer selection ,clock and input contection to ram  
always@(*) begin

   //case({enconv1,enexpand2,enexpand23x3,conv1_end,enexpand3,enexpand33x3,ensqueeze3,enexpand4,enexpand43x3,ensqueeze4,enexpand5,enexpand53x3,ensqueeze5,enexpand6,enexpand63x3,ensqueeze6,enexpand7,enexpand73x3,ensqueeze7,enexpand8,enexpand83x3,ensqueeze8,enexpand9,enexpand93x3,ensqueeze9,enconv10_1,enconv10_2}) 
   case({ensqueeze2,ensqueeze3,ensqueeze4,ensqueeze5,ensqueeze6,ensqueeze7,ensqueeze8,ensqueeze9,squeeze2_end,squeeze3_end,squeeze4_end,squeeze5_end,squeeze6_end,squeeze7_end,squeeze8_end,squeeze9_end}) 
        16'b1000000000000000: begin//squeeze2 64*64*16 needs 64 BRAMs
           clock1 = clksqueeze2;
           clock2 = clksqueeze2;
           rw=1;
           startdata=66;
           stride_expand=0;
           no_of_win_expand=0; 
           lengthofrow=63;
           numchannels=0;
           rowwin=0;
           norm_numofchannels=1;
           for ( int i = 0 ; i < num_instances1 ; i++) begin
               dina1[i]=squeeze2;
           end
	   for(int i=0;i<num_instances2;i++) dina2[i]=squeeze2;
        end
        
        
        16'b0100000000000000:begin//squeeze3 64*64*16 needs 64 BRAMs
           clock1 = clksqueeze3;
           clock2 = clksqueeze3;
           rw=1;
           startdata=66;
           stride_expand=0;
           norm_numofchannels=1;
           no_of_win_expand=0; 
           lengthofrow=63;
           rowwin=0;
           numchannels=0;
           for ( int i = 0 ; i < num_instances1 ; i++) begin
                   dina1[i]=squeeze3;
               end
           for(int i=0;i<num_instances2;i++) dina2[i]=squeeze3;
        end
        
        16'b0010000000000000:begin//squeeze4 32*32*32 needs 32 BRAMs
           clock1 = clksqueeze4;
           clock2 = clksqueeze4;
           rw=1;
           startdata=34;
           numchannels=0;
           stride_expand=0;
           norm_numofchannels=2;
           no_of_win_expand=0; 
           rowwin=0;
           lengthofrow=31;
           for ( int i = 0 ; i < num_instances1-1 ; i=i+2) begin
               dina1[i]=squeeze4[0:ram_num-1];
               dina1[i+1]=squeeze4[ram_num:2*ram_num-1];
           end
           dina1[6]=squeeze4[0:ram_num-1];
           for(int i=0;i<num_instances2-1;i=i+2) begin 
               dina2[i]=squeeze4[0:ram_num-1];
               dina2[i+1]=squeeze4[ram_num:2*ram_num-1];
           end
           dina2[6]=squeeze4[0:ram_num-1];
        end   
        
        16'b0001000000000000:begin//squeeze5 32*32*32 needs 32 BRAMs
           clock1 = clksqueeze5;
           clock2 = clksqueeze5;
           rw=1;
           startdata=34;
           numchannels=0;
           stride_expand=0;
           norm_numofchannels=2;
           no_of_win_expand=0; 
           rowwin=0;
           lengthofrow=31;
           for ( int i = 0 ; i < num_instances1-1 ; i=i+2) begin
               dina1[i]=squeeze5[0:ram_num-1];
               dina1[i+1]=squeeze5[ram_num:2*ram_num-1];
           end
           dina1[6]=squeeze5[0:ram_num-1];
           for(int i=0;i<num_instances2-1;i=i+2) begin 
               dina2[i]=squeeze5[0:ram_num-1];
               dina2[i+1]=squeeze5[ram_num:2*ram_num-1];
           end
           dina2[6]=squeeze5[0:ram_num-1];
        end 
        
        16'b0000100000000000:begin//squeeze6 16*16*64 needs 16 BRAMs
           clock1 = clksqueeze6;
           clock2 = clksqueeze6;
           rw=1;
           startdata=18;
           numchannels=0;
           stride_expand=0;
           norm_numofchannels=4;
           no_of_win_expand=0; 
           rowwin=0;
           lengthofrow=15;
           for ( int i = 0 ; i < num_instances1 ; i=i+4) begin
               dina1[i]=squeeze6[0:ram_num-1];
               dina1[i+1]=squeeze6[ram_num:2*ram_num-1];
               dina1[i+2]=squeeze6[ram_num*2:3*ram_num-1];
           end
           
               dina1[3]=squeeze6[3*ram_num:4*ram_num-1];
           for(int i=0;i<num_instances2;i=i+4) begin 
               dina2[i]=squeeze6[0:ram_num-1];
               dina2[i+1]=squeeze6[ram_num:2*ram_num-1];
               dina2[i+2]=squeeze6[ram_num*2:3*ram_num-1];
           end
           dina2[3]=squeeze6[3*ram_num:4*ram_num-1];
        end 
        
        16'b0000010000000000:begin//squeeze7 16*16*64 needs 16 BRAMs
           clock1 = clksqueeze7;
           clock2 = clksqueeze7;
           rw=1;
           startdata=18;
           numchannels=0;
           stride_expand=0;
           norm_numofchannels=4;
           no_of_win_expand=0; 
           rowwin=0;
           lengthofrow=15;
           for ( int i = 0 ; i < num_instances1 ; i=i+4) begin
               dina1[i]=squeeze7[0:ram_num-1];
               dina1[i+1]=squeeze7[ram_num:2*ram_num-1];
               dina1[i+2]=squeeze7[ram_num*2:3*ram_num-1];
           end
           dina1[3]=squeeze7[3*ram_num:4*ram_num-1];
           for(int i=0;i<num_instances2;i=i+4) begin 
               dina2[i]=squeeze7[0:ram_num-1];
               dina2[i+1]=squeeze7[ram_num:2*ram_num-1];
               dina2[i+2]=squeeze7[ram_num*2:3*ram_num-1];
               
           end
           dina2[3]=squeeze7[3*ram_num:4*ram_num-1];
        end 
        
        16'b0000001000000000:begin//squeeze8 8*8*112 needs 7 BRAMS
           clock1 = clksqueeze8;
           clock2 = clksqueeze8;
           rw=1;
           startdata=10;
           norm_numofchannels=7;
           rowwin=0;
           numchannels=0;
           stride_expand=0;
           no_of_win_expand=0; 
           lengthofrow=7;

           dina1[0]=squeeze8[0:ram_num-1];
           dina1[1]=squeeze8[ram_num:2*ram_num-1];
           dina1[2]=squeeze8[ram_num*2:3*ram_num-1];
           dina1[3]=squeeze8[3*ram_num:4*ram_num-1];
           dina1[4]=squeeze8[ram_num*4:5*ram_num-1];
           dina1[5]=squeeze8[5*ram_num:6*ram_num-1];
           dina1[6]=squeeze8[6*ram_num:7*ram_num-1];
           dina2[0]=squeeze8[0:ram_num-1];
           dina2[1]=squeeze8[ram_num:2*ram_num-1];
           dina2[2]=squeeze8[ram_num*2:3*ram_num-1];
           dina2[3]=squeeze8[3*ram_num:4*ram_num-1];
           dina2[4]=squeeze8[ram_num*4:5*ram_num-1];
           dina2[5]=squeeze8[5*ram_num:6*ram_num-1];
           dina2[6]=squeeze8[6*ram_num:7*ram_num-1];
           
        end 
        	
        16'b000000100000000:begin//squeeze9 8*8*112 needs 7 BRAMS
           clock1 = clksqueeze9;
           clock2 = clksqueeze9;
           rw=1;
           startdata=10;
           numchannels=0;
           stride_expand=0;
           rowwin=0;
           norm_numofchannels=7;
           no_of_win_expand=0; 
           lengthofrow=7;
           dina1[0]=squeeze9[0:ram_num-1];
           dina1[1]=squeeze9[ram_num:2*ram_num-1];
           dina1[2]=squeeze9[ram_num*2:3*ram_num-1];
           dina1[3]=squeeze9[3*ram_num:4*ram_num-1];
           dina1[4]=squeeze9[ram_num*4:5*ram_num-1];
           dina1[5]=squeeze9[5*ram_num:6*ram_num-1];
           dina1[6]=squeeze9[6*ram_num:7*ram_num-1];
           dina2[0]=squeeze9[0:ram_num-1];
           dina2[1]=squeeze9[ram_num:2*ram_num-1];
           dina2[2]=squeeze9[ram_num*2:3*ram_num-1];
           dina2[3]=squeeze9[3*ram_num:4*ram_num-1];
           dina2[4]=squeeze9[ram_num*4:5*ram_num-1];
           dina2[5]=squeeze9[5*ram_num:6*ram_num-1];
           dina2[6]=squeeze9[6*ram_num:7*ram_num-1];
           
        end 
        16'b000000010000000:begin//reading layer squeeze2_end 
           clock1 = 0;
           clock2 = 0;
           rw=0;
           startdata=-1;
           stride_expand=1;
           no_of_win_expand=4095; 
           lengthofrow=66;
           numchannels=15;
           rowwin=63;
           norm_numofchannels=0;
            for ( int i = 0 ; i < num_instances1 ; i++) begin
                
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina1[i][j]=0;
                end
            end
            for ( int i = 0 ; i < num_instances2 ; i++) begin
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina2[i][j]=0;
                end
            end    
        end
        16'b000000001000000:begin//reading layer squeeze3_end
           clock1 = 0;
           clock2 = 0;
           rw=0;
           startdata=-1;
           stride_expand=1;
           no_of_win_expand=4095;
           numchannels=15; 
           lengthofrow=66;
           rowwin=63;
           norm_numofchannels=0;
            for ( int i = 0 ; i < num_instances1 ; i++) begin
                
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina1[i][j]=0;
                end
            end
            for ( int i = 0 ; i < num_instances2 ; i++) begin
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina2[i][j]=0;
                end
            end 
        end
        16'b000000000100000:begin//reading layer squeeze4_end
           clock1 = 0;
           clock2 = 0;
           rw=0;
           startdata=-1;
           numchannels=31;
           stride_expand=1;
           no_of_win_expand=1023; 
           lengthofrow=34;
           rowwin=31;
           norm_numofchannels=0;
            for ( int i = 0 ; i < num_instances1 ; i++) begin
                
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina1[i][j]=0;
                end
            end
            for ( int i = 0 ; i < num_instances2 ; i++) begin
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina2[i][j]=0;
                end
            end  
        end
        16'b000000000010000:begin//reading layer squeeze5_end
           clock1 = 0;
           clock2 = 0;
           rw=0;
           startdata=-1;
           numchannels=31;
           stride_expand=1;
           no_of_win_expand=1023; 
           lengthofrow=34;
           rowwin=31;
           norm_numofchannels=0;
            for ( int i = 0 ; i < num_instances1 ; i++) begin
                
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina1[i][j]=0;
                end
            end
            for ( int i = 0 ; i < num_instances2 ; i++) begin
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina2[i][j]=0;
                end
            end  
        end 
        16'b000000000001000:begin//reading layer squeeze6_end
           clock1 = 0;
           clock2 = 0;
           rw=0;
           startdata=-1;
           numchannels=63;
           norm_numofchannels=0;
           stride_expand=1;
           no_of_win_expand=255; 
           rowwin=15;
           lengthofrow=18;
            for ( int i = 0 ; i < num_instances1 ; i++) begin
                
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina1[i][j]=0;
                end
            end
            for ( int i = 0 ; i < num_instances2 ; i++) begin
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina2[i][j]=0;
                end
            end    
        end
        16'b000000000000100:begin//reading layer squeeze7_end
           clock1 = 0;
           clock2 = 0;
           norm_numofchannels=0;
           rw=0;
           startdata=-1;
           numchannels=63;
           stride_expand=1;
           no_of_win_expand=255; 
           lengthofrow=18;
           rowwin=15;
            for ( int i = 0 ; i < num_instances1 ; i++) begin
                
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina1[i][j]=0;
                end
            end
            for ( int i = 0 ; i < num_instances2 ; i++) begin
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina2[i][j]=0;
                end
            end   
        end
        16'b000000000000010:begin//reading layer squeeze8_end
           clock1 = 0;
           clock2 = 0;
           norm_numofchannels=0;
           rw=0;
           startdata=-1;
           numchannels=111;
           stride_expand=1;
           rowwin=7;
           no_of_win_expand=63; 
           lengthofrow=10;
            for ( int i = 0 ; i < num_instances1 ; i++) begin
                
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina1[i][j]=0;
                end
            end
            for ( int i = 0 ; i < num_instances2 ; i++) begin
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina2[i][j]=0;
                end
            end   
        end
        16'b000000000000001:begin//reading layer squeeze9_end
           clock1 = 0;
           clock2 = 0;
           rw=0;
           startdata=-1;
           norm_numofchannels=0;
           numchannels=111;
           stride_expand=1;
           no_of_win_expand=63; 
           lengthofrow=10;
           rowwin=7;
            for ( int i = 0 ; i < num_instances1 ; i++) begin
                
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina1[i][j]=0;
                end
            end
            for ( int i = 0 ; i < num_instances2 ; i++) begin
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina2[i][j]=0;
                end
            end   
        end
       
       
        default: begin
            clock1 = 0;
            clock2 = 0;
            norm_numofchannels=0;
            rw=2;
            startdata=0;
            stride_expand=0;
            no_of_win_expand=0; 
            numchannels=0;
            lengthofrow=0;
            rowwin=0; 
            for ( int i = 0 ; i < num_instances1 ; i++) begin
                
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina1[i][j]=0;
                end
            end
            for ( int i = 0 ; i < num_instances2 ; i++) begin
                for ( int j = 0 ; j < ram_num ; j++) begin
                   dina2[i][j]=0;
                end
            end
        end
        endcase
    end
always@(posedge clk) begin
    if(rw==1) begin
        if(newlayer) begin
            set1_counter<=0;
            flag1<=0;
            flag2<=0;
            flag4<=0;
            countwin<=0;
            set2_counter<=0;
            rowcounter<=0;
            flagreset<=0;
            resetmem<=1;
                for(int addressrams_counter=0;addressrams_counter<ram_num;addressrams_counter++) begin
                    addrb1[addressrams_counter]<=-1;
		            addrb2[addressrams_counter]<=startdata;
                    addra1[addressrams_counter]<=-1;
                    addra2[addressrams_counter]<=startdata;
                    for(int instances_counter=0;instances_counter<num_instances1;instances_counter++) begin
                        ena1[instances_counter][addressrams_counter]<=0;
                        wea1[instances_counter][addressrams_counter]<=0;
                    end
		    for(int instances_counter=0;instances_counter<num_instances2;instances_counter++) begin
                        ena2[instances_counter][addressrams_counter]<=0;
                        wea2[instances_counter][addressrams_counter]<=0;
                    end
                end
            
        end
        if(resetmem) begin
        
            for(int addressrams_counter=0;addressrams_counter<ram_num;addressrams_counter++) begin
                
                    addrb1[addressrams_counter]<=addrb1[addressrams_counter]+1;
		    addrb2[addressrams_counter]<=addrb2[addressrams_counter]+1;
                    enb[addressrams_counter]<=1;
                    web[addressrams_counter]<=1;
            end
            flagreset<=1;
            if(addrb2[0]==startdata && flagreset) begin
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
               
               if(ensqueeze2||ensqueeze3)begin
                    for(int rams=0;rams<ram_num;rams++)begin
                    ena1[set1_counter][rams]<=1;
                    wea1[set1_counter][rams]<=1;
                   end
              end
              else if(ensqueeze4||ensqueeze5)begin
                    for(int rams=0;rams<ram_num;rams++)begin
                    ena1[set1_counter][rams]<=1;
                    wea1[set1_counter][rams]<=1;
                    ena1[set1_counter+1][rams]<=1;
                    wea1[set1_counter+1][rams]<=1;
                   end
              end
              else if(ensqueeze6||ensqueeze7)begin
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
              else if(ensqueeze8||ensqueeze9)begin
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
                    ena1[set1_counter+6][rams]<=1;
                    wea1[set1_counter+6][rams]<=1;
                   end
              end
              
              
               
              if(addra1[0]==1022) begin
                   if(set1_counter>=num_instances1-1)begin
                        flag1<=1;
                        end
                   else  
                        set1_counter<=set1_counter+norm_numofchannels;//to jump to next instances
               end
               
                   for(int addressrams_counter=0;addressrams_counter<ram_num;addressrams_counter++) begin
    
                       addra1[addressrams_counter]<=addra1[addressrams_counter]+1;
                       
                   end
               
            end
        end
        else begin
            for (int i=0;i<num_instances1;i++)begin
                ena1[i]<=0;
                wea1[i]<=0;
            end
        end

        
        if(clock2) begin
                if(!flag2) begin
                if(ensqueeze2||ensqueeze3)begin
                    for(int rams=0;rams<ram_num;rams++)begin
                    ena2[set2_counter][rams]<=1;
                    wea2[set2_counter][rams]<=1;
                   end
              end
              else if(ensqueeze4||ensqueeze5)begin
                    for(int rams=0;rams<ram_num;rams++)begin
                    ena2[set2_counter][rams]<=1;
                    wea2[set2_counter][rams]<=1;
                    ena2[set2_counter+1][rams]<=1;
                    wea2[set2_counter+1][rams]<=1;
                   end
              end
              else if(ensqueeze6||ensqueeze7)begin
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
              else if(ensqueeze8||ensqueeze9)begin
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
                    ena2[set2_counter+6][rams]<=1;
                    wea2[set2_counter+6][rams]<=1;
                   end
              end
              
                   if(rowcounter==lengthofrow&&addra2[0]!=1020) begin
                       flag4<=1;
                       
                   end
                   if(rowcounter==lengthofrow)begin
                        rowcounter<=0;
                   end
                   else rowcounter<=rowcounter+1;
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
                   
                   if(addra2[0]==1022|| (addra2[0]==1020 && flag4)||(addra2[0]==1020 && rowcounter==lengthofrow )) begin
                       if(set2_counter>=num_instances2-1)
                            flag2<=1;
                       else  
                            set2_counter<=set2_counter+norm_numofchannels;
                   end
                end
            
            
        end
        else begin
            for (int i=0;i<num_instances2;i++)begin
                ena2[i]<=0;
                wea2[i]<=0;
            end
        end
    end
    else if(rw==0) begin
        if(newlayer)begin
            index1<=0;
            win1<=0;
            channels_1<=0;
            winref2<=0;
            winref1<=0;
            resetmem<=0;
            channels1_1<=0;
            channels2_1<=0;
            channels3_1<=0;
            a01<=0;
            a11<=0;
            channels1_counter<=0;
            channels2_counter<=0;
            row1<=0;
            col1<=0;
            numwin1<=0;
            index2<=0;
            win2<=0;
            countwin<=0;
            channels_2<=0;
            channels1_2<=0;
            channels2_2<=0;
            channels3_2<=0;
            a02<=0;
            a12<=0;
            row2<=0;
            col2<=0;
            numwin2<=0;
            flagread2<=0;
            flagread2_shiftedagain<=0;
            flagread2_shifted<=0;
            flagread2_shiftedagainagain<=0;
            flagread1<=0;
            flagread1_shiftedagain<=0;
            flagread1_shifted<=0;
            flagread1_shiftedagainagain<=0;
            for(int addressrams_counter=0;addressrams_counter<ram_num;addressrams_counter++) begin
            
                addra1[addressrams_counter]<=0;
                addra2[addressrams_counter]<=0;
                enb[addressrams_counter]<=0;
                web[addressrams_counter]<=0;
                for(int instances_counter=0;instances_counter<num_instances1;instances_counter++) begin
                  ena1[instances_counter][addressrams_counter]<=0;
                  wea1[instances_counter][addressrams_counter]<=0;
                
                end
	        for(int instances_counter=0;instances_counter<num_instances2;instances_counter++) begin
                  ena2[instances_counter][addressrams_counter]<=0;
                  wea2[instances_counter][addressrams_counter]<=0;
                
                end
            end
        end
        ///////////////////////////////////////start reading/////////////////////////////////////////////
        else begin
            
            if(!flagread2_shiftedagainagain)begin
            flagread2_shifted<=flagread2;
            flagread2_shiftedagain<=flagread2_shifted;
            flagread2_shiftedagainagain<=flagread2_shiftedagain;
            channels1_2<=channels_2;
            channels2_2<=channels1_2;
            channels3_2<=channels2_2;
            if(index2_shifted<2**address) begin
                addra2[channels1_2]<=truncated_index2[9:0];
                a02<=0;
                a12<=a02;
                for(int instances=0;instances<num_instances2;instances++)begin
                    if(instances==0)begin
                        ena2[instances][channels1_2]<=1;
                        for(ram_numcounter=0;ram_numcounter<ram_num;ram_numcounter++)begin
                            if(ram_numcounter[3:0]!=channels1_2)begin
                                ena2[instances][ram_numcounter[3:0]]<=0;
                            end
                        end
                    end
                    else begin
                        for (int i=0;i<ram_num;i++)begin
                            ena2[instances][i]<=0;
                        end
                    end
                end          
                
            end
            else if(index2_shifted<2*(2**address)) begin
                addra2[channels1_2]<=truncated_index2[9:0];
                a02<=1;
                a12<=a02;
                for(int instances=0;instances<num_instances2;instances++)begin
                    if(instances==1)begin
                        ena2[instances][channels1_2]<=1;
                        for(ram_numcounter=0;ram_numcounter<ram_num;ram_numcounter++)begin
                            if(ram_numcounter[3:0]!=channels1_2)begin
                                ena2[instances][ram_numcounter[3:0]]<=0;
                            end
                        end
                    end
                    else begin 
                        for (int i=0;i<ram_num;i++)begin
                            ena2[instances][i]<=0;
                        end
                    end
                end 
            end
            else if(index2_shifted<3*(2**address)) begin
                addra2[channels1_2]<=truncated_index2[9:0];
                a02<=2;
                a12<=a02;
                for(int instances=0;instances<num_instances2;instances++)begin
                    if(instances==2)begin
                        ena2[instances][channels1_2]<=1;
                        for(ram_numcounter=0;ram_numcounter<ram_num;ram_numcounter++)begin
                            if(ram_numcounter[3:0]!=channels1_2)begin
                                ena2[instances][ram_numcounter[3:0]]<=0;
                            end
                        end
                    end
                    else begin 
                        for (int i=0;i<ram_num;i++)begin
                            ena2[instances][i]<=0;
                        end
                    end
                 end 
            end
            else if(index2_shifted<4*(2**address)) begin
                addra2[channels1_2]<=truncated_index2[9:0];
                a02<=3;
                a12<=a02;
                for(int instances=0;instances<num_instances2;instances++)begin
                    if(instances==3)begin
                        ena2[instances][channels1_2]<=1;
                        for(ram_numcounter=0;ram_numcounter<ram_num;ram_numcounter++)begin
                            if(ram_numcounter[3:0]!=channels1_2)begin
                                ena2[instances][ram_numcounter[3:0]]<=0;
                            end
                        end
                    end
                    else begin 
                        for (int i=0;i<ram_num;i++)begin
                            ena2[instances][i]<=0;
                        end
                    end
                end 
            end
            else if(index2_shifted<5*(2**address)) begin
                addra2[channels1_2]<=truncated_index2[9:0];
                a02<=4;
                a12<=a02;
                for(int instances=0;instances<num_instances2;instances++)begin
                    if(instances==4)begin
                        ena2[instances][channels1_2]<=1;
                        for(ram_numcounter=0;ram_numcounter<ram_num;ram_numcounter++)begin
                            if(ram_numcounter[3:0]!=channels1_2)begin
                                ena2[instances][ram_numcounter[3:0]]<=0;
                            end
                        end
                    end
                    else begin 
                        for (int i=0;i<ram_num;i++)begin
                            ena2[instances][i]<=0;
                        end
                    end
                end 
            end
            else if(index2_shifted<6*(2**address)) begin
                addra2[channels1_2]<=truncated_index2[9:0];
                a02<=5;
                a12<=a02;
                for(int instances=0;instances<num_instances2;instances++)begin
                    if(instances==5)begin
                        ena2[instances][channels1_2]<=1;
                        for(ram_numcounter=0;ram_numcounter<ram_num;ram_numcounter++)begin
                            if(ram_numcounter[3:0]!=channels1_2)begin
                                ena2[instances][ram_numcounter[3:0]]<=0;
                            end
                        end
                    end
                    else begin 
                        for (int i=0;i<ram_num;i++)begin
                            ena2[instances][i]<=0;
                        end
                    end
                end 
            end
            else if(index2_shifted<7*(2**address)) begin
                addra2[channels1_2]<=truncated_index2[9:0];
                a02<=6;
                a12<=a02;
                for(int instances=0;instances<num_instances2;instances++)begin
                    if(instances==6)begin
                        ena2[instances][channels1_2]<=1;
                        for(ram_numcounter=0;ram_numcounter<ram_num;ram_numcounter++)begin
                            if(ram_numcounter[3:0]!=channels1_2)begin
                                ena2[instances][ram_numcounter[3:0]]<=0;
                            end
                        end
                    end
                    else begin 
                        for (int i=0;i<ram_num;i++)begin
                            ena2[instances][i]<=0;
                        end
                    end
                end 
            end
            
                 
            if(col2==2) begin
                    if(row2==2)begin
                        row2<=0;
                        if({1'b0,channels_2}==ram_num-2)begin
                        if({1'b0,channels2_counter}>=numchannels-1)begin
                            if(countwin==rowwin)begin
                                win2<=win2+2*stride_expand+1;//stride 
                                countwin<=0;
                                end
                            else begin
                            win2<=win2+{13'b0,stride_expand};
                            countwin<=countwin+1;
                            end
                            end
                        end
                        if({1'b0,channels_2}==ram_num-1)begin
                            if(channels2_counter<numchannels)begin
                                channels_2<=0;
                                col2<=0;
                                channels2_counter<=channels2_counter+1;
                                if(numchannels==2*ram_num-1 &&(win2>=1024 &&win2<2048)) index2<=winref2+1024+1024;
                                else index2<=winref2+1024;  
                                winref2<=winref2+1024;
                            end
                            else begin
                                channels_2<=0;
				                channels2_counter<=0;
                                if(numwin2==no_of_win_expand) begin//no_of_win_expand
                                    flagread2<=1;
                                end
                                
                                else begin
                                    col2<=3;
                                    numwin2<=numwin2+1;
                                    winref2<=win2;
                                    if(numchannels==2*ram_num-1 &&(win2>=1024 &&win2<2048)) index2<=win2-1+1024;
                                    else index2<=win2-1;
                                   
                                end
                            end
                        end
                        else begin
                            col2<=0;
                            channels_2<=channels_2+1;
                            channels2_counter<=channels2_counter+1;
                            if(channels2_counter<16)begin
                                if(numchannels==2*ram_num-1 &&(winref2>=1024 &&winref2<2048)) index2<=winref2+1024;
                                else index2<=winref2;
                            end
                            else if(channels2_counter>=16)begin
                                if(numchannels==2*ram_num-1 &&(winref2>=2048 &&winref2<3072)) index2<=winref2+1024;
                                else index2<=winref2;
                            end
                        end
                        
                    end
                    
                    else begin
                        row2<=row2+1;
                         col2<=0;
                         if(channels2_counter<16)begin
                             if(numchannels==2*ram_num-1 &&(index2>=992 &&index2<2048)) index2<=index2+({7'b0,lengthofrow}-2)+1024;
                             else index2<=index2+({7'b0,lengthofrow}-2);//shift row 130
                         end
                         else if(channels2_counter>=16)begin
                            if(numchannels==2*ram_num-1 &&(index2>=2016 &&index2<3072)) index2<=index2+({7'b0,lengthofrow}-2)+1024;
                            else index2<=index2+({7'b0,lengthofrow}-2);//shift row 130
                         end
                         
                     end
                end
            else begin
                col2<=col2+1;
                if(col2!=3)begin
                    if(channels2_counter<16)begin
                        if(numchannels==2*ram_num-1 &&(index2>=1023 &&index2<2048)) index2<=index2+1+1024;
                        else index2<=index2+1;
                    end
                    else if (channels2_counter>=16)begin
                        if(numchannels==2*ram_num-1 &&(index2>=2047 &&index2<3072)) index2<=index2+1+1024;
                        else index2<=index2+1;
                    end
                end
                else index2<=index2+1;
            end    
        end
        else begin
            for(int addressrams_counter=0;addressrams_counter<ram_num;addressrams_counter++) begin
                addra2[addressrams_counter]<=0;
                for(int instances_counter=0;instances_counter<num_instances1;instances_counter++) begin
                    ena2[instances_counter][addressrams_counter]<=0;
                end
            end
            
        end/// layers read from set2
        if(!flagread1_shiftedagainagain) begin
            flagread1_shifted<=flagread1;
            flagread1_shiftedagain<=flagread1_shifted;
            flagread1_shiftedagainagain<=flagread1_shiftedagain;
            channels1_1<=channels_1;
            channels2_1<=channels1_1;
            channels3_1<=channels2_1;
            if(index1_shifted<2**address) begin
                addra1[channels1_1]<=truncated_index1[9:0];
                a01<=0;
                a11<=a01;
                for(int instances=0;instances<num_instances1;instances++)begin
                    if(instances==0)begin
                        ena1[instances][channels1_1]<=1;
                        for(ram_numcounter=0;ram_numcounter<ram_num;ram_numcounter++)begin
                            if(ram_numcounter[3:0]!=channels1_1)begin
                                ena1[instances][ram_numcounter[3:0]]<=0;
                            end
                        end
                    end
                    else begin
                        for (int i=0;i<ram_num;i++)begin
                            ena1[instances][i]<=0;
                        end
                    end
                end          
                
            end
            else if(index1_shifted<2*(2**address)) begin
                addra1[channels1_1]<=truncated_index1[9:0];
                a01<=1;
                a11<=a01;
                for(int instances=0;instances<num_instances1;instances++)begin
                    if(instances==1)begin
                        ena1[instances][channels1_1]<=1;
                        for(ram_numcounter=0;ram_numcounter<ram_num;ram_numcounter++)begin
                            if(ram_numcounter[3:0]!=channels1_1)begin
                                ena1[instances][ram_numcounter[3:0]]<=0;
                            end
                        end
                    end
                    else begin 
                        for (int i=0;i<ram_num;i++)begin
                            ena1[instances][i]<=0;
                        end
                    end
                end 
            end
            else if(index1_shifted<3*(2**address)) begin
                addra1[channels1_1]<=truncated_index1[9:0];
                a01<=2;
                a11<=a01;
                for(int instances=0;instances<num_instances1;instances++)begin
                    if(instances==2)begin
                        ena1[instances][channels1_1]<=1;
                        for(ram_numcounter=0;ram_numcounter<ram_num;ram_numcounter++)begin
                            if(ram_numcounter[3:0]!=channels1_1)begin
                                ena1[instances][ram_numcounter[3:0]]<=0;
                            end
                        end
                    end
                    else begin 
                        for (int i=0;i<ram_num;i++)begin
                            ena1[instances][i]<=0;
                        end
                    end
                 end 
            end
            else if(index1_shifted<4*(2**address)) begin
                addra1[channels1_1]<=truncated_index1[9:0];
                a01<=3;
                a11<=a01;
                for(int instances=0;instances<num_instances1;instances++)begin
                    if(instances==3)begin
                        ena1[instances][channels1_1]<=1;
                        for(ram_numcounter=0;ram_numcounter<ram_num;ram_numcounter++)begin
                            if(ram_numcounter[3:0]!=channels1_1)begin
                                ena1[instances][ram_numcounter[3:0]]<=0;
                            end
                        end
                    end
                    else begin
                    for (int i=0;i<ram_num;i++)begin
                            ena1[instances][i]<=0;
                        end
                    end
                end 
            end
            else if(index1_shifted<5*(2**address)) begin
                addra1[channels1_1]<=truncated_index1[9:0];
                a01<=4;
                a11<=a01;
                for(int instances=0;instances<num_instances1;instances++)begin
                    if(instances==4)begin
                        ena1[instances][channels1_1]<=1;
                        for(ram_numcounter=0;ram_numcounter<ram_num;ram_numcounter++)begin
                            if(ram_numcounter[3:0]!=channels1_1)begin
                                ena1[instances][ram_numcounter[3:0]]<=0;
                            end
                        end
                    end
                    else begin
                        for (int i=0;i<ram_num;i++)begin
                            ena1[instances][i]<=0;
                        end
                    end
                end 
            end
            else if(index1_shifted<6*(2**address)) begin
                addra1[channels1_1]<=truncated_index1[9:0];
                a01<=5;
                a11<=a01;
                for(int instances=0;instances<num_instances1;instances++)begin
                    if(instances==5)begin
                        ena1[instances][channels1_1]<=1;
                        for(ram_numcounter=0;ram_numcounter<ram_num;ram_numcounter++)begin
                            if(ram_numcounter[3:0]!=channels1_1)begin
                                ena1[instances][ram_numcounter[3:0]]<=0;
                            end
                        end
                    end
                    else begin 
                        for (int i=0;i<ram_num;i++)begin
                            ena1[instances][i]<=0;
                        end
                    end
                end 
            end
            else if(index1_shifted<7*(2**address)) begin
                addra1[channels1_1]<=truncated_index1[9:0];
                a01<=6;
                a11<=a01;
                for(int instances=0;instances<num_instances2;instances++)begin
                    if(instances==6)begin
                        ena1[instances][channels1_1]<=1;
                        for(ram_numcounter=0;ram_numcounter<ram_num;ram_numcounter++)begin
                            if(ram_numcounter[3:0]!=channels1_1)begin
                                ena1[instances][ram_numcounter[3:0]]<=0;
                            end
                        end
                    end
                    else begin 
                        for (int i=0;i<ram_num;i++)begin
                            ena1[instances][i]<=0;
                        end
                    end
                end 
            end
            
            if(col1==0) begin
                    if(row1==0)begin
                        row1<=0;
                        if({1'b0,channels_1}==ram_num-2)begin
                            if(channels1_counter>=numchannels-1)
                            win1<=win1+{13'b0,stride_expand}; //stride 
                        end
                        if({1'b0,channels_1}==ram_num-1)begin//for expand 2,3 no of channels =ram num
                            if( channels1_counter<numchannels)begin//for expand 2,3 channels = channels_counter
                                channels_1<=0;
                                col1<=0;
                                index1<=winref1+1024;
                                winref1<=winref1+1024;
                                channels1_counter<=channels1_counter+1;
                            end
                            else begin
                                channels_1<=0;
				                channels1_counter<=0;
                                if(numwin1==no_of_win_expand) begin//no_of_win_expand
                                    flagread1<=1;
                                end
                                
                                else begin
                                    col1<=3;
                                    numwin1<=numwin1+1;
                                    index1<=win1-1;
                                    winref1<=win1;
                                end
                            end
                        end
                        else begin
                            col1<=0;
                            channels_1<=channels_1+1;
                            channels1_counter<=channels1_counter+1;
                            index1<=winref1;
                        end
                        
                    end
                    
                    else begin
                         index1<=index1+1;
                         row1<=row1+1;
                         col1<=0;
                     end
                end
            else begin
                index1<=index1+1;
                col1<=col1+1;
            end
        end 
        else begin
            for(int addressrams_counter=0;addressrams_counter<ram_num;addressrams_counter++) begin
                addra1[addressrams_counter]<=0;
                for(int instances_counter=0;instances_counter<num_instances1;instances_counter++) begin
                    ena1[instances_counter][addressrams_counter]<=0;
                end
            end
        end    
    end
    end
end

always@(posedge clk  )begin///////choose enable for reading layer
    if(rw==0)begin
        if(newlayer) startcounter<=1;

        else begin
            if(startcounter==3)begin
                if(squeeze2_end)begin
                enexpand2<=1;
                expand21x1<=douta1[a11][channels3_1];
                expand23x3<=douta2[a12][channels3_2];
                end
                else if(squeeze3_end)begin
                enexpand3<=1;
                expand31x1<=douta1[a11][channels3_1];
                expand33x3<=douta2[a12][channels3_2];
                end
                else if(squeeze4_end)begin
                enexpand4<=1;
                expand41x1<=douta1[a11][channels3_1];
                expand43x3<=douta2[a12][channels3_2];
                end
                else if(squeeze5_end)begin
                enexpand5<=1;
                expand51x1<=douta1[a11][channels3_1];
                expand53x3<=douta2[a12][channels3_2];
                end
                else if(squeeze6_end)begin
                enexpand6<=1;
                expand61x1<=douta1[a11][channels3_1];
                expand63x3<=douta2[a12][channels3_2];
                end
                else if(squeeze7_end)begin
                enexpand7<=1;
                expand71x1<=douta1[a11][channels3_1];
                expand73x3<=douta2[a12][channels3_2];
                end
                else if(squeeze8_end)begin
                enexpand8<=1;
                expand81x1<=douta1[a11][channels3_1];
                expand83x3<=douta2[a12][channels3_2];
                end
                else if(squeeze9_end)begin
                enexpand9<=1;
                expand91x1<=douta1[a11][channels3_1];
                expand93x3<=douta2[a12][channels3_2];
                end
                /*else if(conv10_2end)begin
                enconv10_2<=1;
                conv10_2<=douta[a1][channels3];
                end*/
            end
            else begin
                startcounter<=startcounter+1;
            end
        end
    end 

        else begin
            enexpand2<=0;
            enexpand3<=0;
            enexpand4<=0;
            enexpand5<=0;
            enexpand6<=0;
            enexpand7<=0;
            enexpand8<=0;
            enexpand9<=0;
        end
end     

always@(posedge clk  )begin/// trancated index sync
    if(!flagread1 ||!flagread2) begin
        index2_shifted<=index2;
        if(index2<2**address) truncated_index2<=index2;
        else if(index2<2*(2**address)) truncated_index2<=index2-(2**address);
        else if(index2<3*(2**address)) truncated_index2<=index2-(2*(2**address));
        else if(index2<4*(2**address)) truncated_index2<=index2-3*(2**address);
        else if(index2<5*(2**address)) truncated_index2<=index2-4*(2**address);
        else if(index2<6*(2**address)) truncated_index2<=index2-5*(2**address);
        else if(index2<7*(2**address)) truncated_index2<=index2-6*(2**address);
        index1_shifted<=index1;
        if(index1<2**address) truncated_index1<=index1;
        else if(index1<2*(2**address)) truncated_index1<=index1-(2**address);
        else if(index1<3*(2**address)) truncated_index1<=index1-(2*(2**address));
        else if(index1<4*(2**address)) truncated_index1<=index1-3*(2**address);
        else if(index1<5*(2**address)) truncated_index1<=index1-4*(2**address);
        else if(index1<6*(2**address)) truncated_index1<=index1-5*(2**address);
        else if(index1<7*(2**address)) truncated_index1<=index1-6*(2**address);
  end
end
endmodule
