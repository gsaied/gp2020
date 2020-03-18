`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/14/2020 09:43:24 PM
// Design Name: 
// Module Name: zynqnet
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

module zynqnet#(
    parameter ram_num1=64,
    parameter ram_num2=16,
    parameter width =16
)
(
    input clk,
	input zynqnet_en,
	//output reg zynqnet_end , 
	output reg [9:0] zynqnet_output
    );
   
 ///////////////////////////RAM define parameters ////////////////////////////////////////////
    wire conv1_end; 
    wire expand2_end;
	wire expand3_end;
	wire expand4_end;
	wire expand5_end;
	wire expand6_end;
	wire expand7_end;
	wire expand8_end;
	wire expand9_end;
    wire squeeze2_end;
    wire squeeze3_end;
    wire squeeze4_end;
    wire squeeze5_end;
    wire squeeze6_end;
    wire squeeze7_end;
    wire squeeze8_end;
    wire squeeze9_end;
    wire conv10_1end;
    wire conv10_2end;// increased this ???
    ///////////////////////////////////
    reg [width-1:0] squeeze2out[0:ram_num2-1];
    reg [width-1:0] squeeze3out[0:ram_num2-1];
    reg [width-1:0] squeeze4out[0:2*ram_num2-1];
    reg [width-1:0] squeeze5out[0:2*ram_num2-1];
    reg [width-1:0] squeeze6out[0:4*ram_num2-1];
    reg [width-1:0] squeeze7out[0:4*ram_num2-1];
    reg [width-1:0] squeeze8out[0:7*ram_num2-1];
    reg [width-1:0] squeeze9out[0:7*ram_num2-1];
    reg [width-1:0] conv10_1out[0:32*ram_num2-1];////////outputs to average pooling//////////////
  //  reg [width-1:0] conv10_2out[0:32*ram_num2-1];//////////////////////
    wire [width-1:0] conv1out[0:ram_num1-1];
    wire [width-1:0] expand31x1out[0:ram_num1-1];
    wire [width-1:0] expand33x3out[0:ram_num1-1];
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
    wire clkexpand41x1;
    wire clkexpand43x3;
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
    reg enconv1;
    wire enexpand2;
    wire ensqueeze2;
    wire enexpand3;
    wire ensqueeze3;
    wire enexpand4;
    wire ensqueeze4;
    wire enexpand5;
    wire ensqueeze5;
    wire enexpand6;
    wire ensqueeze6;
    wire enexpand7;
    wire ensqueeze7;
    wire enexpand8;
    wire ensqueeze8;
    wire enexpand9;
    wire ensqueeze9;
    wire enconv10_1;
    wire enconv10_2;
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
    wire  en_softmax;   //////////////increased
	wire [width-1:0] pooltomax ; /////// incresed output from pooling
 //// layers ////////////////////////////////////////////////////////////////////////////////////////
 
  conv1 conv1(.clk(clk),
              .conv1_en_i(enconv1),
              .ram_feedback(squeeze2_end),
              .conv1_finish(conv1_end),
              .ofm(conv1out),
              .conv1_sample(clkconv1));
              
  fire2_squeeze fire2_squeeze (.clk(clk),
              .fire2_squeeze_en_i(ensqueeze2),
              .ram_feedback(expand2_end),
              .ifm_i(squeeze2in),
              .fire2_squeeze_finish (squeeze2_end),
              .ofm(squeeze2out),
              .fire2_squeeze_sample(clksqueeze2));   
              
  fire2_3_expand_1 fire2_3_expand_1(.clk(clk),
              .fire2_expand_1_en_i(enexpand2),
              .fire3_expand_1_en_i(enexpand3),
              .ram_feedback_2(squeeze3_end),
              .ram_feedback_3(squeeze4_end),
              .ifm_2_i(expand21x1in),
              .ifm_3_i(expand31x1in),
              .ofm_3(expand31x1out),
              .fire2_expand_1_sample(clkexpand21x1));
  
  fire2_3_expand_3 fire2_3_expand_3(.clk(clk),
              .fire2_expand_3_en_i(enexpand2),
              .fire3_expand_3_en_i(enexpand3),
              .ram_feedback_2(squeeze3_end),
              .ram_feedback_3(squeeze4_end),
              .ifm_2_i(expand23x3in),
              .ifm_3_i(expand33x3in),
              .fire2_expand_3_finish(expand2_end),
              .fire3_expand_3_finish(expand3_end),
              .ofm_3(expand33x3out),
              .fire2_expand_3_sample(clkexpand23x3));  
  
  fire3_squeeze fire3_squeeze (.clk(clk),
              .fire3_squeeze_en_i(ensqueeze3),
              .ram_feedback(expand3_end),
              .ifm_i(squeeze3in),
              .fire3_squeeze_finish (squeeze3_end),
              .ofm(squeeze3out),
              .fire3_squeeze_sample(clksqueeze3)); 
                
  fire4_squeeze fire4_squeeze (.clk(clk),
              .fire4_squeeze_en_i(ensqueeze4),
              .ram_feedback(expand4_end),
              .ifm_i(squeeze4in),
              .fire4_squeeze_finish (squeeze4_end),
              .ofm(squeeze4out),
              .fire4_squeeze_sample(clksqueeze4));
              
  fire4_5_expand_1 fire4_5_expand_1(.clk(clk),
              .fire4_expand_1_en_i(enexpand4),
              .fire5_expand_1_en_i(enexpand5),
              .ram_feedback_4(squeeze5_end),
              .ram_feedback_5(squeeze6_end),
              .ifm_4_i(expand41x1in),
              .ifm_5_i(expand51x1in),
              .ofm_5(expand51x1out),
              .fire4_expand_1_sample(clkexpand41x1));   
              
  fire4_5_expand_3 fire4_5_expand_3(.clk(clk),
              .fire4_expand_3_en_i(enexpand4),
              .fire5_expand_3_en_i(enexpand5),
              .ram_feedback_4(squeeze5_end),
              .ram_feedback_5(squeeze6_end),
              .ifm_4_i(expand43x3in),
              .ifm_5_i(expand53x3in),
              .fire4_expand_3_finish(expand4_end),
              .fire5_expand_3_finish(expand5_end),
              .ofm_5(expand53x3out),
              .fire4_expand_3_sample(clkexpand43x3));  
              
  fire5_squeeze fire5_squeeze (.clk(clk),
              .fire5_squeeze_en_i(ensqueeze5),
              .ram_feedback(expand5_end),
              .ifm_i(squeeze5in),
              .fire5_squeeze_finish (squeeze5_end),
              .ofm(squeeze5out),
              .fire5_squeeze_sample(clksqueeze5));
              
  fire6_squeeze fire6_squeeze (.clk(clk),
              .fire6_squeeze_en_i(ensqueeze6),
              .ram_feedback(expand6_end),
              .ifm_i(squeeze6in),
              .fire6_squeeze_finish (squeeze6_end),
              .ofm(squeeze6out),
              .fire6_squeeze_sample(clksqueeze6)); // mesh mawgoda lesa 3la github
              
  fire6_expand1 fire6_expand1 (.clk(clk),
              .fire6_expand1_en_i(enexpand6) ,
              .ram_feedback(squeeze7_end),
              .ifm_i(expand61x1in),
              .ofm(expand61x1out),
              .fire6_expand1_sample(clkexpand61x1)); 
              
  fire6_expand3 fire6_expand3 (.clk(clk),
              .fire6_expand3_en_i(enexpand6) ,
              .ram_feedback(squeeze7_end),
              .ifm_i(expand63x3in),
              .fire6_expand3_finish (expand6_end),
              .ofm(expand63x3out),
              .fire6_expand3_sample(clkexpand63x3)); //mesh mawgoda 3la github
              
  fire7_squeeze fire7_squeeze (.clk(clk),
              .fire7_squeeze_en_i(ensqueeze7),
              .ram_feedback(expand7_end),
              .ifm_i(squeeze7in),
              .fire7_squeeze_finish (squeeze7_end),
              .ofm(squeeze7out),
              .fire7_squeeze_sample(clksqueeze7)); 
              
  fire7_expand1 fire7_expand1 (.clk(clk),
              .fire7_expand1_en_i(enexpand7) ,
              .ram_feedback(squeeze8_end),
              .ifm_i(expand71x1in),
              .ofm(expand71x1out),
              .fire7_expand1_sample(clkexpand71x1)); 
              
  fire7_expand3 fire7_expand3 (.clk(clk),
              .fire7_expand3_en_i(enexpand7) ,
              .ram_feedback(squeeze8_end),
              .ifm_i(expand73x3in),
              .fire7_expand3_finish (expand7_end),
              .ofm(expand73x3out),
              .fire7_expand3_sample(clkexpand73x3));
              
   squeeze_wrapper squeeze_wrapper (.clk(clk),
               .fire8_squeeze_en_i(ensqueeze8),
               .fire9_squeeze_en_i(ensqueeze9),
               .ifm8_i(squeeze8in),
               .ifm9_i(squeeze9in),
               .ram_feedback8(expand8_end),
               .ram_feedback9(expand9_end),
               .fire8_squeeze_sample(clksqueeze8),
               .fire9_squeeze_sample(clksqueeze9),
               .fire8_squeeze_finish(squeeze8_end) ,
               .fire9_squeeze_finish(squeeze9_end) ,
               .ofm8(squeeze8out) ,
               .ofm9 (squeeze9out));           
              
                            
  fire8_expand1 fire8_expand1 (.clk(clk),
              .fire8_expand1_en_i(enexpand8) ,
              .ram_feedback(squeeze9_end),
              .ifm_i(expand81x1in),
              .ofm(expand81x1out),
              .fire8_expand1_sample(clkexpand81x1)); //mesh mawgoda 3la github
              
  fire8_expand3 fire8_expand3 (.clk(clk),
              .fire8_expand3_en_i(enexpand8) ,
              .ram_feedback(squeeze9_end),
              .ifm_i(expand83x3in),
              .fire8_expand3_finish(expand8_end),
              .ofm(expand83x3out),
              .fire8_expand3_sample(clkexpand83x3)); //mesh mawgoda 3la github
             
  fire9_expand1 fire9_expand1 (.clk(clk),
              .fire9_expand1_en_i(enexpand9) ,
              .ram_feedback(conv10_1end),
              .ifm_i(expand91x1in),
              .ofm(expand91x1out),
              .fire9_expand1_sample(clkexpand91x1)); //mesh mawgoda 3la github
              
  fire9_expand3 fire9_expand3 (.clk(clk),
              .fire9_expand3_en_i(enexpand9) ,
              .ram_feedback(conv10_1end),
              .fire9_expand3_finish(expand9_end),
              .ifm_i(expand93x3in),
              .ofm(expand93x3out),
              .fire9_expand3_sample(clkexpand93x3)); 
              
  conv10_1_2 conv10_1_2 (.clk(clk),
              .conv10_1_en_i(enconv10_1),
              .conv10_2_en_i(enconv10_2),
	          .ram_feedback_1(conv10_2end),
	          .ram_feedback_2(0), 
              .ifm_1_i(conv10_1in),
              .ifm_2_i(conv10_2in),
              .conv10_1_finish(conv10_1end),
              .conv10_2_finish(conv10_2end),
              .ofm(conv10_1out),
              .conv10_1_sample(clkconv10_1));       


  acc_array pool (.clk(clk),
              .conv10_1_end(conv10_1end),
              .conv10_2_end(conv10_2end),
              .en_conv10_1(enconv10_1),
              .en_conv10_2(enconv10_2),
              .conv10_1_out(conv10_1out),
              .conv10_2_out(conv10_1out),
              .conv10_sample(clkconv10_1),
              .en_softmax(en_softmax),
              .pooltomax(pooltomax));
              
  nonsoftmax nonsoftmax(.clk(clk),
              .en_softmax(en_softmax),
              .fm(pooltomax),
              .prediction(zynqnet_output));
  
 ////////// RAM ///////////////////////////////////
FirstSharedMemory BRAM1(
                .clk(clk),
                .conv1(conv1out),
                .expand21x1(expand31x1out),
                .expand31x1(expand31x1out),
                .expand41x1(expand51x1out),
                .expand51x1(expand51x1out),
                .expand61x1(expand61x1out),
                .expand71x1(expand71x1out),
                .expand81x1(expand81x1out),
                .expand91x1(expand91x1out),
                .expand23x3(expand33x3out),
                .expand33x3(expand33x3out),
                .expand43x3(expand53x3out),
                .expand53x3(expand53x3out),
                .expand63x3(expand63x3out),
                .expand73x3(expand73x3out),
                .expand83x3(expand83x3out),
                .expand93x3(expand93x3out),
                .clkconv1(clkconv1),
                .clkexpand21x1(clkexpand21x1),
                .clkexpand23x3(clkexpand23x3),
                .clkexpand31x1(clkexpand21x1),
                .clkexpand33x3(clkexpand23x3),
                .clkexpand41x1(clkexpand41x1),
                .clkexpand43x3(clkexpand43x3),
                .clkexpand51x1(clkexpand41x1),
                .clkexpand53x3(clkexpand43x3),
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
                .enexpand3(enexpand3),
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
                .conv10_2(conv10_2in)
                );
////////////////////////////////////////////////////////////////
SecondSharedMemory BRAM2(
                .clk(clk),
                .squeeze2(squeeze2out),
                .squeeze3(squeeze3out),
                .squeeze4(squeeze4out),
                .squeeze5(squeeze5out),
                .squeeze6(squeeze6out),
                .squeeze7(squeeze7out),
                .squeeze8(squeeze8out),
                .squeeze9(squeeze9out),
                .clksqueeze2(clksqueeze2),
                .clksqueeze3(clksqueeze3),
                .clksqueeze4(clksqueeze4),
                .clksqueeze5(clksqueeze5),
                .clksqueeze6(clksqueeze6),
                .clksqueeze7(clksqueeze7),
                .clksqueeze8(clksqueeze8),
                .clksqueeze9(clksqueeze9),
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
                .enexpand2(enexpand2),
                .enexpand3(enexpand3),
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
                .expand93x3(expand93x3in));
 
 //////////////////////////////////////////////////
 reg g =1;
 always @(posedge clk)
 begin
 if (conv1_end)begin
    enconv1<=0;
    g<=0;
    end
 else if (zynqnet_en)
    enconv1<=g;
 end  

   
          
endmodule
