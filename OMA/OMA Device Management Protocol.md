##翻译

###Multiple Messages In Package

用多个message发送一个SyncML package，当package太大，不能在一个message中发送。

对于封装边界,server处于以下的一种状态中:

1. server发送了一个完整的包.在这种状态下,server等待client响应的状态.由于此状态和结果可能很大,如Get命令的结果,在结束响应之前,client可能给server发送多个消息.

2. server接受到一个client发送的完整回复包.在这种状态下,server可能给client发送新的命令.

3. server发送一个或者多个消息,此消息为一个包的一部分,但是还没有发送当前包的结束消息.例如，当server正在发送一个大的对象,并且当这个对象的最后一段发送了,这个包才会停止时。

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
package的内容包括:
* server发送到client的action结果
* user interaction命令的结果
* client新产生的alert,如会话过程中产生的Generic Alert or Client Event [REPPRO].

**package3由client发送,如果package2包含需要client回复的management commands**

package3的细节要求:

1. SyncHdr里的元素要求:
	* VerDTD值为1.2
	* VerProto值为Dm/1.2
	* SessionID表明管理会话的ID
	* MsgID识别管理会话的从server到client的消息
	* Target元素识别目标设备
	* Source元素识别源设备
2. 回复来自设备SyncHdr和Alert命令,server用SyncBody里的Status
3. 回复package2server发送的管理操作,用Syncbody中的status
4. SyncBody里的Result响应,前一个包server发送的Get操作,集体要求如下:
	+ Result一定包含描述Data内容的Type和Format的Meta元素,除非Type和Format有默认值[META].
	+ Resutl里的Item包含Source元素,用来确定源URI
5. client可以发送client generated alerts,如Client Event [REPPRO] or Generic Alert.

SyncBody里的Final元素标识包里的最后一个消息.

###Package 4: Further server management operations
package4用来关闭management session.如果server在Package4中发送任何需要client回复的操作,协议将会在Package3中重建一个新的协议交互.如果在前一个包中接收到任何来自client的alerts,server发送Client Initiated Alerts的结果.

1. SyncHdr元素里的元素的要求:

	* VerDTD值为1.2
	* VerProt值为DM/1.2
	* SessioID包括表示管理会话的ID
	* MsgID识别属于server到client的管理会话的消息
	* Target识别目标设备
	* Source识别源设备

2. Status响应设备管理服务器(device management server)发送的SyncBody中的SyncHdr.如果client发送了任何Alerts ,server一定要发送这些Alerts的Status.

3. 任何管理操作包括在SyncML文档中(如Alert,Sequence,Replace)的user interaction,被放置到SyncBody中.

	* CmdID是必须的
	* 如果URI需要进一步确定源数据集,Source是必须的
	* 如果URI需要进一步确定目标数据集,Target是必须的
	* 除非命令不需要Data元素,否则Item里的Data元素用来包括数据自身.
	* 操作或者Item里的Meta元素必须使用,当Type或者Format不是默认的值[META].

Final元素用在SyncBody中,表示包中最后的消息.Package4可以关闭management session,通过只包含<Final>元素.同时server可以发送Session Abort Alert (1223)强制关闭会话.
###Generic Alert

协议为与Management Object有关系的client产生的Alerts定义了Generic Alert消息.
Management Object关联,Source和LocURI一定识别Management Object的地址.
client或者server激发Management Alert之后,client需要发送一条Generic Alert消息给server.
**Generic Alert消息只能从client发送到server.**server接收到Generic Alert之后,server要响应如何处理所有Items的status.

client可能发送多个有Generic Alert的Alert消息或者具有一个或多个Generic Alert的Alert消息里的多个Items捆绑一起.
generic alert消息里的Data在协议里没有具体说明,协议确定client如何通知server Type和Format是什么.server一定要支持Generic Alert Format但不是多有alert data的Types.   


如果server不支持的Type和Format,server要响应415'"Unsupported media type or Format"   
如果设备不支持Large Object,Alert消息一定不能超过message size.   
此手册只是说明协议的一方面,一些注册的Generic Alert对于不同的Generric Alert Data可能还有更多的要求.    
server接受到Alert成功,server一定要响应200 OK 或者202 Accepted for processing,其他情况下,server响应:401,407,412,415,500.

###Generic Alert Message

以下是Generic Alert message的基本样式:
```xml
<Alert>
<CmdID>2</CmdID>
<Data>1226</Data>
<!-- Generic Alert -->
<Correlator>abc123</Correlator>
<Item>
<Source><LocURI>./SyncML/Sample</LocURI></Source>
<Meta>
<Type xmlns="syncml:metinf">
Reversed-Domain-Name: org.domain.samplealert
</Type>
<Format xmlns="syncml:metinf">xml</Format>
<Mark xmlns="syncml:metinf">critical</Mark>
<!-- Optional -->
</Meta>
<Data>
<!-- Client Alert Data Goes Here -->
</Data>
</Item>
</Alert>
```

* CmdID
	所有的命令必须以同样的方式指定.
* Data
	Generic Alert的值必须是1226
* Item
	这是必须的参数.对于每个类型的Generic Alert,如果设备在一个Alert消息中发送他们,Item必须重复发送.
* Source里的LocURI
	这是可选参数.如果Alert由Management Object产生或者Management Object的定义指定了这个参数,就必须包括此参数
* Meta
	Meta元素必须指定Alert Data中的Type和Format.
* Type
	Type元素一定要指定,并且明确内容消息的媒体类型.元素类型的内容消息一定是URN.如果是MIME-type,就必须用"content-type"作为命名空间标识符并且内容应该是注册的MIMEcontent-type.如果是reverse domain name则命名空间标识符"Reversed-Domain-Name"必须定义.只有这两个命名空间标识符允许.
* Format
	必须指定,必须包含接下来的Data元素的Format的SyncML标识.
* Mark
	可选.定义message的重要程度.可以接受的:fatal,critical,minor,warning,informational,harmless,indeterminate.默认级别informational,省略mark.
* Data(Item里的)
	必须指定.必须用Meta标签里的Format和Type
* Correlator
	可选,alertexec命令异步响应时使用.

###Authentication

这节定义了认证规则。   

server和client都会检测对方是否在最初的请求中没有证书，或者认证太薄弱。   
如果server在Package2中没有发送证书或发送无效的证书，没有认证，没有命令，client一定不能不能通过只响应Status认证server。如果server在Pkg2中查client的口令，client一定重新发送pkg1，必须重新发送带有server认证请求的Alert和DevInfo。   

较好的server到client的认证类型要在DM Account management object中的<X>/AAuthPref 参数。    

请求的响应代码是401或407，请求需要认证。此情况下，响应的Status命令一定包含Chal元素，Chal包含对请求资源的认证许可。发起人嘘嘘重复发送带有Cred元素的请求。如果请求已经包含Cred元素，401响应把表示，证书的认证被拒绝。   

212响应（Authentication accepted），不需要在验证了。

###Authorization 授权 认证

Cred元素要包含在请求中，在接收到401和407响应时，如果请求重复。    

应用层的认证通过用SyncHdr里的Cred和SyncHdr的Status命令。

###Authorization Examples

####Basic authentication with a challenge

此例中，SyncBody没有显示，但是实际是有的。

* client尝试没有任何认证与server建立连接（pkd1）。!Cred
* （pkg2）server查看client应用层的认证。407
* client一定重新发送有认证的pkg1。Cred
* server接受认证，会话认证（pkg2）212


Pkg1 from Client
```xml
<SyncML xmlns='SYNCML:SYNCML1.2'>
<SyncHdr>
<VerDTD>1.2</VerDTD>
<VerProto>DM/1.2</VerProto>
<SessionID>1</SessionID>
<MsgID>1</MsgID>
<Target><LocURI>http://www.syncml.org/mgmt-server</LocURI></Target>
<Source><LocURI>IMEI:493005100592800</LocURI></Source>
</SyncHdr>
<SyncBody>
...
</SyncBody>
</SyncML>
```
###MD5 digest access authentication with a challenge

* client尝试没有任何认证与server建立连接（pkd1）。!Cred
* （pkg2）server查看client应用层的认证。407
* client一定重新发送有MD5认证的pkg1,Type为syncml:auth-md5。Cred
* server接受认证，会话认证（pkg2）212。同时server给client发送下一个nonce，client在下一个sesstion中必须使用。

###User interaction commands

协议使用user interactin来notify和obtain confirmation。   

Alerts只能server to client。
	- 如果client不支持，响应406 'Optional Feature Not Supported'。
	- 如果client发送，server忽略。

Pkg2中发送，Pkg3中响应Status。如果Pkg4还在继续，Pkg4可以只包含user interaction Alerts。    

Alert包含2或者更多的元素。client一定要保存Item元素的顺序。client在消息中也要按照相同的顺序处理。    

User interaction，除了display，应该有取消的选项。如果user决定取消操作，那么management message进程就停止。Status代码响应215（Not executed）。处理万user的响应，server要继续其他management操作。<br/>

如果UI让user取消，status 214 Operation cancelled应该返回。

####display

Alert有两个Item：
* 第一个Item，section10中说明
* 第二个Item， 只有一个Data，为显示给用户的文本内容

```xml
<Alert>
<CmdID>2</CmdID>
<Data>1100</Data>
<Item><Data>MINDT=10</Data></Item>
<Item>
<Data>Management in progress</Data>
</Item>
</Alert>
```

####Confirmation

确认是二元选择：用户同意或者不同意。CONFIRM_OR_REJECT 新的Alert代码。当client接收到这个Alert，显示Alert内容，让user选择‘Yes’or‘no’。

	* 如果回答是‘yes’，响应status是200: “Yes”，包处理继续。
	* 如果回答是“No”，响应status是304: “No”，包处理停止
	* 如果UI允许user取消，响应214: “Operation cancelled”

如果响应是“No”，包处理根据confirmation Alert的placement而改变。

	- 如果confirmation Alert在Atomic里，Atomic失败，执行命令回滚
	- 如果confirmation Alert在Aequence里，sequence里在confirmation Alert之后的命令忽略。
	- 如果confirmation Alert不再以上两种，如在SyncBody中，user 的回复不影响包进程。

命令忽略，响应status 215 Not Exected

Alert包含两个Items：

	- 第一个Item包含的可选参数定义在section10中
	- 第二个Item只有一个Data元素，显示用户信息。

####User input
当Alert发送，client显示用户在文本框中输入的内容。the text string 然后发回给server在Status中。server指示client执行用户交互，通过发送TEXT INPUT的Alert。Alert包含至少两个Items：

- 第一个Item包含定义在section10.3中的可选参数。
- diergeItem只有一个Data元素，包含需要向user展示的文本。

例如：
```xml
<Alert>
<CmdID>2</CmdID>
<Data>1102</Data>
<Item></Item>
<Item>
<Data>Type in the name of the service you would like to
configure</Data>
</Item>
</Alert>
```

下面的Status消息从client到server的下一个消息发回。

```xml
<Status>
<MsgRef>1</MsgRef>
<CmdRef>2</CmdRef>
<Cmd>Alert</Cmd>
<Data>200</Data> <!-- Successful, user typed in a text -->
<Item>
<Data>CNN</Data> <!-- User input -->
</Item>
</Status>
```
####User choice

当Alert发送，user看到一系列可能的选择。Alert body要半酣一下Item：

- 第一个Item包含可选参数。定义于section10中。
- 第二个Item之后一个Data元素，包含内容的标题。
- 第三个Item包含一个Data，描述一个可能的选择。这些Item从1开始，Item一定要他们发送的顺序排序。Item应该以他们发送的顺序发送给user。

用户的选择在Status中返回选择的item在Item中返回。这个Item的Data元素包含item的索引。Alert允许用户选择多个item。这种情况下，item在多个items中发回。

一个可能的应用是一个表，每个Data可以成列显示列表。
用户可以选择一系列item，用户点击“ok”按钮选择的表item的Id在Status消息中发回。

####Progress notification（object download）

用户应该能跟踪长管理行为的进展，如文件和对象的下载。

根据协议，Item可以被Size标记，表明对象的大小。当设备接受到Item里的size，会在用户界面显示notification的进展，如果设备认为给定size的item需要长时间下载。

notification的进展根据信息长度的比例发配。如果信息的大小不是server发送的，client不能显示按比例发配的进程，所以认为client下载的这个信息太大了。

反病毒数据文件，有Size Meta的下载：
```xml
<Add>
<CmdID>2</CmdID>
<Meta>
<Format xmlns="syncml:metinf">b64</Format>
<Type xmlns="syncml:metinf">
application/antivirus-inc.virusdef
</Type>
</Meta>
<Item>
<Meta>
<!-- Size of the data item to download -->
<Size xmlns='syncml:metinf'>37214</Size>
</Meta>
<Target><LocURI>./antivirus_data</LocURI></Target>
<Data>
<!-- Base64-coded antivirus file -->
</Data>
</Item>
</Add>
```
####User interaction options

Alert的可选User interaction parameters在第一个Item中。
可选参数在Data元素中，以文本串形式。如果User interaction Alert没有可选参数，第一个Item为空。可选参数字符串遵从URL代码格式，具体[RFC2396]。

client必须跳过不能处理的有错误的消息。
下面定义了可选参数：

- MINDT（Minimum Display Time）
	这个参数显示用户交互应该给用户显示的最小时间。要确保notification message可读。

- MAXDT （Maximum Display Time）
	参数表示等待用户执行user interaction的时长。如果用户在这个时间内没有执行，这个action应该取消，timeout Stutas或者moren回复包发回给server。
MAXDT参数一定是正整数。

- DR（Default Response）

DR表示用户交互控制界面的其实状态。除了设置用户交互控制界面的其实状态，DR对user interaction control widget没有其他影响。不同的user interaction type如下：

	- 如果ui（users interaction）是Notification，可选参数省略。
	- 如果ui是确认信息，0代表拒绝，并且高亮，1代表接受，并且高亮。高亮ui表示默认ui将会选择的元素（例如按下回车）。如果client没有高领，这个参数也许被忽略了。
	- 如果ui是user input，DR

- MAXLEN(Maximum length of user input)

MAXLEN为正值，定义用户输入的最大字符数。如果定义的输入最大值超过了客户端的容量，client会忽略这个参数。

- IT（Input Type）

IT定义了在user interaction weidget中可以输入的字符种类。

	- IT=A :Alphanumeric input，client允许输入所有文字和数字的字符。默认
	- IT=N :Numeric input， client允许输入所有数字字符，小数和符号字符。
	- IT=D :Date input， client允许所有数字字符。输入以如下形式“DDMMYYYY”
	- IT=T :Time input， 允许所有数字字符，用户输入以“hhmmss”形式发送给server
	- IT=P :Phone number input,client允许所有数字字符，'+','p','w','s'.'+'必须在第一位，如果是电话号码的话。
	- IT=I :IP address input,client所有数字。如下形式'xxx.yyy.zzz.www'

Example:

```xml
<!-- Numeric text input -->
<Item><Data>IT=N</Data></Item>
```

Status message delivered to server as response

```xml
<Status>
<MsgRef>1</MsgRef>
<CmdRef>2</CmdRef>
<Cmd>Alert</Cmd>
<Data>200</Data> <!-- Successful, entered a number -->
<Item>
<Data>-1.23</Data>
</Item>
</Status>
```

- ET(Echo Type)

ET代表文本输入如何通过user interaction widget输出。允许的之如下：

	- ET=T :Text input. clietnt允许用户查看用户通过user interaction widget 输入的字符。默认模式。
	- ET=P :Password input.client要隐藏用户通过user interaction widget输入的字符。即用星号代替字符。
Example:
```
<!-- Numeric text input -->
<Item><Data>ET=T</Data></Item>
```

####Protocol examples

这节介绍几个协议脚本（scenarios）

- Package 1: Initialization from client to server

```xml
<SyncML xmlns='SYNCML:SYNCML1.2'>
<SyncHdr>
<VerDTD>1.2</VerDTD>
<VerProto>DM/1.2</VerProto>
<SessionID>1</SessionID>
<MsgID>1</MsgID>
<Target>
<LocURI>http://www.syncml.org/mgmt-server</LocURI>
</Target>
<Source>
<LocURI>IMEI:493005100592800</LocURI>
</Source>
<Cred> <!-- Client credentials are mandatory if the transport layer is
not providing authentication.-->
<Meta>
<Type xmlns="syncml:metinf">syncml:auth-basic</Type>
<Format xmlns='syncml:metinf'>b64</Format>
</Meta>
<Data>
<!-- base64 formatting of userid:password -->
</Data>
</Cred>
<Meta> <!-- Maximum message size for the client -->
<MaxMsgSize xmlns="syncml:metinf">5000</MaxMsgSize>
</Meta>
</SyncHdr>
<SyncBody>
<Alert>
<CmdID>1</CmdID>
<Data>1200</Data> <!-- Server-initiated session -->
</Alert>
<Replace>
<CmdID>3</CmdID>
<Item>
<Source><LocURI>./DevInfo/DevId</LocURI></Source>
<Meta>
<Format xmlns='syncml:metinf'>chr</Format>
<Type xmlns='syncml:metinf'>text/plain</Type>
</Meta>
<Data>IMEI:493005100592800</Data>
</Item>
<Item>
<Source><LocURI>./DevInfo/Man</LocURI></Source>
<Meta>
<Format xmlns='syncml:metinf'>chr</Format>
<Type xmlns='syncml:metinf'>text/plain</Type>
</Meta>
<Data>Device Factory, Inc.</Data>
</Item>
<Item>
<Source><LocURI>./DevInfo/Mod</LocURI></Source>
<Meta>
<Format xmlns='syncml:metinf'>chr</Format>
<Type xmlns='syncml:metinf'>text/plain</Type>
</Meta>
<Data>SmartPhone2000</Data>
</Item>
<Item>
<Source><LocURI>./DevInfo/DmV</LocURI></Source>
<Meta>
<Format xmlns='syncml:metinf'>chr</Format>
<Type xmlns='syncml:metinf'>text/plain</Type>
</Meta>
<Data>1.0.0.1</Data>
</Item>
<Item>
<Source><LocURI>./DevInfo/Lang</LocURI></Source>
<Meta>
<Format xmlns='syncml:metinf'>chr</Format>
<Type xmlns='syncml:metinf'>text/plain</Type>
</Meta>
<Data>en-US</Data>
</Item>
</Replace>
<Final/>
</SyncBody>
</SyncML>
```

- Package 2: Initialization from server to client

```xml
<SyncML xmlns='SYNCML:SYNCML1.2'>
<SyncHdr>
<VerDTD>1.2</VerDTD>
<VerProto>DM/1.2</VerProto>
<SessionID>1</SessionID>
<MsgID>1</MsgID>
<Target>
<LocURI>IMEI:493005100592800</LocURI>
</Target>
<Source>
<LocURI>http://www.syncml.org/mgmt-server</LocURI>
</Source>
<Cred> <!-- Server credentials -->
<Meta>
<Type xmlns="syncml:metinf">syncml:auth-basic</Type>
<Format xmlns='syncml:metinf'>b64</Format>
</Meta>
<SyncML xmlns='SYNCML:SYNCML1.2'>
<SyncHdr>
<VerDTD>1.2</VerDTD>
<VerProto>DM/1.2</VerProto>
<SessionID>1</SessionID>
<MsgID>1</MsgID>
<Target>
<LocURI>IMEI:493005100592800</LocURI>
</Target>
<Source>
<LocURI>http://www.syncml.org/mgmt-server</LocURI>
</Source>
<Cred> <!-- Server credentials -->
<Meta>
<Type xmlns="syncml:metinf">syncml:auth-basic</Type>
<Format xmlns='syncml:metinf'>b64</Format>
</Meta>
</Item>
</Replace>
</Sequence>
<Final/>
</SyncBody>
</SyncML>
```





































































































