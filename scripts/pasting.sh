#!/bin/bash
for (( count= 1 ; count <= 256 ; count=count+2 )) ; do
	#paste file_fire6_expand3_"$count".mem file_fire6_expand3_"$(($count+1))".mem -d "" > file_fire6_expand3_"$count"_"$(($count+1))".mem
	cat file_fire6_expand3_"$count".mem >> file_fire6_expand3_"$(($count+1))".mem
done
