# #!/bin/bash

# # 写一个脚本，利用循环和continue关键字，计算100以内能被3整除的数之和

s=0
for i in {1..100}
do
	div=$(($i%3))

	if [ $div -eq 0 ]; then
		s=$(($s+$i))
	elif [ $i -eq 100 ]; then
		echo "The addition is $s"
		break
	fi
done


# sum=0   
# for a in `seq 1 100`   
# do  
#       if [ `expr $a % 3` -ne 0 ]   
#       then   
#             continue  
#       fi   
#       echo $a   
#       sum=`expr $sum + $a`   
# done   
# echo "sum = $sum"  