# Linux下命令

## 基本命令

/etc/soduers    超级用户权限

whoami  当前用户

su 切换到超级用户 且目录切换到超级用户目录

su - 切换到超级用户，目录不变

超级用户下输入 passwd修改超级用户密码

passwd  默认修改当前用户密码

sudo passwd username   修改其他用户密码

sudo adduser 新用户名

sudo deluser 用户名

sudo addgroup 新组名

sudo delgroup 组名

echo "hello" > test.c  将hello写入test.c

cat test.c  显示test.c的内容

pwd 工作目录

rm 删除文件

rm -r 删除目录

ls -d  filename  打印文件名本身，不打印内部的东西

ls -i 输出i节点号

cd - 回到当前所处路径的上一次所处路径

stat filename  查看文件stat结构体（文件属性）

1.touch filename 创建新文件filename

2.touch 修改文件时间

   touch 已经存在的文件（filename）   	 修改三个时间信息

mkdir  dir 创建目录dir（默认创建一个）

mkdir -p dir1/dir2/dir3 递归创建 dir1/dir2/dir3

rmdir dir 删除空目录dir

rm -r dir1  递归删除dir1

rm filename 删除普通文件

rm -f filename 强制删除文件

rm -f filename*

*通配符

cp oldfilename newfilename  拷贝oldfilename到当前路径，新未见名字为newfilename。

cp oldfilename dir/ 拷贝oldfilename到当前目录下的dir目录中，拷贝后的名字还为oldfilename

cp oldfilename .. 拷贝oldfilename到上级目录中，拷贝后的名字还为oldfilename

cp -r dir .. 递归拷贝当前目录下的dir到上级目录。（时间等信息会改变）

cp -a dir .. -a表示全部拷贝  拷贝当前目录下的dir到上级目录。（-a拷贝时间等信息不变）

cp -rf  递归强制

mv 重命名和剪切

alias 'mycmd=ls -a -l'  对ls -a -l 重命名为mycmd

cat filename显示文件内容，从前往后打印

cat -n 显示文件内容和行号

cat后面不加任何东西会从键盘输入，并将键盘输入输出

cat < filename 输入重定向（将文件打开，作为输入的数据源，再将其输出到终端）

echo "hello world" > filename   将hello world覆盖重定向到filename

echo "hello world"1 > filename   将hello world覆盖重定向到filename

echo "hello world" >> filename将hello world追加重定向到filename

只将标准输出重定向到指定文件

tac filename显示文本内容，和从后往前打印

more filename 显示文件内容（分屏显示）

less filename 显示文件内容

head filename 默认显示文件前10行

head -5 filename 显示前5行

tail filename 显示后10行

tail -5 filename 显示后5行

date 显示系统时间

date +%Y:%m:%d显示时间，2022:03:20，年月日

date +%Y:%m:%d-%H/%M，2022:03:20-11/32，年月日时分

date +%Y:%m:%d-%H/%M/%S，2022:03:20-11/32，年月日时分秒

date +%s，1647747227，显示时间戳（1970.1.1到现在经过的秒数）

date +%Y:%m:%d-%H/%M/%S -d @1234

1970:01:01-08/20/34，距离1970.1.1，1234秒后的时间

cal 或 cal -1查看本月日历信息

cal -3 查看本月的前一个月和下一个月的日历信息

cal 2022 查看2022年日历信息

top 查看计算机启动的进程

shutdown -h 立即关机

shutdown -r 在将系统服务停掉后重启

shutdown -t sec 设置秒数关机

exit/ctrl+c 退出超级用户

file filename 查看文件类型信息

readelf -Sh my_ls | grep "debug"   显示elf的信息（调试信息）

ps aux 显示进程信息

which ls  显示ls的路径

ln -s file file.s 创建软链接

ln -s ./file file2.s 创建软链接

当上述两种方式的软链接移动后将不可用，因为是相对路径创建的

ln -s /home/cccccc/file file3.s  使用绝对路径创建的软链接可以随意移动

ln file file.h 创建硬链接-

sudo chown root filename  修改所属用户

sudo chown nobody:nogroup filename 修改所属用户和用户组

sudo chgrp root filename  修改所属组

find ./ -type 'l'  在当前目录及当前目录的子目录下找所有的软链接

find ./ -name '*.c' 在当前目录和子目录下找.c结尾的文件

find ./ -maxdepth 1 -name '*.c' 只在当前目录下找.c结尾的文件

find ./ -size +20M -size -50M 在当前目录找到大于20M小于50M的文件

find ./ -ctime 1  一天以内修改的文件

-atime、mtime、ctime以天为单位amin、mmin、cmin以分钟为单位

find /usr/ -name "\*tmp*" -exec ls -l {} \;找包含tmp的然后交给ls -l执行（不会分片映射）文件名有空格也可以正确输出

find ./ -maxdepth 1 -type f | xargs ls -l    与上述命令效果相同（当find搜索结果集执行某一指令。当结果集较大时可以分片映射）

使用xargs文件名不能包含空格，因为他分片映射，文件名分隔符号为空格

find ./ -maxdepth 1 -type f -print0 | xargs -print0 ls -l  解决上述问题（将各个项之间的空格拆分依据改为0）

find ./ -maxdepth 1 -type f -exec rm -r {} \;  不会询问直接删除

find ./ -maxdepth 1 -type f -ok rm -r {} \;会询问

grep：以文件内容查找

$grep -r 'copy' ~ -n 找家目录中包含'copy'的，-n显示行号

ps aux 显示进程

ps aux | grep "kernel" 显示所有和内核相关进程
ps ajx
ps -Lf 进程id --> 线程号。LWP -->cpu执行的最小单位


cat & 后台运行

jobs 显示当前shell下正在运行哪些作业

fg和bg 前后台切换

sh -c ""  执行任意命令
sh -c "ls -l"


kill [-signal | -s signal] pid ... 向进程发送信号

top 文字版任务管理器

alias pg='ps aux | grep'  给ps aux | grep起了个别名叫pg

wc 使用

1、命令基本格式为：

wc [选项] 文件 ...

2、选项参数主要有：

-c 统计字节数。

-l 统计行数。

-m 统计字符数。这个标志不能与 -c 标志一起使用。

-w 统计字数。一个字被定义为由空白、跳格或换行字符分隔的字符串。

-L 打印最长行的长度。

-help 显示帮助信息并退出

--version 显示版本信息并退出

od -tcx testmap  查看有文件空洞的文家内容
ctrl + z 让进程后台运行
bg 查看后台运行的进程
fg 恢复后台运行的进程

制作静态库

gcc -c add.c -o add.o

gcc -c sub.c -o sub.o

ar rcs libmymath.a add.o sub.o

使用静态库 gcc test.c libmymath.a -o test -I ./mymath.h

制作动态库（生成与位置无关的代码 -fPIC）

gcc -c add.c -o add.o -fPIC

gcc -c sub.c -o sub.o -fPIC

使用gcc -shared 制作动态库

gcc -shared -o libmymath.so add.o sub.o

编译可执行程序时指定所使用的动态库。-l：指定库名  L：指定库路径

 -I：指定头文件路径

gcc test.c -o test -l libmymath.so -L ./

运行可执行程序会出错

原因：

​		链接器： 工作于链接阶段，工作时需要-l和-L

​		动态链接器：工作于程序运行阶段，需要提供动态库所在目录位置。

解决方法1：通过环境变量：export LD_LIBRARY_PATH=动态库路径

运行程序成功，上述环境变量导入只是临时的，重启终端失效

解决方法2：永久生效：写入终端配置文件

​	vim ~/.bashrc

​	写入 export LD_LIBRARY_PATH=动态库路径 保存

解决方法3：将自己的动态库拷贝到标准C动态库

​		cp libmymath.so /lib

解决方法4：sudo vim /etc/ld.so.conf

​					将自己的库的绝对路径拷贝进去

​					执行sudo ldconfig -v 让自己的路径生效

ldd a.out  查看可执行文件动态链接库的信息

strace ./a.out 查看程序在执行时的系统调用

wc

-l , --lines : 显示行数；

-w , --words : 显示字数；

-m , --chars : 显示字符数；

-c , --bytes : 显示字节数；

-L , --max-line-length : 显示最长行的长度；

od -tcx filename  查看文件的16进制表示形式

od -tcd filename 查看文件的10进制表示形式

ulimit -a 查看限制

time ./a.out 查看程序执行时间
实际时间 = 用户时间 + 内核时间 + 等待时间。 --》优化瓶颈I/O

netstat -apn | grep client 查看客户端状态

netstat -apn | grep 8000 查看端口号为8000的状态

ehco $? 查看返回值

-std=c++0x 参数打开对c++11的支持

man inet_addr 
man inet_pton 
man 7 ip  

ctags：查看函数调用关系...。

生成一个tags文件，组织目录内所有.c函数调用关系

生成方法：项目目录下ctags ./* -R 或者 在任意一个文件内ctrl+p

命令：ctrl+] 光标放置于函数上，跳转至函数定义位置

ctrl+t 返回此前跳转位置

ctrl+o 在屏幕左边列出文件列表 再次ctrl+o 关闭

F4 在屏幕右边列出函数列表 再次F4关闭



unicode 大学 查看大学的unicode编码

telent 127.0.0.1 9999 连接本地服务器

## 重定向：

find /home -name test.c 在home中找名为test.c的文件，将其路径和错误输出到终端

find /home -name test.c > msg.txt  中找名为test.c的文件，将其路径重定向到msg.txt，将其错误输出到终端

find /home -name test.c  2>&1 > msg.txt  中找名为test.c的文件，将其路径重定向到msg.txt，将其错误输出到终端

find /home -name test.c test.c > msg.txt 2>&1 在home中找名为test.c的文件，将其路径和错误输出到msg.txt

find /home -name test.c test.c 2> /dev/null 将标准错误丢弃，标准输出输出到终端（向dev/null中写东西会被直接丢弃）

默认情况下重定向的时标准输出

find /home -name test.c test.c > /dev/null 2>&1 将标准输出和标准错误都丢弃



## 管道：用来传输数据的

command1 | command2 | command3

将command1输出的结果输出到第二条命令（第一条命令的输出作为第二条命令的输入），第二条命令的结果输出到第三条命令（第二条命令的输出作为第三条命令的输入）

last 以时间为单位，历史上登录服务器用户的个数

last | head -5 只输出last的前五行到终端（将last输出的数据交给head，然后head进行加工，只输出前五行）

last | grep cccccc  只显示cccccc历史上登录的信息

grep：按行为单位进行信心过滤

last | grep cccccc | wc -l  cccccc历史上一共登录了多少次

wc：统计行数，-l将行的总数统计出来

last | grep cccccc | awk '{print $1, $4, $5, $6, $7}'

将1 4 5 6 7列的数据输出

/etc/services 里面包含一些协议默认的端口号



## 环境变量

echo $PATH 输出PATH环境变量

export PATH=$PATH:/home/cccccc/ls 导入PATH环境变量

env/printenv查看所有环境变量

unset 撤销环境变量

## 用户

切换到超级用户

su -

su

sudo -s

# 权限

修改权限

chmod u+x filename

chmod g-r filename

chmod o+rwx filename

chmod u-x,g+rwx,o-rwx filename

chmod 000 filename

chmod 777 filename

chmod 666 filename

sudo chown root filename 修改文件拥有者

sudo chgrp root filename 修改文件所属组

sudo chown root:root filename 一次修改拥有者和所属组

sudo adduser wangwu 新增用户wangwu

sudo passwd wangwu 给wangwu设置密码

sudo userdel -r wangwu  删除wangwu



sl  跑火车

cowsay hello  羊说

echo "cat" | boxes -d cat  显示cat

echo "dog" | boxes -d dog  显示狗

curl http://wttr.in  显示天气

linuxlogo/linux_logo

elinks www.baid.com  命令行中访问百度 q退出

ping -c3 www.baidu.com  检测是否可以访问www.baidu.com，即查看是否联网，一共三次（c - count）

没网：

1.ifconfig  查看联网端口号

ifup  通过端口号连接网路

ifdown  关闭网络
