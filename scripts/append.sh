#!/bin/bash
count=1
find *.mem | grep fire9 | sort -n -t _ -k 3 | while read file ; do 
	cat $file | while read line ; do
		echo $line >> file_fire8_squeeze_"$count".mem ;
	done
	((count++))
done

