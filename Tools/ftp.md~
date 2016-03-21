####ftp安装

######查看系统是否安装ftp服务：

`rpm -qa |grep vsftp`

######安装命令：

`yum -y install vsftpd`

######编辑vsftpd配置文件：

`vi /etc/vsftpd/vsftpd.conf`


####ftp创建用户

######添加用户test，默认访问地址为`var/ftp/pub/`：

`useradd test`

`passwd test` 然后输入密码

######修改test访问地址为根目录/：


`usermod -d / test`


######创建用户并设置访问地址：

`useradd -d / test`

`passwd test`

####ftp访问

- 用filezilla访问
- 浏览器直接输入`ftp://ip`访问
