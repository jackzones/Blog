####cut

cut是以**每一行为一个处理对象的**，这种机制和sed是一样的。通过**定位进行提取文本**.

有三种定位方式.

1. 字节(bytes),`-b`
2. 字符(characters),`-c`
3.  域(fields),`-f`

####-b,字节定位

```shell
xurenjiedeMacBook-Pro:Scripts jackzones$ who
_mbsetupuser console  Mar 25 00:41
jackzones    console  Mar 25 00:41
jackzones    ttys000  Mar 28 21:46
jackzones    ttys001  Mar 28 21:57

xurenjiedeMacBook-Pro:Scripts jackzones$ who|cut -b 3
b
c
c
c

xurenjiedeMacBook-Pro:Scripts jackzones$ who|cut -b 3-5,8
bsep
ckze
ckze
ckze
```

`-3`indicates `1-3`

`3-`indicates`3-end`

####-c,字符定位

```shell
[rocrocket@rocrocket programming]$ cat cut_ch.txt
星期一
星期二
星期三
星期四

[rocrocket@rocrocket programming]$ cut -c 3 cut_ch.txt
一
二
三
四
```

####-f,域定位

为什么会有“域”的提取呢，因为刚才提到的-b和-c只能在固定格式的文档中提取信息，而对于非固定格式的信息则束手无策。这时候“域”就派上用场了。

cut命令提供了这样的提取方式，具体的说就是设置“间隔符”，再设置“提取第几个域”，就OK了！

`设置间隔符 -d 提取第几个域 -f n`

#####间隔符为`:`

```shell
xurenjiedeMacBook-Pro:Scripts jackzones$ cat /etc/passwd|sed '1,10d'|head -n 5
nobody:*:-2:-2:Unprivileged User:/var/empty:/usr/bin/false
root:*:0:0:System Administrator:/var/root:/bin/sh
daemon:*:1:1:System Services:/var/root:/usr/bin/false
_uucp:*:4:4:Unix to Unix Copy Protocol:/var/spool/uucp:/usr/sbin/uucico
_taskgated:*:13:13:Task Gate Daemon:/var/empty:/usr/bin/false

#sed 删除1-10行(注释),之后取前五行,提取:分割的第一个区域.
xurenjiedeMacBook-Pro:Scripts jackzones$ cat /etc/passwd|sed '1,10d'|head -n 5|cut -d : -f 1
nobody
root
daemon
_uucp
_taskgated

xurenjiedeMacBook-Pro:Scripts jackzones$ cat /etc/passwd|sed '1,10d'|head -n 5|cut -d : -f 1,3-5
nobody:-2:-2:Unprivileged User
root:0:0:System Administrator
daemon:1:1:System Services
_uucp:4:4:Unix to Unix Copy Protocol
_taskgated:13:13:Task Gate Daemon
```

#####默认间隔符

制表符为默认间隔符,使用时省略`-d`即可

#####间隔符为`空格`

`-d ' '`





























