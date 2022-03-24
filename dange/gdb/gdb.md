gdb：默认是以release方式发布的！不可以被调试

release是一般软件进行发布的模式，并交付给用户的模式

debug：生成的软件内部，是包含了调试信息



debug生成的程序，体积上一定大于release

Linux下默认是release模式，需要修改为debug模式

gcc -o filemane filename.c -g  debug模式（gcc命令添加-g选项）



l 显示代码  l#显示第#行代码

b 打断点

info b 查看断点

d 断点编号 删除断点

r 运行程序（断点处停下）

n 下一步，遇到函数不进入

s/step 下一步，跳转到函数内部

continue/c 运行到下一个断点停止

finish 直接将函数执行完，结束函数调用，停下

display 常显示

display i  显示变量i的值，类似监控变量

display &i 显示变量i的地址

undisplay 编号 取消常显示

until #  跳转到第#行

