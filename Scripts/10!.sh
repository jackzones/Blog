#!/bin/bash

#利用循环计算10的阶乘

s=1
#for i in `seq 1 10`
for i in {1..10} #这两种表示法都可以
do
	s=$(($i*$s))

done
echo "10!=$s"