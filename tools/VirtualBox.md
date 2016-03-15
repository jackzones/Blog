#####如何复制一个虚拟机

建立好一个虚拟机后，想要复制成两个虚拟机，需要如下操作：

1. 复制vdi或者vmdx文件到一个新的目录。

2. 在VirtualBox安装目录下有一个VBoxManage工具，可以改变磁盘文件的uuid。

    `VBoxManage internalcommands sethduuid "path of vdi or vmdx"`

3. 使用VirtualBox新建虚拟机，选择磁盘的时候，选择已有的磁盘，然后选中第一步中拷贝的文件。

4. 建立好之后就可以正常使用了。


**如果没有第二步，而直接新建，或者直接将虚拟机的所有文件都拷贝一份的话，会出现错误，UUID已经存在了。**

