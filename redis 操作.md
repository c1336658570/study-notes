# redis操作

## key操作命令

```bash
ping  #查看当前连接是否正常，正常返回PONG
clear  #清空终端
keys *  #查看当前库里所有的key
FLUSHALL  #清空所有库的内容
set name zhangsan  #添加一个key为name value为zhangsan的数据
get name  #查询key为name的value值
set name1 lisi
get name1
EXISTS name  #判断当前key是否存在
move name 1  #移除当前库1的key为name的数据
##测试设置key的过期时间
set name zhangsan
set name1 lisi
EXPIRE name 15  #设置key为name的数据过期时间为15秒 单位seconds
ttl name  #查看当前key为name的剩余生命周期时间
ttl name  #如若返回-2，证明key已过期
get name    #再次查询即为空
type name1 #查看name1的数据类型
```

## 五大数据类型

### string（字符串）

```bash
#####添加、查询、追加、获取长度、判断是否存在
set name zhangsan  #插入一个key为name值为zhangsan的数据
get name  #获取key为name的数据
get key1
keys *  #查看当前库的所有数据
EXISTS name  #判断key为name的数据存在不存在，存在返回1
EXISTS name1  #不存在返回0
APPEND name1 lisi #追加到key为name1的数据后拼接值为lisi，如果key存在类似于C++中字符串‘+’，不存在则新增一个，类似于Redis中的set name1 dingdada1 ，并且返回该数据的总长度
127.0.0.1:6379> APPEND name ,lisi  #追加，key存在的话，拼接‘+’，不存在，新增，返回总长度
(integer) 5
127.0.0.1:6379> get name
",lisi"
set key1 "hello world!"  #注意点：插入的数据中如果有空格的数据，请用“”双引号，否则会报错！
set key1 hello world!  #报错，因为在Redis中空格就是分隔符，相当于该参数已结束
set key1 hello,world!  #逗号是可以的
```

```bash
#####自增、自减
set num 0  #插入一个初始值为0的数据
get num
incr num  #指定key为‘num’的数据自增1，返回结果  相当于c++中 i++
get num  #一般用来做文章浏览量、点赞数、收藏数等功能
decr num  #指定key为num的数据自减1，返回结果  相当于c++中 i--
decr num  #可以一直减为负数~
decr num  #一般用来做文章取消点赞、取消收藏等功能
INCRBY num 10  #后面跟上by  指定key为‘num’的数据自增‘参数（10）’，返回结果
DECRBY num 3  #后面跟上by  指定key为‘num’的数据自减‘参数（3）’，返回结果
```

```bash
#####截取、替换
#截取
set key1 "hello world!"
GETRANGE key1 0 4  #截取字符串，相当于C++中的substr，下标从0开始，不会改变原有数据
#替换
set key2 "hello,,,world!"
127.0.0.1:6379> SETRANGE key2 5 888 #此语句跟C++中replace有点类似，下标也是从0开始，Redis中是从指定位置开始替换，替换的数据根据你所需替换的长度一致，返回值是替换后的长度
(integer) 14
127.0.0.1:6379> get key2
"hello888world!"
127.0.0.1:6379> SETRANGE key2 5 67  #该处只替换了两位
(integer) 14
127.0.0.1:6379> get key2
"hello678world!"
```

```bash
#####设置过期时间、不存在设置操作
#设置过期时间，跟EXPIRE的区别是前者设置已存在的key的过期时间，而setex是在创建的时候设置过期时间
127.0.0.1:6379> setex name1 15  zhangsan  #新建一个key为name1，zhangsan，过期时间为15秒的字符串数据
OK
127.0.0.1:6379> ttl name1  #查看key为name1的key的过期时间
(integer) 6
127.0.0.1:6379> ttl name1
(integer) 5
127.0.0.1:6379> ttl name1
(integer) 3
127.0.0.1:6379> ttl name1
(integer) 1
127.0.0.1:6379> ttl name1
(integer) 0
127.0.0.1:6379> ttl name1  #返回为-2时证明该key已过期，即不存在
(integer) -2
#不存在设置
127.0.0.1:6379> setnx name2 lisi  #如果key为name2不存在，新增数据，返回值1证明成功，若name2已经存在，新增失败，返回0
(integer) 1
127.0.0.1:6379> get name2
"dingdada2"
127.0.0.1:6379> keys *
1) "name2"
127.0.0.1:6379> setnx name2 "wangwu"  #如果key为name2的已存在，设置失败，返回值0，也就是说这个跟set的区别是：set会替换原有的值，而setnx不会，存在即不设置，确保了数据误操作~
(integer) 0
127.0.0.1:6379> get name2
lisi
```

```bash
#####mset、mget操作
127.0.0.1:6379> mset k1 v1 k2 v2 k3 v3  #插入多条数据
OK
127.0.0.1:6379> keys *  #查询所有数据
1) "k2"
2) "k3"
3) "k1"
127.0.0.1:6379> mget k1 k2 k3  #查询key为k1，k2，k3的数据
1) "v1"
2) "v2"
3) "v3"
127.0.0.1:6379> MSETNX k1 v1 k4 v4  #msetnx是一个原子性的操作，在一定程度上保证了事务！要么都成功，要么都失败！相当于if中的条件&&（与）
(integer) 0
127.0.0.1:6379> keys *
1) "k2"
2) "k3"
3) "k1"
127.0.0.1:6379> MSETNX k5 v5 k4 v4  #全部成功
(integer) 1
127.0.0.1:6379> keys *
1) "k2"
2) "k4"
3) "k3"
4) "k5"
5) "k1"
```

```bash
#####添加获取对象、getset操作
#这里其实本质上还是字符串，但是我们讲其key巧妙的设计了一下。
##mset student:1:name  student 相当于类名，1 相当于id，name 相当于属性
#如果所需数据全部这样设计，那么我们在java的业务代码中，就不需要关注太多的key
#只需要找到student类，下面哪个id，需要哪个属性即可，减少了代码的繁琐，在一定程度上可以理解为这个一个类的对象！
127.0.0.1:6379> mset student:1:name zhangsan student:1:age 22  #新增一个key为student:1:name，value为张三。。等数据
OK
127.0.0.1:6379> keys *  #查看所有的key
1) "student:1:age"
2) "student:1:name"
127.0.0.1:6379> mget student:1:age student:1:name  #获取数据
1) "22"
2) "zhangsan"

##getset操作
127.0.0.1:6379> getset name1 zhangsan  #先get再set，先获取key，如果没有，set值进去，返回的是get的值
(nil)
127.0.0.1:6379> get name1
"zhangsan"
127.0.0.1:6379> getset name1 lisi  ##先获取key，如果有，set（替换）最新的值进去，返回的是get的值
"zhangsan"
127.0.0.1:6379> get name1  #替换成功
"lisi"

#总结
#String是Redis中最常用的一种数据类型，也是Redis中最简单的一种数据类型。首先，表面上它是字符串，但其实他可以灵活的表示字符串、整数、浮点数3种值。Redis会自动的识别这3种值。
```

### list（列表）

```bash
#####lpush（左插入）、lrange（查询集合）、rpush（右插入）操作
#lpush
127.0.0.1:6379> lpush list v1  #新增一个集合
(integer) 1
127.0.0.1:6379> lpush list v2
(integer) 2
127.0.0.1:6379> lpush list v3
(integer) 3
#lrange
127.0.0.1:6379> LRANGE list 0 -1  #查询list的所有元素值
1) "v3"
2) "v2"
3) "v1"
127.0.0.1:6379> lpush list1 v1 v2 v3 v4 v5  #批量添加集合元素
(integer) 5
127.0.0.1:6379> LRANGE list1 0 -1
1) "v5"
2) "v4"
3) "v3"
4) "v2"
5) "v1"
###这里大家有没有注意到，先进去的会到后面，也就是我们的lpush的意思是左插入，l--left
#rpush
127.0.0.1:6379> LRANGE list 0 1  #指定查询列表中的元素，从下标零开始，1结束，两个元素
1) "v3"
2) "v2"
127.0.0.1:6379> LRANGE list 0 0  #指定查询列表中的唯一元素
1) "v3"
127.0.0.1:6379> rpush list rv0  #右插入，跟lpush相反，这里添加进去元素是在尾部！
(integer) 4
127.0.0.1:6379> lrange list 0 -1  #查看集合所有元素
1) "v3"
2) "v2"
3) "v1"
4) "rv0"
##联想：这里我们是不是可以做一个，保存的记录值（如：账号密码的记录），每次都使用lpush，老的数据永远在后面，我们每次获取 0 0 位置的元素，是不是相当于更新了数据操作，但是数据记录还在？想要查询记录即可获取集合所有元素！
```

```bash
#####lpop（左移除）、rpop（右移除）操作
#lpop
127.0.0.1:6379> LRANGE list 0 -1
1) "v5"
2) "v4"
3) "v3"
4) "v2"
5) "v1"
127.0.0.1:6379> lpop list  #从头部开始移除第一个元素
"v5"
##################
#rpop
127.0.0.1:6379> LRANGE list 0 -1
1) "v4"
2) "v3"
3) "v2"
4) "v1"
127.0.0.1:6379> rpop list
"v1"
127.0.0.1:6379> LRANGE list 0 -1  #从尾部开始移除第一个元素
1) "v4"
2) "v3"
3) "v2"
```

```bash
#####lindex（查询指定下标元素）、llen（获取集合长度） 操作
#lindex
127.0.0.1:6379> LRANGE list 0 -1
1) "v4"
2) "v3"
3) "v2"
127.0.0.1:6379> lindex list 1  #获取指定下标位置集合的元素，下标从0开始计数
"v3"
127.0.0.1:6379> lindex list 0  #相当于java中的indexof
"v4"
#llen
127.0.0.1:6379> llen list  #获取指定集合的元素长度，相当于java中的length或者size
(integer) 3
```

```bash
#####lrem（根据value移除指定的值）
127.0.0.1:6379> LRANGE list 0 -1
1) "v4"
2) "v3"
3) "v2"
127.0.0.1:6379> lrem list 1 v2  #移除集合list中的元素是v2的元素1个
(integer) 1
127.0.0.1:6379> LRANGE list 0 -1
1) "v4"
2) "v3"
127.0.0.1:6379> lrem list 0 v3 #移除集合list中的元素是v3的元素1个,这里的0和1效果是一致的
(integer) 1
127.0.0.1:6379> LRANGE list 0 -1
1) "v4"
127.0.0.1:6379> lpush list  v3 v2 v2 v2
(integer) 4
127.0.0.1:6379> LRANGE list 0 -1
1) "v2"
2) "v2"
3) "v2"
4) "v3"
5) "v4"
127.0.0.1:6379> lrem list 3 v2  #移除集合list中元素为v2 的‘3’个，这里的参数数量，如果实际中集合元素数量不达标，不会报错，全部移除后返回成功移除后的数量值
(integer) 3
127.0.0.1:6379> LRANGE list 0 -1
1) "v3"
2) "v4"
```

```bash
#####ltrim（截取元素）、rpoplpush（移除指定集合中最后一个元素到一个新的集合中）操作
#ltrim
127.0.0.1:6379> lpush list v1 v2 v3 v4
(integer) 4
127.0.0.1:6379> LRANGE list 0 -1
1) "v4"
2) "v3"
3) "v2"
4) "v1"
127.0.0.1:6379> ltrim list 1 2  #通过下标截取指定的长度，这个list已经被改变了，只剩下我们所指定截取后的元素
OK
127.0.0.1:6379> LRANGE list 0 -1
1) "v3"
2) "v2"
################
#rpoplpush
127.0.0.1:6379> lpush list v1 v2 v3 v4 v5
(integer) 5
127.0.0.1:6379> LRANGE list 0 -1
1) "v5"
2) "v4"
3) "v3"
4) "v2"
5) "v1"
127.0.0.1:6379> rpoplpush list newlist  #移除list集合中的最后一个元素到新的集合newlist中，返回值是移除的最后一个元素值
"v1"
127.0.0.1:6379> LRANGE list 0 -1
1) "v5"
2) "v4"
3) "v3"
4) "v2"
127.0.0.1:6379> LRANGE newlist 0 -1  #确实存在该newlist集合并且有刚刚移除的元素，证明成功
1) "v1"
```

```bash
#####lset（更新）、linsert操作
#lset
127.0.0.1:6379> LRANGE list 0 -1
1) "v5"
2) "v4"
3) "v3"
4) "v2"
127.0.0.1:6379> 
127.0.0.1:6379> lset list 1 newV5  #更新list集合中下标为‘1’的元素为‘newV5’
OK
127.0.0.1:6379> LRANGE list 0 -1  #查看证明更新成功
1) "v5"
2) "newV5"
3) "v3"
4) "v2"
##注意点：
127.0.0.1:6379> lset list1 0 vvvv  #如果指定的‘集合’不存在，报错
(error) ERR no such key
127.0.0.1:6379> lset list 8 vvv  #如果集合存在，但是指定的‘下标’不存在，报错
(error) ERR index out of range
########################
#linsert
127.0.0.1:6379> LRANGE list 0 -1
1) "v5"
2) "newV5"
3) "v3"
4) "v2"
127.0.0.1:6379> LINSERT list after v3 insertv3  #在集合中的‘v3’元素 ‘(after)之后’ 加上一个元素
(integer) 5
127.0.0.1:6379> LRANGE list 0 -1
1) "v5"
2) "newV5"
3) "v3"
4) "insertv3"
5) "v2"
127.0.0.1:6379> LINSERT list before v3 insertv3  #在集合中的‘v3’元素 ‘(before)之前’ 加上一个元素
(integer) 6
127.0.0.1:6379> LRANGE list 0 -1
1) "v5"
2) "newV5"
3) "insertv3"
4) "v3"
5) "insertv3"
6) "v2"
```

#### 小结：

- 实际上是一个链表，before Node after ， left，right 都可以插入值
- 如果key 不存在，创建新的链表
- 如果key存在，新增内容
- 如果移除了所有值，空链表，也代表不存在！
- 在两边插入或者改动值，效率最高！ 中间元素，相对来说效率会低一点~
- 消息排队！消息队列 （Lpush Rpop）， 栈（ Lpush Lpop）！
