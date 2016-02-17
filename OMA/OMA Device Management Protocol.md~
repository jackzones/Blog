##翻译

###Multiple Messages In Package
对于封装边界,server处于以下的一种状态中:

1. server发送了一个完整的包.在这种状态下,server等待来自client发送的状态.由于状态和结果可能很大,如Get命令的结果,在结束回复之前,client可能发送多个消息给server.

2. server接受到一个client发送的完整回复包.在这种状态下,server可能给client发送新的命令.

3. server发送一个或者多个消息,此消息为一个包的一部分,但是还没有发送当前包的最终消息.当server正在发送一个大的对象,并且当这个对象的最后一段发送了,这个包才会停止时,这种状态才有效.

###Requirements
* 如果SyncML包以多个SyncML消息发送是,此包最后一个消息一定要包含Final元素.其他属于此包的消息一定不能包含Final元素.
* 直到server发送Final元素关闭之前的包,client才能发送Final元素关闭当前的包.(not)
* 多消息SyncML包的接受者一定能激发多消息.这是回复发送者一个Alert 1222命令来实现的.如果发送一个SyncML命令回复之前的消息,例如Results,Alert 1222命令可以省略.
* server发送Final标志,client还没有发送Final标识,server一定要回复client一下"Next Message":
+ "Next Message"回复包含Alert code 1222(或者1223停止),状态为SyncHdr,没有其他命令和标志.
+ server如果可能的话一定要在每个消息里发送Final标识.这点在发送一个大的对象时或者发送"Next Message"时,是不可能的.

###Large Object Handling

* 此协议提供一种方法使超过尺寸的对象能同时在一个消息中传输.实现方式为,把对象分割成能适应消息的段,用<MoreData/>元素来标识让接受者知道此条数据是不完整的还有其他段消息发送.
* Client应该支持Large Objects,servers一定要支持Large Objects
* 接收到有<MoreData/>元素的对象,接受者一定要回复status"213-Chunked item accepted and buffered",如果没有其他命令发送,用Alert 1222激发下一条消息,如section6 定义的机制.
* 接收到最后一段对象,接受者以之前的数据段修复数据对象,并应用激发命令.一定给发送者回复适当的status.段对象的命令一定暗中视为原子的.例如,当所有的段成功的接受和修复,接受者才能提交对象.
* 单独消息的数据对象一定没有<MoreData/>元素.切分成多条消息的数据段对象一定有<MoreData/>元素,除了最后一段除外.
* 新的数据对象一定不能被发送者添加任何消息,除非先前的数据对象已经完成.如果一个数据对象被分割成多条消息,段消息一定以连续的消息发送.新的DM命令(Add,Replace,Delete,Copy.Atomic,or Sequence)或者新的Items一定填充在数据段之间.
* Meta和Item消息应该添加到接下来的每个包含相同数据段消息中.
* 支持Large Object handling的client一定是DevDetail/LrgObj标识=ture.MaxObjSize被发送者接收可能包含Meta信息白哦是消息发送到其他地方.MaxObjSize信息一定被接受者认为,发送的热河单个对象不能大于这个值.如果MaxObjSize没有发送,接受者可以发送任何大小的对象给发送者.
* MaxObjSize保持在整个DM回话的影响,除非接下来的消息中有新值.
* 如果item被分割成多条消息,Meta信息中的<Size>元素一定用来提示接受者,数据对象的全部的大小.<Size>元素一定只在第一段条目中.
* 接受最后一段,接受者一定验证重建的段是否和对象的发送者发送的Meta信息中的<Size>一致.如果不一致,error status 424- "Size mismatch",接受者一定不提交命令.发送者可能尝试重新发送全部的数据对象.
* 如果接受者在先前的item完成之前发现一个新的数据对象或者命令,接受者一定回复Alert 1225-"End of Data for chunked object not received".Alert应该包含来自原始命令的源和目标信息,使发送者定位失败的命令.*Status不适合这,由于不涉及command Id.* 接受者一定不要提交命令,发送者可能尝试重新传输整个数据对象.

###OMA DM Protocol packages
*open mobile alliance device management protocol packages*

OMA DM协议由两部分组成:建立阶段(认证和设备信息交互)和管理阶段.管理阶段可以认为是server的多次期望.Management会话以Package 0开始.

* 管理阶段由大量的协议交互组成.server发向client的包的内容决定会话是否继续.如果server在包中发送需要client回复(status or results)的管理操作,在管理阶段,client发送一系列包含client对管理操作的回复给server.client回复的包开始一个新的协议交互.server可以发送一个新的管理操作,因此新建了一个新的协议交互.
* 在管理阶段,当server发送到client的包不包含管理操作或者challenge,client将创建一个只包含Status for SyncHdr的回复.这种情况下,整个回复包一定不发送并且协议终止.server一定给所有的client包发送回复包.
* 包处理过程需要很长时间.因此OMA DM协议在包中没有定义超时.
* 如果没有被Sequence或者Atomic命令封装,client和server可能自由的选择管理命令的执行顺序.然而,当执行顺序按照上层管理命令,命令必须按照他们发送的顺序执行.
* client一定不能发送除了Replace命令包含DevInfo,Results 和 Alert命令之外的命令给server.

###Session Abort

* client和server可以随时终止会话.因为会话终止可以server关闭,client断电,用户交互等.这种情况下,最好在终止的部分发送SESSION ABORT **ALERT**.建议消息包含Status和Results命令,在终止操作之前的终止部分.
* 如果接收到Session Abort之后,发送一个回复,这个回复会被忽略.
* Alert 1223用来标志不可预期的终止.
* client接收Alert 1223 不应该回复.

###Package 0: Management Initiation Alert from server to client
很多设备不能持续监听来自server的连接,其他设备也不想打开一个端口,出于安全考虑.然而,大部分设备能接受未经许可的消息,又是我们叫做"notifications".

管理服务器可以使用"nitifications"让client建立连接和server的连接.oma协议定义了几个通知的纽带.定义的纽带和通知内容可以在[DMNOTI]手册中找到.

###Package 1: Initialization from client to server

client发送激发包的目的是:
* 向server发送设备信息,client一定在管理会话的第一条消息中发送设备信息.
* 根据section9的规则,server识别client.
* 通知server管理会话有谁激发,server(在Package 0 中发送trigger)还是client(如最终用户选择一个菜单选项)
* 通知任意client的server产生alert,如Generic Alert或者Client Event[REPPRO]

client到server产生的包(Package 1)的具体要求如下:

1. SyncHdr元素的要求

* VerDTD元素的值为1.2
* VERProto元素的值为DM/1.2
* SessionID包含会话的ID.如果client回复alert code SERVER-INITIATED MGMT (1200)通知,SessionID和通知中的一致.否则client要产生不重复的SessionID.同样的SessionID要应用与整个对话中.
* MsgID识别server到client的会话消息
* Target识别目标server
* Source识别源设备
* Cred在client到server的认证消息中.

2. Alert在SyncBody中,不论是client还是server激发的管理会话.

* CmdID是必须的
* Data元素承载管理会话的类型SERVER-INITIATED MGMT (1200)或者CLIENT-INITIATED MGMT (1201).

3. 用SyncBody里的Replace命令发送设备信息.Replace命令的要求如下:

* CmdID必须有
* 设备信息树的每个节点创立一个Item元素.可能的节点定义在[DMSTDOBJ]
* Item中的Source元素要有节点URI的值.
* Data元素承载设备信息数据.

4. client可能包含client-generated Alarts 如Client Event [REPPRO] or Generic Alert.

Final元素用于SyncBody中,表示包中的最后一个消息.

###Package 2: Initialization from server to client

server发送的激发包的目的是:
* server识别client,根据Section9
* server可以发送用户交互命令
* 发送管理数据和命令
* 如果接受到了来自client的Client Initiated Alerts,则发送其状态

Package2可以关闭管理会话用只包含<Final>元素(任何管理命令,用户交互命令,client认证将持续会话).同时在特殊情况下,server可以发送Session Abort Alert (1223)强制关闭会话.

package2的细节要求:

1. SyncHdr里的元素的要求:

* VerDTD值为1.2
* VerProt值为DM/1.2
* SessioID包括表示管理会话的ID
* MsgID识别属于server到client的管理会话的消息
* Target识别目标设备
* Source识别源设备

2. 接收到client发来的SyncHdr和Alerts,sever在SyncBody里回复Status.

3. 任何管理操作包括在SyncML文档中(如Alert,Sequence,Replace)的user interaction,被放置到SyncBody中.

* CmdID是必须的
* 如果URI需要进一步确定源数据集,Source是必须的
* 如果URI需要进一步确定目标数据集,Target是必须的
* 除非命令不需要Data元素,否则Item里的Data元素用来包括数据自身.
* 操作或者Item里的Meta元素必须使用,当Type或者Format不是默认的值[META].

4. Final元素用于SyncBody中,表示包中的最后一个消息.

###Package 3: Client response sent to server





















































































































