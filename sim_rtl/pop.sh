#!/bin/bash
find -name *.sv | grep rom | while read line ; do
folder=$(awk -F "/" '{print $2 }') 
echo "$folder" 
sed -i "s/file/"$folder"\/file/g"  $line  ;
done
