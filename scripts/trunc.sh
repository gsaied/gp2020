#!/bin/bash
echo -e "3ayez el limit kam \n" ;
read limit ;
find *.mem | grep temp | while read temp ; do
	rm -rf $temp ; 
done
count=1
nfile=1
find *.mem | while read file ; do
	cat $file | while read line ; do
		if [[ "$count" -gt "$limit" ]] ; then
			count=1;
			((nfile++))
			break;
		fi		
		echo $line >>temp_"$file" ; 
		((count++)) 
	done	
done
