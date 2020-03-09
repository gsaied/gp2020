#!/bin/bash
for (( c = 1 ; c < 16 ; c= c+2 )) ; do
	paste file_fire3_squeeze_"$c".mem file_fire3_squeeze_"$(($c+1))".mem -d "" > new_file_fire3_squeeze_"$c".mem 
done
