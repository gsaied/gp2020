file1 = open("in_fire2.txt","r")
file2= open("in_fire2_MOD.txt","w")
for i in range (2359296):
    if ((((i+1) % 576)== 0) and (i != 0)) :
        file2.write(file1.readline())
        file2.write('1111111111111111')
        file2.write('\n')
    else:
        file2.write(file1.readline())
        #file2.write('\n')
        
file1.close()
file2.close()
