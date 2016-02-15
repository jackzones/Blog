##Mysql命令
###进入数据库
`mysql -uroot -p onems`
输入密码
###显示所有表
`show tables;`
###显示表结构
`desc users;`
*users是其中的一个表*
###查看表内容
`select <字段1，字段2，...> from < 表名 > where < 表达式 >`
*此为完整程式*
`select * from users;`
*此命令查看所有users表的字段和属性*
###查看表中的前两行
`select * from users limit 0,2;`
###表中插入数据
`insert into <表名> ( <字段名 1>[,..<字段名 n > ]) values ( 值 1 ), ( 值 n );`
*此为完整程式*
`insert into users values(‘tom’,’tom@yahoo.com’),(‘paul’,’paul@yahoo.com’);` 
*users中只有name和email*
###修改表中的数据
`update users set name='Mary' where id=1;`
###删除表中的数据
`delete from users where id=1;`
###导出数据库
`mysqldump -uroot -p onems > file.sql`
###导入数据库
`mysql -uroot -p onems < file.sql`
