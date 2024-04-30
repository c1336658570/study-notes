# linux实战技能

## centos开机

init 3		从图形界面切换到服务终端

init 0		练习环境关机

### 常见目录介绍

/				根目录

/root 		root用户的家目录

/home/username	普通用户家目录

/etc			配置文件

/bin			命令目录

/sbin			管理命令目录

/usr/bin	/usr/sbin	系统预装的其他命令

## 万能的帮助命令 man help info

man 帮助

help 帮助

info 帮助

### man

man ls

man man

man 7 man

man 1 passwd		命令passwd的帮助

man 5 passwd		配置文件/etc/passwd文件的帮助

man -a passwd		有多个同名的东西在man手册里，使用man -a passwd 可以一个一个查看，man会从手册第一章开始，逐个搜索，如果当前内容不是你想要的，可以使用q退出，然后继续看下一个

### help

shell自带的命令称为内部命令，其他的是外部命令

1. 内部命令使用help帮助

help cd

2. 外部命令使用help帮助

ls --help

使用type查看一个命令是内部还是外部

type cd		cd is a shell builtin

type ls		  ls is an alias for ls --color=tty

### info帮助

比hel更详细，作为help的补充

info ls

## pwd和ls命令

### pwd

显示当前目录名称

### cd

更改当前操作目录

### ls

查看当前目录下文件

-l长格式	-a显示隐藏文件	-r逆序显示	-t按照时间顺序显示	-R递归显示

### su

```bash
su - root切换到root

su 切换到超级用户 且目录切换到超级用户目录

su - 切换到超级用户，目录不变

clear 和 ctrl + l 清空终端
```

## 创建和删除目录

```bash
mkdir /a

mkdir ./a

mkdir b c d

mkdir /a/b

mkdir /a/b/c

mkdir -p /a/b/c/d/e/f/g		创建多个目录

rmdir /a	只能删除空目录

rm -r	/a	递归删除a目录，

rm -rf /a		递归强制删除a目录

## 
```

## 复制和移动目录

```bash
cp -r /root/ /tmp	递归复制目录/root到/tmp

touch /fileaa
cp /filea /tmp
cp -v /filea /tmp	#显示复制过程
cp -p 复制的文件和原文件时间相同
cp -a 保留原有的属组、时间等
mv /filea /fileb	改名
mv /fileb /tmp
mv /tmp/fileb /filec

mkdir /dirc
mv /dirc /tmp

*匹配所有字符
cd /tmp
touch filea fileb filec
mkdir dira dirb dirc -p
cp -v file* /
touch fileaa fileabc
cp -v file* /
ls file*

?匹配单个任意字符
touch fileaa fileabc filea fileb filec
cp file? /
ls file?
```

文件查看命令

```bash
cat	文本内容显示到终端
head	查看文件开头
tail	查看文件结尾
-f	文件内容更新后，显示信息同步更新
wc	统计文件内容信息
```

```bash
cat /tmp/demo

head /tmp/demo	默认显示文件开头十行

head -5 /tmp/demo	显示文件开头无行

tail /tmp/demo	默认显示结尾开头十行

tail -3 /tmp/demo	显示文件结尾3行

tail -f /tmp/demo

wc -l /tmp/demo	查看文件多少行

more /tmp/demo	分行显示，空格继续显示

less /tmp/demo
```

## 打包压缩和解压缩

```bash
tar打包命令
c 打包
x 解包
f 制定操作类型为文件
gzip和bzip2压缩
```

```bash
tar cf /tmp/etc-baskup.tar /etc	将/etc打包，c是打包，f是打包成一个文件
ls -lh	/tmp/etc-backup.tar	显示etc-backup.tar大小时以M显示而不是字节

tar czf /tmp/etc-baskup.tar.gz /etc 	打包并压缩
tar cjf /tmp/etc-baskup.tar.bz2 /etc 	打包并压缩

tar xf /tmp/etc-baskup.tar -C /root	解压打包的文件，并放到root
tar zxf /tmp/etc-baskup.tar.gz -C /root 解压缩
tar jxf /tmp/etc-baskup.tar.bz2 -C /root	解压缩

.tar.bzip2和.tar.bz2和.tbz2和.tgz一样
```

## vim

```bash
#普通模式
i	I
a	A
o	O	#o在光表所在行下一行重启一行，在开头插入，O在光表所在行上一行重启一行，在开头插入
yy	#复制当前行
y$	#复制从光标到当前行结尾的字符
dd	d$
p
u	#撤销
ctrl+r	#恢复
x	#删除单个字符
r	#替换单个字符
11G	#行标移动到11行
^	#移动到行开头
$	#移动到行结尾

#命令模式
:w /root/a.txt	#保存到/root/a.txt
:q	#退出
:q!	#强制退出
:!	#执行命令	
:!ifconfig
/	#查找
n	#下一个字符
shift+n	#上一个字符
:s/old/new	#替换old为new，默认只替换光标所在行，只替换一个字符
:%s/old/new	#在整个文件找old，将old替换为new，只替换一个字符
:%s/old/new/g	#g是全局操作，将所有old替换为new
:3,5/old/new	#在第3行和第5行间将old替换为new，只替换一个字符（单次替换）
:3,5/old/new/g
:set	#一些设置
:set nu	#显示行
:set nonu	#不显示行号

#可视模式
v	#字符可视模式
V	#行可视模式
ctrl+v	#块可视模式

先ctrl+v进入块可视模式，再输入大写I，然后插入123，再按两下ESC，就会在所选块的前面都插入123
ctrl+v选择块，按d删除该块
```

## 用户和权限管理

```bash
useradd	name	#新建用户	默认会新建一个用户组，然后该用户属于该组
#新建用户后会在etc/passwd和e/etc/shadow中添加该用户信息
tail -10 /etc/passwd
tail -10 /etc/shadow

userdel	name	#删除用户
#删除用户一般添加-r选项，不添加-r用户家目录会被保存
userdel -r name 

passwd	name	#修改用户密码

usermod +权限 +name	#修改用户属性
usermod -d /home/w1 w	#将用户w的家目录修改为/home/w1

chage	#修改用户属性

id name	#验证是否有name用户
id root	#验证是否有root用户

groupadd group1	#新建用户组
useradd user1	#新建用户user1
usermod	-g group1 user1	#将user1的用户组改为group1
useradd -g group1 user2	#创建user2同时将user2加入group1

groupdel group1	#删除用户组

su - cccmmf	#临时切换到cccmmf，同时会切换到cccmmf的家目录
su cccmmf	#临时切换到cccmmf,为不完全切换，因为不会修改当前目录
```

## su和sudo

```bash
su	#切换用户
su - USERNAME	#使用 login shell 方式切换用户
sudo	#以其他用户身份执行命令
visudo	#设置需要使用sudo的用户（组），哪些用户可以sudo，用户使用sudo后可以执行哪些命令，使用sudo有哪些权限。比如shutdown是root才可以执行的命令，可以通过配置visudo，可以让普通用户通过sudo shutdown来执行shutdown
#让user3可以使用sudo执行shutdown -c
su - #先进入root
visudo	#打开配置文件
#在配置文件中添加该行让user3可以使用通过sudo /sbin/shutdown -c来执行shutdown -c
user3	ALL=/sbin/shutdown -c
```

## 用户和用户组的配置文件介绍

3个文件

/etc/passwd

/etc/shadow

/etc/group

```bash
#passwd
vim /etc/passwd
#分7个字段，每新建一个用户会写入一条记录，可以使用useradd新建用户，也可以手动修改配置文件新建
#用户名 是否需要密码验证 uid gid 注释 用户家目录 用户登陆成功后命令解释器
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
cccmmf:x:1000:1000:cccmmf,,,:/home/cccmmf:/usr/bin/zsh
sshd:x:129:65534::/run/sshd:/usr/sbin/nologin	#sbin/nologin表示不让用户登陆，不能登陆终端
user1:x:1001:1001::/home/user1:/bin/sh

#手写创建user2
user2:x:1002:1002::/home/user2:/bin/bash
su - user2	#登陆

#/etc/shadow保存用户和密码相关信息
#用户名 用户加密后的密码
root:$y$j9T$GBkyw7vsqGk9U53pVCNvn0$DaY6ZrX.cC3Nwf90U0rqgxghsGkFjKzX74jXOBEqtED:19447:0:99999:7:::
daemon:*:19411:0:99999:7:::
bin:*:19411:0:99999:7:::
sys:*:19411:0:99999:7:::
sync:*:19411:0:99999:7:::
games:*:19411:0:99999:7:::
man:*:19411:0:99999:7:::
cccmmf:$y$j9T$ZcBtZZo.02Cb4VPkUFEia1$IGt.j/9rtrWtc/RWtk2JfneProGun0C0FDVKD6ECmI5:19446:0:99999:7:::
sshd:*:19446:0:99999:7:::
user1:$y$j9T$qRohWqoYxQl5JYl06LKjJ0$OEvMMqzt/a.eus9uzDfQzVw8FlpFovclkN6yW2TSpq1:19481:0:99999:7:::

#/etc/group
#组名 是否需要密码验证 组id（gid） 其他组设置
root:x:0:
daemon:x:1:
bin:x:2:
sys:x:3:
adm:x:4:syslog,cccmmf
tty:x:5:
disk:x:6:
lp:x:7:
mail:x:8:
lxd:x:135:cccmmf
cccmmf:x:1000:
sambashare:x:136:cccmmf
rdma:x:137:
user1:x:1001:
```

## 文件与目录权限的表示方法

```bash
drwxrwxr-x 2 cccmmf cccmmf  4096  5月  4 14:50  linux实战技能
-rw-rw-r-- 1 cccmmf cccmmf  1958  3月 30 17:14  markdownnotes.md

- 普通文件
d 目录文件
b 块特殊文件
c 字符特殊文件
l 符号连接
f 命名管道
s 套接字文件
r 读
w 写
x 执行
r = 4
w = 2
x = 1

x 进入目录
rx 显示目录内的文件名
wx 修改目录内的文件名
```

## 修改权限命令

```bash
chmod 修改文件、目录权限
chmod u g o a 	u修改属主、g修改属组、o修改其他用户权限，a修改所有权限
chmod u+x /tmp/testfile
chmod g-x /tmp/testfile
chmod o=rwx /tmp/testfile
chmod a+r /tmp/testfile
chmod 755 /tmp/testfile

linux创建文件默认是666,然后再减去umask022,然后创建文件默认权限就是644

chown 更改属主、属组
chown user1 ~/studynotes	更改studynotes的属主为user1
chown :group1 ~/studynotes	更改studynotes的属组为group1
chown user1:group1 ~/studynotes

chgrp 可以单独更改属组
chgrp user3 ~/studynotes	更改studynotes的属组为user3

ctrl+r搜索之前执行过的命令
```

## 特殊权限

```bash
SUID	用于二进制可执行文件，执行命令时取得文件属主权限，如果文件属主是root，那么普通用户执行该命令也是以root方式执行的
如/usr/bin/passwd
小写s表示SUID
-rwsr-xr-x 1 root root 59976 11月 24 20:05 /usr/bin/passwd

SGID	用户目录，在该目录下创建新的文件和目录，权限自动更改为该目录的属组

SBIT	用于目录，该目录下新建的文件和目录，仅root和自己可以删除
如/tmp
t表示SBIT
drwxrwxrwt 34 root root 4096  5月  4 15:27 /tmp

修改特殊权限只需要在原有权限前添加一个新的权限就可以
chmod 4755 /test/bfile	给bfile添加SUID（权限最前面的4）
chmod 1777 /test	给test添加SBIT（权限最前面的1）
```

## 网络管理

- 网络状态查看
- 网络配置
- 路由命令
- 网络故障排除
- 网络服务管理
- 常用网络配置文件

```bash
net-tools vs iproute
1.nte-tools
	ifconfig
	route
	netstat
2.iproute2
	ip
	ss
```

### ifconfig

- eth0第一块网卡（网络接口）
- 你的第一个网络接口可能叫如下名字

​	eno1	板载网卡

​	ens33	PCI-E网卡

​	enp0s3	无法获取物理信息的PCI-E网卡

​	Centos 7使用了一致性网络设备命名，以上都不匹配则使用eth0

### 网络接口命名修改

- 网卡命名规则受biosdevname和net.ifnames两个参数影响
- 编辑/etc/default/grub文件（该文件不会被启动设置读取，grub.cfg才会被系统启动读取）增加biosdevname=0 net.ifnames=0。GRUB_CMDLINE_LINUX="biosdevname=0 net.ifnames=0"
- 更新grup
- #grub2-mkconfig -o /boot/grup2/grub.cfg
- 重启
- #reboot

|       | biosdevname | net.ifnames | 网卡名 |
| ----- | ----------- | ----------- | ------ |
| 默认  | 0           | 1           | ens33  |
| 组合1 | 1           | 0           | em1    |
| 组合2 | 0           | 0           | eth0   |

### 查看网络情况

- 查看网卡物理连接情况

​	

```bash
mii-tool eth0

~ > mii-tool wlp1s0                                                    16:33:39
SIOCGMIIPHY on 'wlp1s0' failed: Operation not permitted
显示wlp1s0不支持查看，wlp1s0 是一个网络接口的名称，它通常是指一个无线网卡。在 Linux 系统中，网络接口的名称通常以一种特定的命名规则来命名，其中 w 开头的接口名称通常是指无线网卡，而 p1s0 则表示该网卡连接到 PCI 槽位 1 上。因此，wlp1s0 通常是指连接在第一个 PCI 槽位上的无线网卡。
```



### 查看网关命令

- route -n
- 使用 -n 参数不解析主机名

## 修改网络配置

### 网络配置命令

- ifconfig <接口> <ip地址> [netmask 子网掩码]       设置网卡ip地址
- ifup <接口>      启用网卡
- ifdown <接口>    关闭网卡

### 网关配置命令

- route add default gw<网关ip>       添加默认网关

- route add -host <指定ip> gw <网关ip>     添加明细路由

- route add -net <指定网段> netmask <子网掩码> gw <网关ip>    添加明细路由

### 网络命令集合：ip命令

- ip addr ls

​		ifconfig

- ip link set dev eth0 up

​		ifup eth0

- ip addr add 10.0.0.1/24 dev eth1

​		ifconfig eth1 10.0.0.1 netmask 255.255.255.0

- ip route add 10.0.0/24 via 192.168.0.0.1

​		route add -net 10.0.0.0 netmask 255.255.255.0 gw 192.168.0.1

```bash
ifconfig eth0 10.211.55.4		修改eth0的ip为10.211.55.4
ifconfig eth0 10.211.55.4 netmask 255.255.255.0 	同时设置子网掩码

ifconfig eth0 up		关闭eth0
ifup eth0

route -n  		查看网关
route del default gw 192.168.2.1	删除默认网关
route add default gw 192.168.2.1

添加明细路由，添加后访问10.0.0.1通过10.211.55.1来进行访问
route add -host 10.0.0.1 gw 10.211.55.1

设置访问网段192.168.0.0通过10.211.55.3访问
route add -net 192.168.0.0 netmask 255.255.255.0 gw 10.211.55.3
```

## 网络故障排除命令

- ping						检测当前主机和目标主机是否畅通

​	ping www.baidu.com

- traceroute			 追踪路由，追踪每一跳的质量

​	traceroute -w 1 www.baidu.com

- mtr						 检查当前主机到目标主机是否有数据包丢失
- nslookup			   查询域名对应的ip。用于查询 DNS（Domain Name System）服务器上的域名解析信息。通过 nslookup 命令，您可以查询指定主机名或 IP 地址对应的域名解析记录，也可以查询指定 DNS 服务器上的域名解析信息。

​	nslookup www.baidu.com

- talnet					 检查端口连接状态

​	telnet www.baidu.com	80	检测我当前的80端口到对方80端口是否畅通，HTTP使用80端口，HTTPS使用443端口

- tcpdump			   tcpdump：用于抓取和分析网络数据包，可以捕获网络流量并进行分析。

​	tcpdump -i any -n port 80	-i any是抓取所有网卡的数据包，-n是如果有域名就解析为ip，只抓取80端口的数据包

​	tcpdump -i any -n host 10.0.0.1	捕获我的主机到10.0.0.1之间所有的tcp包

​	tcpdump -i any -n host 10.0.0.1 and port 80 -w /tmp/filename 	捕获我的主机到10.0.0.1之间80端口的所有tcp包，将捕获的信息保存到/tmp/filename

- netstat		  		 查看监听地址。

​	用于显示与 IP、TCP、UDP 和 ICMP 协议相关的统计数据，可以显示当前系统的网络连接状态和网络接口的使用情况。Netstat 可以显示当前计算机上打开的所有网络连接，包括本地 IP 地址、远程 IP 地址、协议类型、端口号等信息。

​	netstat -ntpl		n是如果有域名就将域名解析为ip地址，显示ip地址不显示域名，t是只显示tcp，p端口对应的进程也显示出来，l是LISTEN，就是处于监听状态的

- ss		  		  	   可以显示当前计算机上的网络连接信息。

​	与 netstat 不同的是，ss 命令比 netstat 更快、更高效，它可以显示更多的信息，包括 TCP 连接状态、进程信息、网络接口的使用情况等。	

​	ss -ntpl	和netstat基本相同

## 网络管理和配置文件

### 网络服务管理

- 网络服务管理分为两种，SysV和systemd
- service network start|stop|restart
- chkconfig -list network
- systemctl list-unit-files NetworkManger.service					对 NetworkManger.service服务进行查看，看是否支持
- systemctl start|stop|restart NetworkManger
- systemctl enable|disable NetworkManger

网络配置文件

- ifcfg-eth0		网卡配置文件
- /etc/hosts       主机名相关配置文件

```bash
要么使用network要么使用NewworkManger，不要两种都用，然后去管理网络
service network status   查看网络状态

在Ubuntu上是不推荐使用chkconfig命令的，因为Ubuntu默认使用systemd作为init系统，而chkconfig是用于SysV init系统的命令。16.04以后将chkconfig从软件包中删除了
chkconfig --list network 	查看network
chkconfig --level 2345 network off 	关闭2345级别的network
chkconfig --level 2345 network on

systemctl disable NetworkManager	禁用NetworkManager
systemctl enable NetworkManager		启用NetworkManager

cd /etc/sysconfig/network-scripts/
ls ifcfg-*
	ifcfg-eth0	ifcfg-lo
	
hostname		显示主机名
hostname asdasd	修改主机名为asdasd
hostnamectl set-hostname asdasd	永久生效的修改注记名为asdasd
修改主机名后，很多服务依赖主机名，需要将新主机名写在/etc/hosts文件中的127.0.0.1的对应关系中
在/etc/hosts中写入127.0.0.1 cccmmf
```

## 软件包管理器的使用

```bash
Centos、RedHat使用yum，rpm格式软件包
Debian、ubuntu使用apt，deb格式软件包
```

## 使用rpm命令安装软件包

```bash
vim-common-7.4.10-5.el7.x86_64.rpm
软件名	软件版本 系统版本 平台

rpm命令参数
-q	查询软件包
-i	安装
-e	卸载
rpm -qa	查询系统安装所有的软件包
rpm -qa | more	分页显示系统安装的所有软件包
```

## 使用yum包管理器安装软件包

```bash
install
remove
list|grouplist	查看安装的软件包
update
```

## 源代码编译安装软件包

```bash
wget https://...
tar -zxf
cd ...
./configure --prefix=/usr/local/openresty
make -j16
make install
```

## 如何进行内核升级

### 升级内核

- rpm格式内核
  - 查看内核版本
    - uname -r
    - uname -a
  - 升级内核版本
    - yum install kernel-3.10.0
  - 升级已安装的其他软件包和补丁
    - yum update

### 源代码编译安装内核

- 安装依赖包
  - yum install gcc gcc-c++ make ncurses-devel openssl-devel elfutils-libelf-devel
- 下载并解压缩内核
  - https://www.kernel.org
- tar xvf linux-5.1.10.tar.xz -C /usr/src/kernels
- 配置内核编译参数
  - cd /usr/src/kernels/linux-5.1.10/
  - make menuconfig | allyesconfig | allnoconfig
- 使用当前系统内核配置
  - cp /boot/config-kernelversion.platform /usr/src/kernels/linux-5.1.10/.config
- 查看cup
  - lscpu
- 编译
  - make -j2 all
- 安装内核
  - make modules_install		安装内核支持的模块
  - make install

## grub配置文件

- grub是什么
- grub配置文件
  - /etc/default/grub	默认grub配置，可通过修改此文件修改grub配置，然后通过grub2-mkconfig -o /boot/grub2/grub.cfg生成新的grub.cfg
  - /etc/grub.d         其他一些更详细的grub配置，可通过修改此文件修改grub配置，然后通过grub2-mkconfig -o /boot/grub2/grub.cfg生成新的grub.cfg
  - /boot/grub2/grub.cfg
  - grub2-mkconfig -o /boot/grub2/grub.cfg
- 使用但用户进入系统（忘记root密码）

```bash
grub2-editenv list	查看当前默认引导的内核
grep ^menu /boot/grub/grub.cfg	查看当前系统有多少个可引导项
menuentry 'Ubuntu' --class ubuntu --class gnu-linux --class gnu --class os $menuentry_id_option 'gnulinux-simple-059d13a2-2e82-4832-b452-37f7033fdc83' {
menuentry 'Windows Boot Manager (on /dev/nvme0n1p1)' --class windows --class os $menuentry_id_option 'osprober-efi-1A1B-BBF0' {
menuentry 'UEFI Firmware Settings' $menuentry_id_option 'uefi-firmware' {

grub2-set-default	0	使用grub.cfg显示的第0项作为默认引导	ubuntu
grub2-set-default	1	使用grub.cfg显示的第1项作为默认引导	windows Boot Manager
```

## 使用ps和top命令查看进程

### 进程管理

- 进程的概念与进程查看
- 进程的控制命令
- 进程的通信方式---信号
- 守护进程和系统日志
- 服务管理工具systemctl
- SELinux简介

### 进程的概念

- 进程--运行中的程序，从程序开始到终止的整个生命周期是可管理的
  - C程序的启动是从main函数开始的
    - int main(int argc, char *argv[])
    - 终止方式不唯一，分正常终止和异常终止
      - 正常终止也从main返回，条用exit等方式
      - 异常终止分别调用abort、接受信号等

### 进程的查看命令

- 查看命令
  - ps
  - pstree
  - top
- 结论：
  - 进程也是树状结构
  - 进程和权限有着密不可分的关系
  - `ps -e` ：显示当前所有进程信息，包括未控制终端的进程。
  - `ps -f` ：显示进程的全格式信息，包括进程的UID、PID、PPID、C、STIME等详细信息。
  - `ps -L` ：显示多线程进程的线程信息，包括进程ID、线程ID、CPU占用、状态等信息。该选项要求进程必须是多线程的，否则不起作用。

这三个参数可以同时使用，例如 `ps -eLf` 将显示所有进程以及线程的详细信息。

```bash
ps	查看当前shell（终端）下的进程
ps -e	查看其他进程（所有）
ps -e | more	将ps -e显示的内容分页显示
ps -ef 显示更多信息，其中包括启动该进程的用户信息、该进程所属路径等信息
ps -eLf	-L可以显示该进程包含的线程数量，在 LWP那一列
pstree	树状显示所有进程
top	显示一些进程信息
top之后那个下方进程跳动的速度是每3秒更新一次，可以按s然后按1回车更改为每1s更新一次
top执行后按1可以显示每个cpu的一个状态
top -p 12345	查看12345进程，-p指定进程号
```

## 进程的控制与进程之间的关系

### 进程的优先级调整

- 调整优先级
  - nice范围从-20到19,值越小，优先级越高，抢占资源就越多
  - renice重新设置优先级
- 进程的作业控制
  - jobs
  - & 符号



```bash
vim a.sh#创建一个脚本

#脚本文件内容
#!/bin/bash

echo $$	#显示当前进程pid

#死循环什么也不做
while :
do
	:
done


chmod u+x a.sh
./a.sh

echo $$	会显示当前进程pid
然后通过top -p pid  查看该进程，然后查看该进程的PR和NI，PR为系统优先级，NI为系统占用多少资源的意思
nice -n 10 ./a.sh	运行a.sh时将NI值设置为10
renice -n 15 pid	可以修改正在运行程序的优先级，修改该pid进程的NI值为15

./a.sh &在后台运行a.sh
jobs显示后台运行的进程
fg id	将后台进程调回前台
前台进程在运行时按ctrl+z	将其挂起在后台
使用fg id	让其在前台运行
    bg id  让其在后台运行
```

## 进程间通信

- 信号是进程间通信方式之一，典型用法是：终端用户输入中断命令，通过信号机制停止一个程序的运行。
- 使用信号常用快捷键和命令
  - kill -l		查看所有信号
    - SIGINT	通知前台进程组终止进程	ctrl+c
    - SIGKILL  立即结束程序，不能被阻塞和处理  kill -9 pid

## 守护进程

- 使用nohup与&符号配合运行一个命令
  - nohup命令使进程忽略hangup（挂起）信号     nohub运行一个程序，在关闭终端后程序依然在运行
- 守护进程（daemon）和一般进程有什么差别呢？
- 使用screen命令
  - screen进入screen环境
  - ctrl+a d退出（detached）screen环境
  - screen -ls 查看screen的会话
  - screen -r sessionid  恢复会话

```bash
nohup tail -f /var/log/dmesg &  #在终端退出后，tail进程仍然会继续运行

```

