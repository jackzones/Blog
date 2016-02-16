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
* 如果接受者在先前的item完成之前发现一个新的数据对象或者命令,接受者一定回复Alert 1225-"End of Data for chunked object not received".Alert应该包含来自原始命令的源和目标信息,使发送者定位失败的命令.

