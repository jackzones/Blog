


# 先查看一下 $/root/test/logical这个名称是否存在；
#  2.) 若不存在，则建立一个档案，使用 touch 来建立，建立完成后离开；
#  3.) 如果存在的话，判断该名称是否为档案，若为档案则将之删除后建立一个档案，档名为logical，之后离开；
#  4.) 如果存在的话，而且该名称为目录，则移除此目录！


path=~/Document/logical
if [ ! -e $path ]; then
	touch 	$path
	echo "logical was created in a minutes"
elif [ -e $path ] && [ -f $path ]; then
	rm -rf $path
	mkdir $path
	echo "file has been removed and a new directory was created."
elif [ -e $path ] && [ -d $path ]; then
	rm -rf $path
	echo "the logical directory has been removed"
else
	echo "Does here have anything?"  
fi