find -name fire*.sv | grep -v fire4_squeeze | grep -v "." | while read line ; do basename=$(basename -a $line | awk -F "." '{print toupper($1)}');  for param in DSP_NO KERNEL_DIM W_IN CHIN WOUT ; do 
sed -i "s/"$param"/"$param"_"$basename"/g" $line ; done; done
