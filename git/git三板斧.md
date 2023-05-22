# git三板斧

## git使用前的最小配置

### 配置user信息

```bash
git config --global user.name "yourname"
git config --global user.email "youremail"

git config --local user.name "yourname"
git config --local user.email "youremail"
#如果同时设置了global和local，则local生效，global不生效
```

缺省等于local

```bash
git config --local		#只对某个仓库有效
git config --global		#对当前用户所有仓库有效
git config --system		#system对系统所有登陆的用户有效
```

显示config的配置，加--list

```bash
git config --list --local
git config --list --global
git config --list --system
git config --local user.name	#显示user.name的信息
git config --local user.email	#显示user.email的信息
```

## 创建仓库配置local用户信息

建git仓库

两种场景

1.把已有的项目代码纳入git管理

```bash
cd 项目所在目录
git init
```

2.新建的项目直接用git管理

```bash
cd 某个文件夹
git init your_project	#会在当前路径创建和项目同名的文件夹
cd your_project
git status	#查看工作目录和暂存区状态
git log		#查看commit日志
```

## 通过几次commit认识工作区和暂存区

```bash
git add files	#将工作目录中的文件添加到暂存区
git commit 		#将暂存区内容提交，形成版本历史
git add -u		#对于git已经跟踪的文件（已经add过，但是又修改了的文件）可以使用git add -u将所有的修改过的文件提交
```

## 给文件重命名的简便方法

```bash
mv readme readme.md		#readme已经提交到暂存区了		
git status
git add readme.md
git rm readme

git mv readme readme.md	#这条命令可以替代上面几条命令
git commit -m "Move readme to readme.md"
```

## 通过git log 查看版本历史

```bash
git log --oneline	#每一个commit只显示1行
git log -n4			#只显示最近4次commit
git log -n4 --oneline
git checkout -b asd	#新建asd分支
git commit -am "add" #git add和commit同时进行
git branch -av		#查看分支
git log 			#查看当前分支的历史
git log --all		#查看所有分支的历史
git log --all --graph #查看所有分支历史并带图形化
git log --oneline
git log --oneline --all
git log --oneline --all -n4
git log --oneline --all -n4 --graph
```

## 图形界面工具查看版本历史

```bash
gitk
```

## 探秘

```bash
~/study-notes main !2 > cd .git                                        11:26:14

~/study-notes/.git main !2 > ls                                        11:26:16
branches        config       HEAD   index  logs     ORIG_HEAD    refs
COMMIT_EDITMSG  description  hooks  info   objects  packed-refs

~/study-notes/.git main !2 > cat HEAD                               7s 11:26:39
ref: refs/heads/main		#HEAD告诉当前工作在哪个分支上
#通过编辑HEAD和通过git checkout 切换分支的效果是一样的
~/study-notes/.git main !2 > git branch -av 
* main                c5144d7 笔记
  remotes/origin/HEAD -> origin/main
  remotes/origin/main c5144d7 笔记

~/study-notes/.git main !2 > cat config                                11:28:26
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
[remote "origin"]
	url = git@github.com:c1336658570/study-notes.git
	fetch = +refs/heads/*:refs/remotes/origin/*
[branch "main"]
	remote = origin
	merge = refs/heads/main
#	config存储一些配置信息
#可以直接修改config来修改配置
#通过修改config可以替代
git config --local user.name c1336658570
git config --local user.email 1336658570@qq.com

~/study-notes/.git main !2 > git config --local user.email "1336658570@qq.com"

~/study-notes/.git main !2 > git config --local user.name "c1336658570"

~/study-notes/.git main !2 > cat config                                11:31:40
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
[remote "origin"]
	url = git@github.com:c1336658570/study-notes.git
	fetch = +refs/heads/*:refs/remotes/origin/*
[branch "main"]
	remote = origin
	merge = refs/heads/main
[user]
	email = 1336658570@qq.com
	name = c1336658570

~/study-notes/.git main !2 > git config --local user.name              11:31:44
c1336658570

vim config	#删除[user]
			#email = 1336658570@qq.com
			#name = c1336658570
			
~/study-notes/.git main !2 > git config --local user.name              11:32:53

~/study-notes/.git main !2 > cd refs                                   11:32:55

~/study-notes/.g/refs main !2 > ls                                     11:33:25
heads  remotes  tags
#heads保存了一些分支，tags是一些标签，比如开发到1.0版本，可以打一个标签

~/study-notes/.g/refs main !2 > cd heads                               11:33:26

~/study-notes/.g/r/heads main !2 > ls                                  11:34:36
main

~/study-notes/.g/r/heads main !2 > cat main                            11:34:37
c5144d7c3c2b2c7048a253c21cdd804a6b86cb43

~/study-notes/.g/r/heads main !2 > git cat-file -t c5144d7 #看类型     11:35:03
commit

~/study-notes/.g/r/heads main !2 > git branch -av                      11:36:15
 main                c5144d7 笔记	#c5144d7和前面cat main出来的内容一样，main存放的是一个commit哈希值。
  remotes/origin/HEAD -> origin/main
  remotes/origin/main c5144d7 笔记

~/study-notes/.g/r/heads main !2 > git cat-file -p c5144d7 #看内容     11:38:30
tree 7dabb9e80415e4393972b74324122cb29291d384
parent 5e6422dedd9506286da4870abf18ca6a1434a444
author c1336658570 <1336658570@qq.com> 1683470599 +0800
committer c1336658570 <1336658570@qq.com> 1683470599 +0800
笔记


~/study-notes/.git main !2 > cd objects                                11:39:25

~/study-notes/.g/objects main !2 > ls                                  11:39:27
0c  39  55  5e  7d  81  ad  ba  c5  d6  fa  fd  fe  info  pack

~/study-notes/.g/objects main !2 > cd d6                               11:39:37

~/study-notes/.g/o/d6 main !2 > ls                                     11:40:02
cba8d718ca01bca24a1d467bed80f0bfa745ca

~/study-notes/.g/o/d6 main !2 > git cat-file -t d6cba8d718             11:40:03
blob	#blob是文件对象

~/study-notes/.g/o/d6 main !2 > git cat-file -p d6cba8d718             11:40:29
#include "test.h"

int main(void)
{
    show();

    return 0;
}

#commit，tree，blob，都是git的对象，blob是文件对象
```

在Git中，blob、tree和commit是Git对象中的三种主要类型：

1. Blob（二进制大对象）：表示Git仓库中的文件内容，使用SHA-1哈希值标识唯一。
2. Tree（树对象）：表示一个目录或文件夹，包含多个子对象（可能是其他文件夹或文件），使用SHA-1哈希值标识唯一。
3. Commit：表示一次提交操作，包含一个或多个tree对象和一些元数据（如作者、提交时间、注释等），它也使用SHA-1哈希值标识唯一。

## commit、tree和blob三个对象的关系

看pdf
```bash
~/study-notes/.g/o/d6 main !2 > git log --all --graph  --oneline    6s 11:56:26
* c5144d7 (HEAD -> main, origin/main, origin/HEAD) 笔记
* 5e6422d 笔记
* 27d9c8c 1
* 71e1b0c 1
* b102465 task
* bcf6bb7 task

~/study-notes/.g/o/d6 main !2 > git cat-file -p c5144d7            29s 11:56:57
tree 7dabb9e80415e4393972b74324122cb29291d384
parent 5e6422dedd9506286da4870abf18ca6a1434a444
author c1336658570 <1336658570@qq.com> 1683470599 +0800
committer c1336658570 <1336658570@qq.com> 1683470599 +0800
笔记

~/study-notes/.g/o/d6 main !2 > git cat-file -p 7dabb9e80415e4393972b74324122cb29291d384   040000 tree 16e90ee0949a2daef384c9508e93c0c9acfb1fca	Linux101
040000 tree 3614f4a222d8e6338b177d39f991a42fac269d67	command
040000 tree 0c33b64a98046815f52c89acb2a81c57a5d2d315	dange
040000 tree 194a862b95f1879e605253fc47a63bd7871b4f65	gdb
100644 blob 718888ac22d1354f85da924732c5f351b8494e90	git
040000 tree 55edc4a6b97bb36c65a3868d6a161b7329349d1d	"linux\345\256\236\346\210\230\346\212\200\350\203\275"
100644 blob 195f9b21c82ad9600a1143ced8c44098e5470fff	markdownnotes.md
100644 blob 236540bc959a8df2454c9abba118dd626e2e9a61	"redis \346\223\215\344\275\234.md"
100644 blob df14c82cae1fb0418fc9afd582dae6b239fdcd33	vimnotes

~/study-notes/.g/o/d6 main !2 > git cat-file -p 718888ac22d1354f85da924732c5f351b8494e90   
touch
rm -r 删除一个文件夹，rm -r src 删除src目录
reset 重新初始化终端/清屏
history 查看历史命令
git config -l 查看git配置
git config --system --list 查看系统配置
git config --global --list 用户自己配置
D:\learn\Git\Git\etc\gitconfig Git系统配置目录
C:\Users\13366\.gitconfig Git用户自己配置的
查看用户名密码，及邮箱配置
git config user.name
...
```



## 数一数tree的个数

看pdf

```bash
~ > git init qwerty                                                    12:00:12
已初始化空的 Git 仓库于 /home/cccmmf/qwerty/.git/

~ > cd qwerty                                                          12:00:17

~/qwerty master > ls -a                                                12:00:40
.  ..  .git

~/qwerty master > mkdir doc                                            12:00:59

~/qwerty master > git status                                           12:01:02
位于分支 master
尚无提交
无文件要提交（创建/拷贝文件并使用 "git add" 建立跟踪）

~/qwerty master > cd doc                                               12:01:06

~/qwerty/doc master > echo "helloworld" > readme                       12:01:10

~/qwerty/doc master ?1 > cd ..                                         12:01:25

~/qwerty master ?1 > git status                                        12:01:26
位于分支 master
尚无提交
未跟踪的文件:
  （使用 "git add <文件>..." 以包含要提交的内容）
	doc/
提交为空，但是存在尚未跟踪的文件（使用 "git add" 建立跟踪）

~/qwerty master ?1 > find .git/objects -type f                         12:01:28

~/qwerty master ?1 > git add doc                                       12:02:22

~/qwerty master +1 > git status                                        12:02:34
位于分支 master
尚无提交
要提交的变更：
  （使用 "git rm --cached <文件>..." 以取消暂存）
	新文件：   doc/readme

~/qwerty master +1 > find .git/objects -type f                         12:02:41
.git/objects/31/e0fce560e96c8b357f5b8630c7d8fbeb0a3ec8

~/qwerty master +1 > git cat-file -t 31e0fce560                        12:03:33
blob

~/qwerty master +1 > git cat-file -p 31e0fce560                        12:04:09
helloworld

~/qwerty master +1 > git commit -m "add re"                            12:04:32
[master （根提交） 580b85e] add re
 1 file changed, 1 insertion(+)
 create mode 100644 doc/readme

~/qwerty master > find .git/objects -type f                            12:04:37
.git/objects/31/e0fce560e96c8b357f5b8630c7d8fbeb0a3ec8
.git/objects/58/0b85e0b8d8d66eb70688d53f8a04a9eecb6bcf
.git/objects/ac/04af8cf5199b38de2a924423bfdfdcde8de3cd
.git/objects/43/62281ecfb5966acd45fa0d4ea904eac3ffd78e

~/qwerty master > git cat-file -t 31e0fce560e96                        12:04:47
blob

~/qwerty master > git cat-file -p 31e0fce560e96                        12:06:45
helloworld

~/qwerty master > git cat-file -t 580b85e0b8                           12:05:27
commit

~/qwerty master > git cat-file -p 580b85e0b8                           12:07:42
tree ac04af8cf5199b38de2a924423bfdfdcde8de3cd
author c1336658570 <1336658570@qq.com> 1684728277 +0800
committer c1336658570 <1336658570@qq.com> 1684728277 +0800

add re

~/qwerty master > git cat-file -t ac04af8cf5199b38d                    12:05:40
tree

~/qwerty master > git cat-file -p ac04af8cf5199b38d                    12:06:27
040000 tree 4362281ecfb5966acd45fa0d4ea904eac3ffd78e	doc

~/qwerty master > git cat-file -t 4362281ecfb5966a                     12:05:43
tree

~/qwerty master > git cat-file -p 4362281ecfb5966a                     12:05:55
100644 blob 31e0fce560e96c8b357f5b8630c7d8fbeb0a3ec8	readme

```

## 分离头指针下的注意事项

Git中的“分离头指针”是指当前所在的提交不是任何分支的最新提交，而是指向某一特定提交的具体SHA-1哈希值。这种情况发生在用户检出（checkout）了一个非分支引用（如标签、提交ID等）或直接使用git checkout命令切换到一个特定的提交时。在这种情况下，HEAD指针不再指向分支引用，而是直接指向特定的提交，因此称为“分离头指针”。

```bash
~/study-notes main !2 > git log --all --graph  --oneline           12s 12:18:42
* c5144d7 (HEAD -> main, origin/main, origin/HEAD) 笔记
* 5e6422d 笔记
* 27d9c8c 1
* 71e1b0c 1
* b102465 task
* bcf6bb7 task
* 18c1f21 redis学习笔记
* 1296ad9 study notes

~/study-notes main >1 > git checkout 5e6422d                           12:19:30
注意：正在切换到 '5e6422d'。

您正处于分离头指针状态。您可以查看、做试验性的修改及提交，并且您可以在切换
回一个分支时，丢弃在此状态下所做的提交而不对分支造成影响。

如果您想要通过创建分支来保留在此状态下所做的提交，您可以通过在 switch 命令
中添加参数 -c 来实现（现在或稍后）。例如：

  git switch -c <新分支名>

或者撤销此操作：

  git switch -

通过将配置变量 advice.detachedHead 设置为 false 来关闭此建议

HEAD 目前位于 5e6422d 笔记

~/study-notes @5e6422de > ls                                           12:22:22
 command   gdb   Linux101        makefile          'redis 操作.md'
 dange     git   linux实战技能   markdownnotes.md   vimnotes

~/study-notes @5e6422de > vim git                                      12:23:03
在第一行添加asd

~/study-notes @5e6422de > git add .                                    12:23:03

~/study-notes @5e6422de +1 > git commit -m "笔记"                      12:24:05
[分离头指针 9f60efb] 笔记
 1 file changed, 1 insertion(+)

~/study-notes @9f60efb9 > git status                                   12:24:12
头指针分离自 5e6422d
无文件要提交，干净的工作区

~/study-notes @9f60efb9 > git log --all --graph  --oneline             12:25:50
* 9f60efb (HEAD) 笔记		#HEAD没有跟任何分支绑定，指向一个commit
| * 76491ed (origin/main, origin/HEAD, main) 笔记
| * 7ac54a6 笔记
| * c5144d7 笔记
|/  
* 5e6422d 笔记

~/study-notes @9f60efb9 > git checkout main                        10s 12:26:03
警告：您正丢下 1 个提交，未和任何分支关联：

  9f60efb 笔记

如果您想要通过创建新分支保存它，这可能是一个好时候。
如下操作：

 git branch <新分支名> 9f60efb

切换到分支 'main'
您的分支与上游分支 'origin/main' 一致。

~/study-notes main > gitk                                              12:26:51
#通过gitk查看刚才那次分类头指针的提交是否存在，查看后发现不存在

#可以使用git branch asd 9f60efb	新建一个分支asd与9f60efb这次提交对应
```

## 进一步理解HEAD和branch

```bash
~/study-notes main > git log --all --graph  --oneline              20s 12:27:56
* 76491ed (HEAD -> main, origin/main, origin/HEAD) 笔记
* 7ac54a6 笔记
* c5144d7 笔记
* 5e6422d 笔记
* 27d9c8c 1
* 71e1b0c 1
* b102465 task
* bcf6bb7 task
* 18c1f21 redis学习笔记

#创建ceshi分支并且换到ceshi分支，ceshi分支基于main分支
/study-notes main !1 > git checkout -b ceshi main                     14:22:35 
M	"git/git\344\270\211\346\235\277\346\226\247.md"
切换到一个新分支 'ceshi'

#HEAD不再指向main，而是指向ceshi
~/study-notes ceshi !1 > git log --all --graph  --oneline -n1          14:23:07
* 76491ed (HEAD -> ceshi, origin/main, origin/HEAD, main) 笔记

~/study-notes ceshi !1 > gitk --all                                10s 14:24:10
查看HEAD是否指向ceshi分支

~/study-notes ceshi !1 > cat .git/HEAD                             36s 14:25:32
ref: refs/heads/ceshi

~/study-notes ceshi !1 > git log --all --graph  --oneline -n5          14:26:09
* 76491ed (HEAD -> ceshi, origin/main, origin/HEAD, main) 笔记
* 7ac54a6 笔记
* c5144d7 笔记
* 5e6422d 笔记
* 27d9c8c 1

~/study-notes ceshi !1 > git diff 76491ed 7ac54a6                   6s 14:27:52
diff --git "a/git/git\344\270\211\346\235\277\346\226\247.md" "b/git/git\344\270
\211\346\235\277\346\226\247.md"
index a3c156d..dd92677 100644
--- "a/git/git\344\270\211\346\235\277\346\226\247.md"
+++ "b/git/git\344\270\211\346\235\277\346\226\247.md"
@@ -380,24 +380,6 @@ Git中的“分离头指针”是指当前所在的提交不是任何分支的
 * 18c1f21 redis学习笔记
 * 1296ad9 study notes

~/study-notes ceshi !1 > git diff HEAD HEAD^1                       9s 14:28:04
diff --git "a/git/git\344\270\211\346\235\277\346\226\247.md" "b/git/git\344\270\211\346\235\277\346\226\247.md"
index a3c156d..dd92677 100644
--- "a/git/git\344\270\211\346\235\277\346\226\247.md"
+++ "b/git/git\344\270\211\346\235\277\346\226\247.md"
@@ -380,24 +380,6 @@ Git中的“分离头指针”是指当前所在的提交不是任何分支的
 * 18c1f21 redis学习笔记
 * 1296ad9 study notes

~/study-notes ceshi !1 > git diff HEAD HEAD~1                      10s 14:28:41
diff --git "a/git/git\344\270\211\346\235\277\346\226\247.md" "b/git/git\344\270\211\346\235\277\346\226\247.md"
index a3c156d..dd92677 100644
--- "a/git/git\344\270\211\346\235\277\346\226\247.md"
+++ "b/git/git\344\270\211\346\235\277\346\226\247.md"
@@ -380,24 +380,6 @@ Git中的“分离头指针”是指当前所在的提交不是任何分支的
 * 18c1f21 redis学习笔记
 * 1296ad9 study notes
<<<<<<< HEAD
```

## 怎么删除不需要的分支

```bash
git branch -av		#查看分支
* main                34c0ce6 笔记
  remotes/origin/HEAD -> origin/main
  remotes/origin/main 34c0ce6 笔记
git branch -d main	#删除main分支
git branch -D main  #删除main分支
```

使用“git branch -d”或“git branch -D”命令进行，具体如下：

1. 删除已经合并的分支：使用“git branch -d 分支名”命令，例如“git branch -d feature/branch-name”会删除名为“feature/branch-name”的分支（如果它已经合并到主线上）。
2. 强制删除未合并的分支：使用“git branch -D 分支名”命令，例如“git branch -D feature/branch-name”会强制删除名为“feature/branch-name”的分支（即使它未被合并到主线上）。

## 如何修改commit的message

```bash
~/study-notes main !1 > git log  -1                                    15:36:08
git log -1
commit 34c0ce69be18c14af2b27a533c3fc2455281887c (HEAD -> main, origin/main, origin/HEAD)
Author: c1336658570 <1336658570@qq.com>
Date:   Mon May 22 14:30:20 2023 +0800

    笔记
~/study-notes main !1 > git commit --amend                         HUP 15:36:49
#对最近一次commit的message做变更

~/study-notes main <1>1 !1 > git log -1                            23s 15:37:16
commit e0bed909ddbed5aac382e14cede9f865749e08dc (HEAD -> main)
Author: c1336658570 <1336658570@qq.com>
Date:   Mon May 22 14:30:20 2023 +0800

    git笔记

```

## 如何修改老旧的commit的message

```bash
~/study-notes main <1>1 !1 > git log -3                            INT 15:39:28
commit e0bed909ddbed5aac382e14cede9f865749e08dc (HEAD -> main)
Author: c1336658570 <1336658570@qq.com>
Date:   Mon May 22 14:30:20 2023 +0800

    git笔记

commit 76491ed5bd4360788877d60fba58a975c75055d8
Author: c1336658570 <1336658570@qq.com>
Date:   Mon May 22 12:22:09 2023 +0800

    笔记

commit 7ac54a6a173bfa4e5446a59cb44b9adc8637a205
Author: c1336658570 <1336658570@qq.com>
Date:   Mon May 22 12:19:28 2023 +0800

    笔记

=======
>>>>>>> 34c0ce69be18c14af2b27a533c3fc2455281887c
```

