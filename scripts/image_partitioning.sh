#!/bin/bash
count=1
if [[ -n second_part.mem ]] ; then
	rm -rf second_part.mem
fi
if [[ -n third_part.mem ]] ; then
	rm -rf third_part.mem
fi
if [[ -n first_part.mem ]] ; then
	rm -rf first_part.mem
fi
cat img.mem | while read line ; do
	if [[ "$count" -le "131072" ]] ; then
		echo $line >> first_part.mem ;
	elif [[ "$count" -gt "131072" ]] && [[ "$count" -le "196608" ]] ; then
		echo $line >> second_part.mem
	elif [[ "$count"  -gt "196608" ]] ; then
	       echo $line >> third_part.mem	
	fi
	((count++)) ;
done
