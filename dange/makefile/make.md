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
	gcc -c $<  $<%.c所代表的源文件，一个一个的拿出来，用gcc编译，形成同名.o

.PHONY:clean
clean:
	rm -f *.o mybin
