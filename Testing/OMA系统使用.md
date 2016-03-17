###OMA系统使用
#####查看mapping
*order中的字段相对应的URI*
`/OneMS_OMA/conf/data/omanbimapping/nbiParametersMapping.xml`

#####Provision方法

- 在order中添加字段
- 在脚本中添加字段

#####DD添加

######查看设备类型的mapping

设备版本`FwV`:`V1.1.4.1-01010000`,不考虑最后两位，为`010100`

`cat /OneMS_OMA/conf/hcsMapping.xml`


`010100`mapping`PC-Window-RCS`,所以DD类型上传此类型。

#####不修改数据

`cp oma_sbc_replace oma`在conf下
