#!/bin/bash

# 7个脚本，执行后，打印一行提示“Please input a number:"，要求用户输入数值，然

# 后打印出该数值，

# 然后再次要求用户输入数值。直到用户输入

# "end"停止

input="end"
num=0
while [ $num != $input ]; do
	read -p "Please input a number:" num
	echo $num
done
 