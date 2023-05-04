## 预处理

gcc -E test.c -o test.i  

展开头文件

宏替换

去掉注释

条件编译

## 编译

gcc -S test.i -o test.s/gcc -S test.c -o test.s

词法分析

语法分析

语义分析

生成中间代码（可选）

优化中间代码（可选）

生成汇编代码

## 汇编

gcc -c test.s -o test.o/gcc -c test.c -o test.o/gcc -c test.i -o test.o

od test.o  以八进制展示文件内容

汇编语言代码翻译成目标机器指令的过程，生成目标文件

目标文件中所存放的也就是与源程序等效的目标的机器语言代码。目标文件由段组成。通常一个目标文件中至少有两个段：

代码段：该段中所包含的主要是程序的指令。该段一般是可读和可执行的，但一般却不可写。

数据段：主要存放程序中要用到的各种全局变量或静态的数据。一般数据段都是可读，可写，可执行的。

## 链接

gcc test.o -o test（默认动态链接）

gcc test.o -o test_s -static 静态链接

gcc test.c -o test -g  debug模式

ldd test（显示可执行文件test的链接库信息）

/lib/x86_64-linux-gnu/libc.so.6 (0x00007f1d341da000)下的隐藏文件libc-2.31.so是一个动态库

/usr/lib/x86_64-linux-gnu/libc.a（libc.a是一个静态库）

库的真正名字是去掉lib，去掉.XXXX，剩下的名字就是库的名字！！！

gcc 会根据文件，进行默认链接（编译器和文件共同决定）

将有关的目标文件彼此相连接，也即将在一个文件中引用的符号同该符号在另外一个文件中的定义连接起来，使得所有的这些目标文件成为一个能够诶操作系统装入执行的统一整体。



-I 指定头文件所在目录位置

-Wall 显示所有警告信息

-D  向程序中”动态“注册宏定义

-l：指定动态库库名

L：指定动态库路径



gcc -c add.c -o add.o

gcc -c sub.c -o sub.o

制作静态库 ar rcs libmymath.a add.o sub.o

使用静态库 gcc test.c libmymath.a -o test

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