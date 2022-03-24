## apt使用

sudo apt list | grep "g++" 查找g++

sudo apt remove "g++" 卸载g++

sudo dpkg –r 安装包名 卸载deb



## vim使用

## 命令模式

a：光标后移

i：光标不变

o：另起一行

shift+4 跳转到本行尾部

shift+6 跳转到本行头部

shift+g/G 跳转到文本末尾

8+shift+g 跳转到第8行

n+shift+g 跳转到第n行

ctrl+b 屏幕往后移动一页

ctrl+f 屏幕往前移动一页

ctrl+u屏幕往后移动半页

ctrl+d屏幕往前移动半页

gg跳转到文本开始

b 光标跳到前一个单词开头

w 光标跳到后一个单词开头

e光标跳到后一个单词末尾

yw 将光标所在处到字尾的字符复制到缓冲区

yy 光表所在行复制

#p 复制#次

#yy 复制多行

dd 剪切当前行

#dd 剪切#行

x 删除光标所在位置之后的字符

#x 删除光标所在位置之后#个字符

X/shiftx 删除光标所在位置之前的字符

#X/shiftx 删除光标所在位置之前#个字符

u 撤销

shift ~ 大小写切换（光标所在位置）

r 替换光标所在之处的字符

R 替换光标所到之处的字符直到按下ESC

cw 更改光标所在处的字到字尾处

c#w，c3w表示更改三个字

### vim多行缩进

ctrl+v进入可视模式

选择缩进的行

1.按下I然后按下TAB再按两下ESC就可以

2.shift+</shift+>进行缩进

## 底行模式

set nu 显示行号

no nu

w

q

w!

q!

wq!

vs test1.c  打开test1.c，没有就新建

然后会出现分平，ctrl ww 切换屏幕

gcc test.c 编译

!man 3printf 直接查询man手册   q退出

vs filename 打开另外一个文件