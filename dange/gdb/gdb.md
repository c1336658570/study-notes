gdb：默认是以release方式发布的！不可以被调试

release是一般软件进行发布的模式，并交付给用户的模式

debug：生成的软件内部，是包含了调试信息



debug生成的程序，体积上一定大于release

Linux下默认是release模式，需要修改为debug模式

gcc -o filemane filename.c -g  debug模式（gcc命令添加-g选项）



l/list 显示代码  l#显示第#行代码

b/breakpoint 打断点

info b 查看断点

d 根据断点编号删除断点

r/run 运行程序（断点处停下）

n/next 下一步，遇到函数不进入

s/step 下一步，跳转到函数内部

p/printf p i 查看变量i的值

continue/c 运行到下一个断点停止

finish 结束当前函数调用

display 常显示

display i  显示变量i的值，类似监控变量

display &i 显示变量i的地址

undisplay 根据编号取消常显示

until #  跳转到第#行



run：使用run查找段错误出现的位置

set args：设置main函数命令行参数（在start、run之前）

run 字符串1 字符串2...：设置main函数命令行参数

b 20 if i = 5：设置条件断点

ptype：查看变量类型

bt：列出当前程序正存活着的栈帧

display：设置根据变量

undisplay：取消设置跟踪变量，使用跟踪变量编号

set follow-fork-mode child 设置gdb在fork后跟踪子进程
set follow-fork-mode parent 设置跟踪父进程
