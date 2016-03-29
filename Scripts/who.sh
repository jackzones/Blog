# 我们知道 /etc/passwd 里面以 : 来分隔，第一栏为帐号名称。请写一苹程式，
# 可以将 /etc/passwd 的第一栏取出，而且每一栏都以一行字串『The 1 account is "root" 』来显示，那个 1 表示行数

#命令替换,for循环,cut用法,按行读取
user_names=`cat /etc/passwd|sed '1,10d'|cut -d : -f 1`  #直接写会执行,这样不执行,此为[命令替换](shell_Char2.sh)
n=1
for user_name in $user_names
do
	echo The $n account is "${user_name}"
	n=$(($n+1))	
done 