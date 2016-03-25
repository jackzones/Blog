<!-- MarkdownTOC -->

- [hell语法](#hell语法)
    - [和/](#和)
    - [un the shell scipt](#un-the-shell-scipt)
    - [ariables](#ariables)
        - [eadonly variables](#eadonly-variables)
        - [elete the variables](#elete-the-variables)
    - [tring](#tring)
        - [he lengce of the string](#he-lengce-of-the-string)
    - [rray](#rray)
        - [etch the value](#etch-the-value)
        - [he length of the array](#he-length-of-the-array)
        - [he length of the element](#he-length-of-the-element)
    - [算符](#算符)
        - [术运算符](#术运算符)
        - [系运算符](#系运算符)
        - [尔运算符](#尔运算符)
        - [辑运算符](#辑运算符)
        - [符串运算符](#符串运算符)
        - [件测试运算符](#件测试运算符)
    - [程控制](#程控制)
        - [f](#f)
        - [f else](#f-else)
        - [f else-if else](#f-else-if-else)
        - [or](#or)
        - [hile](#hile)
        - [ntil](#ntil)
        - [ase](#ase)
    - [hell function](#hell-function)
        - [unction argument](#unction-argument)
    - [/O,Redirect](#oredirect)
        - [edirect](#edirect)
        - [dev/null](#devnull)
    - [ntroduce another file](#ntroduce-another-file)

<!-- /MarkdownTOC -->

##Shell语法

###.和/
.代表当前文件夹
/代表系统根目录

###Run the shell scipt 
`test.sh`

```shell
#!/bin/bash
echo 'Hello World!'
```

- as executable program

```shell
chmod +x ./test.sh #the executable authority
./test.sh           #execute the script
```

`./`means looking for the scrpt in the current directory.

- as interpreter's argument

```shell
/bin/sh test.sh
/bin/php test.sh 
```

It's not neccessary for the `#!/bin/bash` in the first line.

- own 

`sh +x test.sh`

###Variables

- Define the variables

`your_name='nelson'`

**There is no spaces around the =**
- Use the variables

`echo ${your_name}`


####Readonly variables
Once define the readonly variables,the value can't be changed.

```shell
#!/bin/bash
your_name='nelson'
readonly your_name 
```

####Delete the variables

`unset variable_name` The readonly variables can not be deleted.

###String

字符串可以用单引号，也可以用双引号，也可以不用引号.

单引号字符串的限制：

- 单引号里的任何字符都会原样输出，单引号字符串中的变量是无效的；
- 单引号字串中不能出现单引号（对单引号使用转义符后也不行）

双引号的优点：

- 双引号里可以有变量
- 双引号里可以出现转义字符

####the lengce of the string

```shell
string="abcd"
echo ${#string}
```

###Array

`array_name=(value0 value1 value2 value3 value4)`

####fetch the value

`${array_name[num]}`
`num=@`fetch all the array's value 

####the length of the array

`length=${#array_name[@]}`or`length=${#array_name[*]}`

####the length of the element 

`length=${#array_name[n]}`

###运算符

原生bash不支持简单的数学运算，但是可以通过其他命令来实现，例如 awk 和 expr，expr 最常用。

expr 是一款表达式计算工具，使用它能完成表达式的求值操作。

```shell
val=`expr 2 + 2`
echo "${val}"
```

两点注意：

- 表达式和运算符之间要有空格，例如 2+2 是不对的，必须写成 2 + 2，这与我们熟悉的大多数编程语言不一样。
- 完整的表达式要被 ` ` 包含，注意这个字符不是常用的单引号，在 Esc 键下边。

####算术运算符
加，减，乘，除，取余，赋值，==，!= 

- expr 

注意：条件表达式要放在方括号之间，并且要有空格，例如: [$a==$b] 是错误的，必须写成 [ $a == $b ]

| operator |            specification            |         example         |
|----------|-------------------------------------|-------------------------|
| ==       | 用于比较两个数字，相同则返回 true   | [ $a == $b ] 返回 false |
| !=       | 用于比较两个数字，不相同则返回 true | [ $a != $b ] 返回 true  |

- $(())

    `r=$(( 4 + 5 ))` 

- $[]

    `r=$[ 4 + 5 ]`

####关系运算符 
关系运算符只支持数字，不支持字符串，除非字符串的值是数字。假定变量 a 为 10，变量 b 为 20：
`great than,less than,equel to `

| operator |          specification           |          example          |
|----------|----------------------------------|---------------------------|
| -eq      | 检查两个数是否相等，相等返回true | [ $a -eq $b ] 返回：false |
| -ne      | 不相等返回true                   | [ $a -ne $b ] 返回true    |
| -gt      | 左大于右，返回true               | [ $a -gt $b ] false       |
| -lt      | 左小于右，返回ture               | [ $a -lt $b ] true        |
| -ge      | 大于等于，true                   | [ $a -ge $b ] fale        |
| -le      | 小于等于，true                   | [ $a -le $b ] true        |

####布尔运算符

下表列出了常用的布尔运算符，假定变量 a 为 10，变量 b 为 20：

| operator | specification |                example                |
|----------|---------------|---------------------------------------|
| !        | 非            | [ !false ] true                       |
| -o       | 或            | [ $a -lt 20 -o $b -gt 100 ] 返回 true |
| -a       | 与            | [ $a -lt 20 -a $b -gt 100 ] 返回 false                                      |

####逻辑运算符

以下介绍 Shell 的逻辑运算符，假定变量 a 为 10，变量 b 为 20

| operator | specification |                  example                  |
|----------|---------------|-------------------------------------------|
| &&       | 逻辑and       | [[ $a -lt 100 && $b -gt 100 ]] 返回 false | 

||               逻辑or       [[ $a -lt 100 || $b -gt 100 ]] 返回 true

####字符串运算符
下表列出了常用的字符串运算符，假定变量 a 为 "abc"，变量 b 为 "efg"：

| operator |            specification             |      example      |
|----------|--------------------------------------|-------------------|
| =        | 检测两边是否相等                     | [ $a = $b ] false |
| !=       | 不相等返回                           | [ $a != $b ] true |
| -z       | 检查字符串是否为0，为零true          | [ -z $a ] false   |
| -n       | 检查字符串是否为0，不为零true        | [ -n $b ]true     |
| str      | 检查字符串是否为空，不为空，返回true | [ $b ] true                   |

####文件测试运算符

文件测试运算符用于检测 Unix 文件的各种属性.[属性检测描述如下](http://www.runoob.com/linux/linux-shell-basic-operators.html)

###流程控制
shell的流程控制不可为空.
####if

```shell
if condition;then
    command1
    command2
    command3
fi
```

写成一行,适用于终端:

`if condition; then command; fi` for example:
`if [ $(ps -ef | grep -c "ssh") -gt 1 ]; then echo "true"; fi`

####if else

```shell
if confition; then
    command1
    command2
else
    command3
    command4
fi
```

####if else-if else

```shell
if condition1; then
    command1
else-if condition2
    command2
else 
    commandN
fi
```


####for 

```shell
for var in iterm1 iterm2 iterm3 ...itermN
do
    command1
    command2
done
```

`for var in iterm1 iterm2 itermN; do command1; do command2; done;`

####while

```shell
while condition
do 
    command
done
```


while循环可用于读取键盘信息

```shell
echo "What's your favorite movies:"
while read movie
do 
    echo "My favorite movie is $movie !"
done
```
####until

直到condition为真,循环停止:
```shell
until condition
do
    command
done
```

####case

```shell
echo '输入 1 到 4 之间的数字:'
echo '你输入的数字为:'
read aNum
case $aNum in
    1)  echo '你选择了 1'
    ;;
    2)  echo '你选择了 2'
    ;;
    3)  echo '你选择了 3'
    ;;
    4)  echo '你选择了 4'
    ;;
    *)  echo '你没有输入 1 到 4 之间的数字'
    ;;
esac
```

###shell function

```shell
func_name(){
    command
}
```
函数返回值在调用该函数后通过`$?`来获得。

注意：所有函数在使用前必须定义。这意味着必须将函数放在脚本开始部分，直至shell解释器首次发现它时，才可以使用。调用函数仅使用其函数名即可.

####function argument

`${n}`represents the n-th argument.

###I/O,Redirect

| commands | specification |
`n >& m`     `将输出文件 m 和 n 合并`
`n <& m`     `将输入文件 m 和 n 合并`

####Redirect

```shell
标准输入文件(stdin): stdin的文件描述符为0，Unix程序默认从stdin读取数据。
标准输出文件(stdout): stdout的文件描述符为1，Unix程序默认向stdout输出数据。
标准错误文件(stderr): stderr的文件描述符为2，Unix程序会向stderr流中写入错误信息。
```
默认情况下，`command > file`将`stdout`重定向到`file`，`command < file`将`stdin` 重定向到`file`

- 如果希望`stderr`重定向到`file`，可以这样写:
    `command 2 > file`
- 如果希望将`stdout`和`stderr`合并后重定向到`file`，可以这样写:
    `command > file 2>&1`
- `command`命令将`stdin`重定向到`file1`，将`stdout`重定向到`file2`。
    `command < file1 > file2`

####/dev/null

如果希望执行某个命令，但又不希望在屏幕上显示输出结果，那么可以将输出重定向到/dev/null：
`command > /dev/null `

如果希望屏蔽 stdout 和 stderr，可以这样写：
`command > /dev/null 2>&1`

###introduce another file

`. filename`or `source filename`

for exampel:

`. ./test.sh` or `source ./test.sh`







































