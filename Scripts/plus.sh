#!/bin/bash

#让使用者输入一个数字，程式可以由 1+2+3... 一直累加到使用者输入的数字为止。

#while循环,
read -p "Enter you number:" num
n=1
s=0
while [ $n -le $num ]
do

	s=$(($s+$n))
	n=$(($n+1))
	
done
echo "累加结果为$s."