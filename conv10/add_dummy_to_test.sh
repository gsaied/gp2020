#!/bin/bash
count=1 ; 
echo -e "Enter input filename (previous operation will be overwritten) \n"
read filename ; 
rm -rf new_"$filename".txt ; 
touch new_"$filename".txt ; 
echo -e "Enter window volume size, i.e 27 for conv1\n" ;
read vol ;
let "threshold=$vol+1"
cat $filename | while read line ; do 
        if [[ "$count" -eq "$threshold" ]] ; then
                echo "1111111111111111" >> new_"$filename".txt ; 
                echo "$line" >> new_"$filename".txt ; 
                count=1;
        else
                ((count++))
                echo "$line" >> new_"$filename".txt ; 
        fi
done

