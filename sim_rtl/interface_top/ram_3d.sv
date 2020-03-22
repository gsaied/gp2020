module ram_3d #(
	parameter ram_num = 64 ,
	parameter width= 16 ,
	parameter address= 10
)
(
	input clk,
	input [ram_num-1:0] wea,
	input [ram_num-1:0] ena,
	input [ram_num-1:0] web,
	input [ram_num-1:0] enb,
	input [address-1:0] addra [0:ram_num-1],
	input [address-1:0] addrb [0:ram_num-1],
	input [width-1:0] dina [0:ram_num-1],
	input [width-1:0] dinb [0:ram_num-1],
	output reg [width-1:0] douta  [0:ram_num-1],
	output reg [width-1:0] doutb  [0:ram_num-1] 
);
   (* ram_style="{distributed}" *)
reg [width-1:0] ram3d [0:ram_num-1][0:2**address-1] ;
initial  begin
for(int x=0;x<ram_num;x++)begin
    for(int y=0;y<1024;y++)begin
        ram3d[x][y]=0;
    end
end
end
genvar i ;
integer j;
generate 

	for (i = 0 ; i < ram_num; i++) begin
		always@(posedge clk  ) begin
		    
			if (ena[i]) begin
					if(wea[i]) begin
						ram3d[i][addra[i]] <=dina[i] ;
					end
						douta[i]<= ram3d[i][addra[i]] ;
			end
		end
	end
endgenerate
//end of port A

generate 
	for (i = 0 ; i < ram_num; i++) begin
	always@(posedge clk ) begin
			if(enb[i]) begin
				if(web[i]) begin
					ram3d[i][addrb[i]] <=dinb[i] ;
				end
					doutb[i]<= ram3d[i][addrb[i]] ;
			end
		end
	end
endgenerate
//end of port B
endmodule


	
