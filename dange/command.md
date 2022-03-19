# Linux下命令

etc/soduers    超级用户权限

whoami  当前用户

su -   切换超级用户

超级用户下输入 passwd修改超级用户密码

passwd  默认修改当前用户密码

passwd username   修改其他用户密码

echo "hello" > test.c  将hello写入test.c

cat test.c  显示test.c的内容

pwd 工作目录

rm 删除文件

rm -r 删除目录



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