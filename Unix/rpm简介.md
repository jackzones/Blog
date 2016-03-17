####RPM简介

*Red Hat Package Manager*

```
-e 卸载rpm包
-q 查询已安装软件信息
-i 安装rpm包
--replacepkgs 重新安装rpm包
--help
-h 显示安装进度
-a 显示出文件状态
-v 显示详细的处理信息

#####安装软件 i

`rpm -ivh dejagnu-1.4.2-10.noarch.rpm`

#####卸载软件 e

`rpm -ev mysql-libs-5.1.71-1.el6.x86_64`

mysql-libs-5.1.71-1.el6.x86_64

#####查询操作 q

-l 显示安装包中的所有文件都安装在那个目录下
-a 显示所有已安装的包

######查询mysql是否安装

`rpm -qa |grep mysql`

######查询openjade安装在系统的位置

`rpm -ql openjade-1.3.2-36.el6.x86_64`
