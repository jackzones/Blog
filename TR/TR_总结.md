###TR_总结_RPCmethod

针对每一个 RPCmethod， 每次连接建立都会进行认证。

分为两种。

- 进行SSL/TLS认证，basic和digest认证其中一个即可。
- 没有进行SSL/TLS认证，需要digest认证。

####CPE发起的安全连接流程

发起者为：CPE

1. CPE向ACS发送Inform
2. ACS发送认证请求
3. CPE通过INform回复认证信息
4. ACS发送informresponse响应，
5. CPE发送一个空的HTTP请求给ACS
6. ACS回复一个空的HTTP
7. CPE发送空HTTP关闭会话

####ACS发起的安全连接流程

发起者：ACS

每次ACS notify CPE时发起

1. ACS发送连接请求
2. CPE请求认证
3. ACS发送认证信息
4. CPE向ACS发送Inform
5. ACS请求认证
6. CPE发送认证信息
7. ACS响应认证
8. CPE发送一个空的HTTP请求给ACS
9. ACS发送空的HTTP
10. CPE发送空HTTP关闭会话


**以下RPCmethod省略认证，直接建立session**

####GetParameterValues流程

ACS发送此请求，获取某个参数的值

1. 设备发送带有6 CONNECTION REQUEST的EventCode的Inform建立连接
2. ACS响应InformResponse
3. 设备发送空的HTTP请求
4. ACS发送GetParameterValues的RPC方法
5. CPE发送GetParameterValues响应，返回value的值
6. ACS发送空HTTP
7. CPE响应空HTTP关闭会话

####SetParameterValues流程

- Notification:`0`

1. 设备发送带有6 CONNECTION REQUEST的EventCode的Inform建立连接
2. ACS响应，InformResponse
3. 设备发送空的HTTP请求
4. ACS发起SetParameterValues的RPC方法，设置参数的值
5. CPE响应SetParameterValuesResponse，返回status，`0`代表修改成功，`1`代表修改未成功
6. ACS发送一个空报文的HTTP
7. CPE响应空HTTP关闭会话

- Notification:`1`or`2`

7. CPE发送4 VALUE CHANGE的EventCode的Inform，上报ACS该值
8. ACS响应InformResponse
9. CPE发送一个空的HTTP
10. ACS发送空HTTP
11. CPE响应空HTTP关闭会话


####GetParameterNames流程

1. 设备发送带有6 CONNECTION REQUEST的EventCode的Inform建立连接
2. ACS响应Inform
3. 设备发送空的HTTP请求
4. ACS发起GetParameterNames的RPC方法，获取参数名，带有NextLevel参数。
5. CPE响应GetParameterNamesResponse。返回Names的值
6. ACS发送空的HTTP
7. CPE响应空HTTP关闭会话

说明：
>NextLevel,`true`代表只获取下一个节点的参数名，`false`代表获取下个节点以及下个节点以下的所有参数名


####GetParameterAttributes流程

ACS发起确定参数的属性，Notification的值：`0`代表`Notification off` `1`代表`Passive notification` `2`代表`Active Notification`


1. 设备发送带有6 CONNECTION REQUEST的EventCode的Inform
2. ACS响应，InformResponse
3. 设备发送空的HTTP请求
4. ACS发起GetParameterAttributes的RPC方法，获取属性
5. CPE发送GetParameterAttributesResponse响应，并返回值
6. ACS发送空HTTP
7. CPE响应空HTTP关闭会话



####SetParameterAttribute流程

ACS发起,设置参数属性的值。

- Notification:`0`

1. 设备发送带有6 CONNECTION REQUEST的EventCode的Inform建立连接
2. ACS响应，InformResponse.
3. 设备发送空的HTTP请求
4. ACS发起SetParameterAttributes的RPC方法，设置参数的属性
5. CPE响应SetParameterAttributesResponse，并返回NotificationChange。`true`代表修改成功`false`未修改
6. ACS发送空HTTP
7. CPE响应空HTTP关闭会话

- Notification:`1`or`2`

7. CPE发送4 VALUE CHANGE的EventCode的Inform，上报ACS该值
8. ACS响应InformResponse
9. CPE发送一个空的HTTP
10. ACS发送空HTTP
11. CPE响应空HTTP关闭会话

####Download Device Configuration File流程

ACS发送让设备下载配置文件请求

1. 设备发送带有6 CONNECTION REQUEST的EventCode的Inform建立连接
2. ACS响应Inform
3. 设备发送空的HTTP请求
4. ACS请求Download方法，下载配置文件，有URL地址
5. 设备回复DownloadResponse，status，`0`代表成功，`1`代表失败
6. ACS发送空HTTP，结束此次会话。
7. 设备从file server下载文件
8. 下一个会话，设备发送带有TRANSFER COMPLETE的EventCode的Inform
9. ACS响应Inform 
10. CPE发送TransferComplete，FaultCode为`0`代表下载成功。
11. ACS响应TransferCompleteResponse。
12. 设备发送空的HTTP请求
13. ACS发送空的HTTP
14. CPE响应空HTTP关闭会话

####Upload Device Configuration File流程

ACS发送让设备上传设备配置文件请求

1. 设备发送带有6 CONNECTION REQUEST的EventCode的Inform建立连接
2. ACS响应Inform
3. 设备发送空的HTTP请求
4. ACS请求Upload方法，上传配置文件，URL地址表示目的地
5. 设备发送UploadResponse，status显示状态
6. ACS发送空的HTTP结束会话
7. 设备上传配置文件
8. 在下一个会话中，设备发送带有TRANSFER COMPLETE的EventCode的Inform
9. ACS响应Inform
10. 设备发送TransferComplete，FaultCode为`0`代表上传成功
11. ACS发送TransferCompleteResponse
12. 设备发送空的HTTP请求
13. ACS发送空HTTP
14. CPE响应空HTTP关闭会话

####Device Reboot流程

ACS发送请求设备重启

1. 设备发送带有6 CONNECTION REQUEST的EventCode的Inform建立连接
2. ACS响应InformResponse
3. 设备发送空的HTTP请求
4. ACS请求Reboot方法
5. 设备响应RebootResponse，并且重启
6. 启动之后，设备发送带有BOOT和M BOOT的EventCode的INform
7. ACS响应Inform
8. 设备发送空的HTTP请求
9. ACS发送空HTTP
10. CPE响应空HTTP关闭会话 

####Device Factory Reset流程

ACS请求设备恢复出厂设置

1. 设备发送带有6 CONNECTION REQUEST的EventCode的Inform建立连接
2. ACS响应InformResponse
3. 设备发送空的HTTP请求
4. ACS请求FactoryReset方法
5. 设备响应FactoryResetResponse
6. ACS发送空HTTP，结束会话 
6. 下一个会话，设备发送带有BOOTRAP的INform
7. ACS响应InformResoponse
8. 设备发送空的HTTP请求
9. ACS发送空HTTP
10. CPE响应空HTTP关闭会话

####IP pingDiagnostics流程 TR106

ACS测试设备的网络连接情况。

数据模型：`Device.LAN.IPPingDiagnostics.`

1. 设备发送带有6 CONNECTION REQUEST的EventCode的Inform建立连接
2. ACS响应InformResponse
3. 设备发送空的HTTP请求
4. ACS发送带有IP Ping Diagnostics的SetParameterValues的请求，host目标地址
5. 设备回复SetParameterValuesResponse，并且ping host
6. 设备发送带有 Diagnostics COMPLETE的EventCode的Inform
7. ACS响应InformResponse
8. 设备发送空的HTTP请求
9. ACS请求GetParameterValues of IP Ping Diagnostics
10. 设备回复GetParameterValuesResponse
11. ACS发送空HTTP
12. CPE响应空HTTP关闭会话

####TraceRouteDiagnostics流程 TR106

ACS测试设备的路由连接情况

数据模型：`Device.LAN.TraceRouteDiagnostics.`

1. 设备发送带有6 CONNECTION REQUEST的EventCode的Inform建立连接
2. ACS响应InformResponse
3. 设备发送空的HTTP请求
4. ACS发送带有Trace Route Diagnostics的SetParameterValues的请求，host目标地址
5. 设备回复SetParameterValuesResponse，并且trace route host
6. 设备发送带有 Diagnostics COMPLETE的EventCode的Inform
7. ACS响应InformResponse
8. 设备发送空的HTTP请求
9. ACS请求GetParameterValues of TraceRouteDiagnostics
10. 设备回复GetParameterValuesResponse
11. ACS发送空HTTP
12. CPE响应空HTTP关闭会话 

####DownloadDiagnostics流程 TR134

诊断文件下载

简略的数据模型： 

```xml
InternetGatewayDevice.DownloadDiagnostics.
DiagnosticsState
DownloadURL
```

1. 设备发送带有6 CONNECTION REQUEST的EventCode的Inform建立连接
2. ACS响应InformResponse
3. 设备发送空的HTTP请求
4. ACS发送带有Download Diagnostics的SetParameterValues的请求，DownURL为目标地址
5. 设备回复SetParameterValuesResponse，并且从界面下载。
6. 设备发送带有 Diagnostics COMPLETE的EventCode的Inform
7. ACS响应InformResponse
8. 设备发送空的HTTP请求
9. ACS请求GetParameterValues of DownloadDiagnostics
10. 设备回复GetParameterValuesResponse
11. ACS发送空HTTP
12. CPE响应空HTTP关闭会话

####UploadDiagnostics流程 TR134

诊断文件上传

简略的数据模型：

```xml
InternetGatewayDevice.UploadDiagnostics.
DiagnosticsState
UploadURL
```

1. 设备发送带有6 CONNECTION REQUEST的EventCode的Inform建立连接
2. ACS响应InformResponse
3. 设备发送空的HTTP请求
4. ACS发送带有Upload Diagnostics的SetParameterValues的请求，DownURL为目标地址
5. 设备回复SetParameterValuesResponse，并且上传。
6. 设备发送带有 Diagnostics COMPLETE的EventCode的Inform
7. ACS响应InformResponse
8. 设备发送空的HTTP请求
9. ACS请求GetParameterValues of UploadDiagnostics
10. 设备回复GetParameterValuesResponse
11. ACS发送空HTTP
12. CPE响应空HTTP关闭会话 



####ATMF5 Loopback
参数模型：

```xml
.WANATMF5LoopbackDiagnostics.

```



1. 设备发送带有6 CONNECTION REQUEST的EventCode的Inform建立连接
2. ACS响应InformResponse
3. 设备发送空的HTTP请求
4. ACS发送带有ATM F5 Loopback Diagnostics的SetParameterValues的请求
5. 设备回复SetParameterValuesResponse，并且测试。
5. 设备发送带有 Diagnostics COMPLETE的EventCode的Inform
6. ACS响应InformResponse
7. 设备发送空的HTTP请求
8. ACS请求GetParameterValues of ATM F5 Loopback Diagnostics
9. 设备回复GetParameterValuesResponse
10. ACS发送空HTTP
11. CPE响应空HTTP关闭会话



####DSL Loopback

```xml
InternetGatewayDevice.WANDevice.1.WANDSLDiagnostics.

```

1. 设备发送带有6 CONNECTION REQUEST的EventCode的Inform建立连接
2. ACS响应InformResponse
3. 设备发送空的HTTP请求
4. ACS发送带有DSL Loopback Diagnostics的SetParameterValues的请求
5. 设备回复SetParameterValuesResponse，并且测试 
5. 测试时，设备断开DSL连接，然后重新建立连接。
6. 设备发送带有Diagnostics COMPLETE的EventCode的Inform
7. ACS响应InformResponse
8. 设备发送空的HTTP请求
9. ACS请求GetParameterValues of DSL Loopback Diagnostics
10. 设备回复GetParameterValuesResponse
11. ACS发送空HTTP
12. CPE响应空HTTP关闭会话


















