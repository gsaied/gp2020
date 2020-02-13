#!/bin/bash
count=0;
count2=0
WIDTH=32
echo -e "Enter number of filters\n" ;
read DSP_NO
echo -e "Enter layer name \n" ;
read layer_name
if [  "$1"  == "unix" ] || [[ -z $1 ]] ; then
	dos2unix bias.mem ;
elif [ "$1" == "windows"  ]; then
	unix2dos bias.mem ;
else
	echo -e "Unknown Platform, specify either unix or windows\n" ;
fi
if [  -n biasing_"$layer_name".sv ] ; then
	rm -rf biasing_"$layer_name".sv
fi
echo "
module biasing_"$layer_name" (
	output ["$WIDTH"-1:0] bias_mem [0:"$DSP_NO"-1]
);
">> biasing_"$layer_name".sv
cat bias.mem | while read LINE; do
	echo "reg ["$WIDTH"-1:0] bias_reg_"$count" = 32'b$LINE;" >> biasing_"$layer_name".sv
	((count++));
done
cat bias.mem | while read LINE ; do
	echo "assign bias_mem["$count2"] = bias_reg_"$count2";" >> biasing_"$layer_name".sv
	((count2++));
done
echo "endmodule" >> biasing_"$layer_name".sv
