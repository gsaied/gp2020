#!/bin/bash
file=1
count=1
find *.mem | grep extend | while read ss ; do
	rm -rf $ss ;
done
echo -e "enter remainder (law enta m3ak 768 filters masalan enter 512)" ; 
#actually msh remainder bs will do for now
read remainder
find *.mem | grep -v bias | grep -v weights | sort -n -t _ -k 4 | while read LINE ; do
	cat $LINE | while read line2 ; do
		if [[   "$count"  -gt  "$remainder"   ]] ; then
			echo $line2 >> extend_"$layer_name"_"$LINE" ; 
		fi
			((count++))
	done	
	((file++));
done
