# make和makefile

makefile:

1.依赖关系

2.依赖方法

通常缺一不可
mybin:main.c test.c  mybin依赖main.c test.c（依赖关系）

mybin（目标文件）

main.c test.c（依赖文件）

​	gcc main.c test.c -o mybin（依赖方法）

.PHONY:clean   

PHONY：可以理解为makefile的“关键字”，.PHONY:clean(伪目标，总是会被执行成功，依赖关系是否可以无障碍运行)
clean:
	rm -f mybin



mybin:main.o test.o
	gcc $^ -o $@  $^依赖文件  $@目标文件
%.o:%.c     %c当前目录下所有的.c文件展开  %o对应的.c形成的.o
	gcc -c $<    $<%.c所代表的源文件，一个一个的拿出来，用gcc编译，形成同名.o

.PHONY:clean
clean:
	rm -f *.o mybin



一个规则

目标:依赖文件

​	（一个tab缩进）命令

1.目标的时间必须晚于依赖条件的时间，否则，更新

2.依赖条件如果不存在，找寻新的规则去产生依赖

makefile以第一组目标为终极目标，第一组执行完，make结束

可以使用ALL指定终极目标

ALL:test 

两个函数

​	$(wildcard ./*.c)：匹配当前工作目录下所有.c文件，将文件名组成的列表赋值给src   	src=add.c sub.c div1.c

​	$(patsubst %.c, %.o, $(src))：将参数3中，包含参数1的部分，替换为参数2  					obj=add.o sub.o div1.o

clean:（没有依赖）
	-rm -f $(obj) a.out     -的作用是，删除不存在文件时，不报错，顺序执行结果

​	make clean -n  	模拟删除

-n  模拟执行make clean命令

三个自动变量

$@：在规则命令中，表示规则中目标

$^：在规则命令中，表示所有依赖条件

$<：在规则命令中，表示第一个依赖条件。如果将改变量应用在模式规则中，它可将依赖条件列表中的依赖依次取出，套用模式规则。

模式规则：

%.o:%.c

​	gcc -c $< -o $@

静态模式规则：

$(obj):%.o:%.c

​	gcc -c $^ -o $@



可以不使用makefile命名，需要用-f指定名字(指定文件执行make命令)

make -f m6  

make -f m6 clean
