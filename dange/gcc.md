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

gcc test.o -o test_s -static 动态链接

gcc test.c -o test -g  debug模式

ldd test（显示可执行文件test的链接库信息）

/lib/x86_64-linux-gnu/libc.so.6 (0x00007f1d341da000)下的隐藏文件libc-2.31.so是一个动态库

/usr/lib/x86_64-linux-gnu/libc.a（libc.a是一个静态库）

库的真正名字是去掉lib，去掉.XXXX，剩下的名字就是库的名字！！！

gcc 会根据文件，进行默认链接（编译器和文件共同决定）

将有关的目标文件彼此相连接，也即将在一个文件中引用的符号同该符号在另外一个文件中的定义连接起来，使得所有的这些目标文件成为一个能够诶操作系统装入执行的统一整体。