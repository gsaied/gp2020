module fire2_squeeze3x3(data_ram , weight_rom ,bias_rom, en_fire2 , clk , rst_fire2 , out_fire2);
 
parameter DATA_WIDTH_IN = 16 ; //input bits
parameter DATA_WIDTH_FILTER=16; //filter bits
parameter DATA_WIDTH_bias=16; //bias bits
parameter filterCount=16;  
parameter DATA_WIDTH_OUT = 32 ; 
parameter DATA_WIDTH_OUT_quantized = 16 ;
//--------------Input/Out Ports----------------------- 
input [DATA_WIDTH_IN-1:0] data_ram;
input [DATA_WIDTH_FILTER-1:0] weight_rom [filterCount-1:0] ;
input [DATA_WIDTH_bias-1:0] bias_rom [filterCount-1:0];
input clk;
input en_fire2;
input rst_fire2;
output reg [DATA_WIDTH_OUT_quantized-1:0] out_fire2[filterCount-1:0];
reg [DATA_WIDTH_OUT_quantized-1:0] out_fire2_quantized [filterCount-1:0];
reg [DATA_WIDTH_OUT_quantized-1:0] in_relu [filterCount-1:0];
reg [DATA_WIDTH_IN-1:0] data_ram_sig;
reg [DATA_WIDTH_FILTER-1:0] weight_rom_sig [filterCount-1:0];
reg clear ;
reg [9:0]counter =10'b0;
reg [DATA_WIDTH_OUT_quantized-1:0] rep_relu;
reg [DATA_WIDTH_OUT-1:0] out_fire2_sig[filterCount-1:0];

//--------------Code Starts Here------------------ 

genvar i;
generate 
	for (i=0; i < filterCount; i=i+1) 
	begin :mac 
        mac mac_fire2(
        .pix(data_ram_sig),
        .ker(weight_rom_sig[i]),
        .clk(clk),
	.rst(!en_fire2),
	.clr(clear),
        .mul_out(out_fire2_sig[i])
);
end

endgenerate 
 always@(posedge clk or negedge rst_fire2)
    begin
	if (!rst_fire2)
		clear <= 1'b0;
	
	else if(counter<576) // 3x3x64
		begin
			clear <= 1'b1;			
		      data_ram_sig =data_ram;
			for ( int i = 0 ; i<filterCount; i=i+1)
			 begin
				weight_rom_sig[i]=weight_rom[i];
			 end
		end
	else 
		begin
			for (int i = 0 ; i<filterCount; i=i+1)
			begin
				out_fire2_quantized[i] = out_fire2_sig[i][31:16];
				in_relu[i] =out_fire2_quantized[i]+bias_rom[i];
				rep_relu = {16{~in_relu[i][15]}};
				out_fire2[i]= rep_relu & in_relu[i] ;
				
			 end
			 clear <= 1'b0;
			 counter <=10'b0;
		end
    end



endmodule