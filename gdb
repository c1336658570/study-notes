安装gdb sudo apt install gdb
gdb --version 查看版本

gcc hello.c -o hello编译
./hello执行
gcc -E hello.c -o hello.i 预编译（生成.i文件）
a、处理所有的“#include”预编译指令
b、处理所有的"#define"指令，将代码中所有的"#define"删除，并展开所有的宏定义
c、处理所有的条件预编译指令，如#if #elif #else #ifdef #ifnodef #endif等
d、删除所有的注释
e、添加行号和文件名标识，以便产生错误时给出提示信息
gcc -S hello.i -o hello.s编译
编译器gcc把预处理后的文件进行语法分析、语义分析以及优化后生成汇编代码文件。
gcc -c hello.s -o hello.o 汇编
gcc hello.o -o hello
链接器ld把目标文件与所需要的所有的附加的目标文件(如静态链接库、动态链接库)链接起来成为可执行的文件

gcc -g test.c 在编译带上调试信息
gdb ./a.out 调试程序
run\r 执行程序
quit 退出gdb
man gdb 查看常见命令
list 查看代码
b\break main 打断点
b  9  可以在函数打断电，可以在第几行打断点
info b 查看断点
next\n 下一步
print\p 查看变量信息，可以打印变量，也可以打印地址
step\s 进入某个函数，具体调试

gdb 可以通过shell调用终端命令
set logging on
开启日志功能

watchpoint 观察点
先输出变量地址 再watchpoint *变量地址
info watchpoint 查看观察点
观察变量是否变化

1.调试程序，程序挂掉，core
一个主机 多人共享
shell 做一些显示
core文件 不会默认生成

ulimit -a 查看系统配置
core file size          (blocks, -c) 0
data seg size           (kbytes, -d) unlimited
scheduling priority             (-e) 0
file size               (blocks, -f) unlimited
pending signals                 (-i) 61188
max locked memory       (kbytes, -l) 65536
max memory size         (kbytes, -m) unlimited
open files                      (-n) 1024
pipe size            (512 bytes, -p) 8
POSIX message queues     (bytes, -q) 819200
real-time priority              (-r) 0
stack size              (kbytes, -s) 8192
cpu time               (seconds, -t) unlimited
max user processes              (-u) 61188
virtual memory          (kbytes, -v) unlimited
file locks                      (-x) unlimited

ulimit -c unlimited
修改core文件设置，无限制
gdb 二进制文件 core文件

man ulimit
/ulimit 查找
2.进程run，调试一个正在运行的进程
gcc -g gdbstudy2.c
./a.out & 后台运行
gdp -p pid
