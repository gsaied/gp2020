k=1 ;
for (( count= 2 ; count <= 256 ; count=count+2)) ; do
	let "index=$(($(($count+1))/2))" ;
       	echo "\$readmemb(\"file_fire6_expand3_""$count"".mem"\"",rom_"$index",0,2**ADDR-1);" #>> rom_combined.sv
	#echo "rom_out["$count"]<= rom_"$k"[address][15:0];"
	((k++))
done

