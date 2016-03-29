#!/bin/bash

#个函数，利用shift计算所有参数乘积，假设参数均为整数( 特殊变量$# 表示包含参数的个数)

s=1
until [ $# -eq 0 ]; do
	s=$(($1*$s))
	shift
done

echo $s