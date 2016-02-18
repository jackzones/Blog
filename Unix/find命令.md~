###find命令
####Find命令的一般形式为:
`find pathname -options [-print -exec -ok]`
* pathname find所查找的目录路径,`.`当前目录,`/`系统根目录
* `-print` find命令将匹配的文件输出到标准输出.
* `-exec` find命令对匹配的文件执行该参数说给出的shell命令.
	- 形式为`'command' {} \;`
	- {}和\;之间有空格
* `-ok` 类似exec,只不过执行前会给出提示.

####-option

* `-name` 按照文件名查找文件
* `-mtime -n +n` 按照文件的更改时间来查找文件,
	- `-n`表示文件更改时间距现在n天以内
	- `+n`表示文件更改时间距现在那天以前
* `-type` 查找某一类型的文件
	- `d`目录
	- `f`普通文件
#####-name
1. 在当前目录及子目录中查找文件名以两个小写字母开头,跟着是两个数字开头,最后是txt类型的文件.

`find . -name "[a-z][a-z][0-9][0-9]*.txt" -print`
2. 想要在/etc目录中查找文件名以host开头的文件,可以用:

`find /etc -name "host*" -print`

#####按照更改时间,mtime

1. 在系统根目录下查找更改时间在5日以内的文件

`find / -mtime -5 -print`

2. 为了在/var/adm目录下查找更改时间在3日以前的文件

`find /var/adm -mtime +3 -print`

#####-type

1. 在/etc目录下查找所有的目录

`find /etc -type d -print`

2. 在当前目录下查找除目录以外的所有类型的文件

`find . ! -type d -print`


####xargs执行shell命令

1. 用grep命令在当前目录下的所有普通文件中搜索DBO这个词

`find . -name "*" -type f -print | xargs grep "DBO"` 

2. 查找系统中的每一个普通文件,然后使用xargs命令来测试它们分别属于哪类文件

`find / -type f -print | xargs file`







































