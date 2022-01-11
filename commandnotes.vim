TAB 自动补全

ls 查看当前目录
ls /home/cccccc/C/
ls /
ls -l /home/cccccc/C 以详细方式列出
ls -a /home/cccccc/C 显示隐藏文件夹mZ
ls ~
ls ./C

pwd 显示当前路径

cd 切换到主目录
cd /home/cccccc/ 切换到指定目录

~ 代表当前用户的主目录
. 代表当前目录
.. 代表上一级目录

cd ~ 切换到著目录
cd ~/C 切换到主目录下的C
cd ../C/ahsf 切换到上级目录🔛C/ahsf

mkdir 创建目录
mkdir abc
mkdir -p abc/123/test 使用-P可以将路径的层次目录全部创建
rmdir 删除空目录，目录非空不可删除
rm 删除文件或目录
rm -rf C 删除C目录，和其子项
r 表示recursive（递归删除），f 表示force（强制删除）
rm -rf /* 删库跑路 好奇害死猫

cp 复制文件或目录
cp -rf 所有子项也会被复制
cp -rf ~C/ learn/C 若目标目录不存在复制该目录，目标目录已存在，将其内容复制
到以存在的目录下面
mv 移动一个文件或目录（重命名）
mv 1.test 2.test  将1.test改名为2.test
mv 1.test ~/C/2.test 移动1.test到C/并改名为2.test

1.echo “想要的内容”> 文件名
将想要的内容覆盖到对应的文件当中去，文件当中之前的内容不复存在了，实际上是修改了原文件的内容。
2.echo “想要的内容”>> 文件名
将想要的内容追加到文件后，对文件之前的内容不修改，只进行增添，也叫追加重定向。
3、将当前时间写入文件
echo date +"%Y-%m-%d %H:%M:%S" begin >> test.txt

1.一次显示整个文件。
$ cat   filename
2.从键盘创建一个文件。
$ cat  >  filename
只能创建新文件,不能编辑已有文件.
3.将几个文件合并为一个文件。
cat   file1   file2  > file


归档压缩
tar，即tape archive 档案打包
tar -cvf example.tar example 将example文件夹打包成example.tar
tar -cvf C.tar C
c 表示create创建档案
v 表示verbose显示详情
f 表示file
也可打包多个 tar -cvf xxx.tar file1 file2 file3
tar -xvf example.tar 还原tar包
tar -xvf example.tar -C outdir
tar -xvf C.tar -C outdir/
-C，参数指定目标路径，默认解压到当前目录下

归档并压缩
tar -czvf example.tar.gz example 将example文件夹打包并压缩成example.tar.gc
tar -czvf C.tar.gz C
解压缩
tar -xzvf example.tar.gz 还原tar包
tar -xzvf example.tar.gz -C outdir
tar -xzvf C.tar.gz -C outdir/

软链接
即，快捷方式
ln命令（link）来创建软链接
ln -s source link
-s，表示soft软链接（默认为硬）
例如：ln -s example example2
删除软链接对原文件无影响
删除原文件软链接失效

用户管理
1.添加用户
sudo useradd -m test1
-m参数表示在/home 下添加用户目录
2.修改用户密码
sudo passwd test1
3.删除用户
sudo userdel test1

超级用户
sudo passwd  root 给root用户设置密码
su root 切换到root用户 su表示switch user
exit 退出
su root 仅对当前终端有效

用户和组
Linux下可以创建多个用户，可以用组进行管理
groupadd boys 创建组
useradd -m -g boys ming 添加用户
-g表示在添加用户，同时将用户加到boys组里
usermod -g boys cccccc
usermod表示修改用户信息
查看组信息
cat /etc/group 每一行表示一个group的信息，名称+ID
查看用户信息
cat /etc/passwd 
创建用户不指定组会默认创建一个同名组
useradd a1，默认会给a1创建一个同名组a1，只有他一个人

以root登陆桌面
1.su root 终端切换root身份
2.gedit /etc/pam.d/gdm-autologin 
在这一行前面加一个#
#auth required    pam_succeed_if.so user != root quiet_success
3.gedit /etc/pam.d/gdm-password 
在这一行前面加#
#auth requiredpam_succeed_if.so user != root quiet_success 


