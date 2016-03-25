## 背景知识
### Unix历史
*Power cloaked in simplicity*

###软件工具的原则
* 一次做好一件事
* 处理文本行,不要处理二进制数据
* 使用正则表达式(BRE,Basic Regular Expression)
* 默认使用标准输入/输出
* 避免喋喋不休
* 输出格式与可接受的输入格式一致
* 让工具去做困难的部分
* 构建特定工具前,请想一想

###Differences Between Scripting language and Compiled language
*scripting language is interpreted*
* Scripting language 用于更高层,处理文件方面
* Scripting language 效率低于compiled language

###Shell的定义
`shell`最简单的定义就是----`命令解释器`( Command Interpreter)

- 将使用者的命令翻译给`kernel`来处理；
- 同时，将`kernel`的处理结果翻译给使用者。

### Shell开发周期
1. 直接在命令行(command line)上测试
2. 放入独立的脚本
3. 直接使用改脚本

###shell 格式
* command
* option
* argument

`ls -l files.md`
* command = ls
* option = l(long)
* argument = files.md

###输出
* echo --for the string not the function
* printf 
###重定向与管道
```
 > 改变标准输出
 < 改变标准输入
 >> 输出附加到文件
```

###tr命令
**tr命令可以对来自标准输入的字符进行替换、压缩和删除。它可以将一组字符变成另一组字符，经常用来编写优美的单行命令，作用很强大.**

[tr命令详解](http://man.linuxde.net/tr)







 
