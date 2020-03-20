#!/bin/bash
#basename=$(awk -F "." '{print $1}' "$1")
basename=$(basename -a $1 | awk -F "." '{print toupper($1)}') 
echo $basename
#for param in DSP_NO KERNEL_DIM W_IN CHIN WOUT
#do
#	sed -i "s/"$param"/"$param"_FIRE4_SQUEEZE/g" $file ;
#done
