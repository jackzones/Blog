###Agent使用方法
####Agent位置
* 通过OMU跳入测试工具板中,30.64中`/root/nelson_agent_oma`
* 本机`/home/amy/Documents/simulator/OMA_Agent_AB`

####配置agent之前的准备:
* 系统中导入order
* 查找系统sbi的虚拟ip

*方法:进入系统,`vi /OMS_OMA/conf/general.properties`*,查看南向监听ip


####配置agent:
* 进入`neslon_agent_oma/`目录.
* 修改日志配置,`vi conf/log.conf`.
	- level:`ERROR`代表性能测试时的多个设备,`DEBUG`表示单个设备的功能测试.*
	- mode:`File`表示存入文件,`BOTH`表示屏幕和文件都显示.

* 配置agent参数,修改param.xml文件,`vi conf/param.xml`.
	- cfgSBC:`value='1'`
	- Addr(南向监听地址,搜索omadm):`sbi的虚拟ip`如`http://58.251.159.213:8000/comserver/omadm`
	- PollingInterval(心跳间隔)
	- PollingSupported(是否开启心跳):`value='1'`开启
	- PollingAttempts(发送次数):`value='-1'`无限次
	- DEVID(设备ID):order中的<devid>
	- FwV(设备版本)
	- DevType(设备类型)
	- LastProvisioningTime(上次预配置时间)
	- Register下的Status:`value='1'`只做一次预配置`value='0'`inform每次都预配置
	- AAuthName:order中的<devid>
	- AAuthData:`value='./conf/0_AAuthData_1562603763'`*确保存在次文件,否则新建,value='touch conf/0_AAuthData_1562603763*
	- AAuthSecrect:order中的<password>

####运行agent:

`./oma -d conf/`

####order文件举例
```
<?xml  version="1.0"  encoding="utf-8"?>
<order  orderKey="add111000000000211">  
    <ADD_HSUB>  
        <devid>111000000000211</devid>    
        <impi>111000000000211@www.test.com</impi>    
        <password>1111qqqq</password>    
        <impu>sip:110000000000211@www.test.com</impu>    
        <hnDomain>www.test.com</hnDomain>    
	<vipUser>1</vipUser>
        <Subscriber>  
            <subid>111000000000211</subid>    
            <domain>/nelson/</domain>    
            <subscriberName>huawei</subscriberName>    
            <email>huawei@huawei.com</email>    
            <phoneNumber>111111</phoneNumber>    
            <address>111111</address>    
            <description>description</description>  
        </Subscriber>  
    </ADD_HSUB>  
</order>
```