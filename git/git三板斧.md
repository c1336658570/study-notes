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
git status	#查看工作目录和暂存区状态（区别）
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
mv readme readme.md		#readme已经提交到暂存区了（已经add了）		
git status
git add readme.md
git rm readme

git mv readme readme.md	#这条命令可以替代上面几条命令
git commit -m "Move readme to readme.md"
git reset --hard #git reset --hard命令将HEAD指针以及当前分支的指向都移动到指定的提交（或者其他引用）上，并强制覆盖本地的修改，使工作目录和索引与指定的提交完全一致。这通常用于撤销一些本地的更改，并将仓库重置为先前的状态。
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
#当切换分之后HEAD的内容会变为新分支
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

git diff HEAD HEAD^ == git diff HEAD HEAD^1 == git diff HEAD HEAD~1
git diff HEAD HEAD^^ == git diff HEAD HEAD^1^1 == git diff HEAD HEAD~2

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
#对最近一次commit的message做变更，执行完上面的那条命令后会弹出一个输入框，在输入框中进行修改

~/study-notes main <1>1 !1 > git log -1                            23s 15:37:16
commit e0bed909ddbed5aac382e14cede9f865749e08dc (HEAD -> main)
Author: c1336658570 <1336658570@qq.com>
Date:   Mon May 22 14:30:20 2023 +0800

    git笔记

```

## 如何修改老旧的commit的message

```bash
~/study-notes main <1>1 !1 > git log -3                            INT 15:39:28
commit 779bd7355c8e0ecc326186b0bfea8b07cefdf639
Merge: 6dcf422 34c0ce6
Author: c1336658570 <1336658570@qq.com>
Date:   Mon May 22 15:47:33 2023 +0800

    笔记

commit 6dcf4229fbd31fa7e5006a60a62b20dcd204e89f
Author: c1336658570 <1336658570@qq.com>
Date:   Mon May 22 15:42:50 2023 +0800

    笔记

commit e0bed909ddbed5aac382e14cede9f865749e08dc
Author: c1336658570 <1336658570@qq.com>
Date:   Mon May 22 14:30:20 2023 +0800

    git笔记
#假如你要对一个commit的消息进行变更，执行git rebase -i commit的哈希，其中commit的哈希是你要变更的commit的父亲的哈希
git rebase -i e0bed909dd	#-i是打开一个交互页面
将其中你要修改commit的message的那一项开头的pick修改为reword，可以简写为r
然后保存退出，会在重新弹出一个页面
然后修改其中的commit message
```

`git rebase -i` 是 Git 中基于交互式界面的变基命令。与普通变基相比，它可以更灵活地处理分支历史，并允许重写提交记录。

`-i` 标志表示交互式界面模式，在这个模式下，Git 会打开一个编辑器，列出待变基的提交列表，并让用户对它们进行交互式的重写。

例如，可以使用 `git rebase -i HEAD~3` 命令来对最近的 3 个提交进行交互式的变基操作。在编辑器中，可以对每个提交记录进行编辑、删除、重组等操作，并在保存后执行变基操作。

这个命令对于合并提交的历史记录和压缩提交历史记录等场景特别有用。在使用 `git rebase -i` 命令之前，需要小心检查并备份分支历史，以避免意外删除或混淆提交。

## 如何将多个commit合并为一个

```bash
git log --all  --oneline --graph | more 
* bd78909 git笔记
* 5a2fa83 git笔记
* 7d94830 git笔记
* f9add14 git笔记
*   779bd73 笔记
|\  
| * 34c0ce6 笔记
* | 6dcf422 笔记
* | e0bed90 git笔记
|/  

git rebase -i e0bed90
会打开一个编译器，将其中的pick改为squash，可简写为s
pick 6dcf422 笔记
pick 34c0ce6 笔记
pick f9add14 git笔记
pick 7d94830 git笔记
pick 5a2fa83 git笔记
pick bd78909 git笔记
#将34c0-5a2f四个commit都合并到6dcf422上
pick 6dcf422 笔记
s 34c0ce6 笔记
s f9add14 git笔记
s 7d94830 git笔记
s 5a2fa83 git笔记
pick bd78909 git笔记
然后保存退出
会自动再打开一个文件，让你填写该commit的原因，就是执行git commit -m 后面的那个信息
在文件开头，写一下合并commit的原因
```

## 把几个间隔的commit整理为1个

```bash
git log --all  --oneline --graph | more 
* bd78909 git笔记
* 5a2fa83 git笔记
* 7d94830 git笔记
* f9add14 git笔记
*   779bd73 笔记
|\  
| * 34c0ce6 笔记
* | 6dcf422 笔记
* | e0bed90 git笔记
|/  

git rebase -i e0bed90	#执行完git rebase -i e0bed90后，打开的编辑器只有e0bed90的子孙，没有e0bed90，如果想对e0bed90操作的话，直接在最上面一行添加 pick e0bed90就可以
会打开一个编译器，将其中的pick改为squash，然后将你要把哪几项合并到一起，就把哪几项放到一起
pick 6dcf422 笔记
pick 34c0ce6 笔记
pick f9add14 git笔记
pick 7d94830 git笔记
--pick 5a2fa83 git笔记
pick bd78909 git笔记

#将5a2fa83合并到6dcf422
pick 6dcf422 笔记
--s 5a2fa83 git笔记
pick 34c0ce6 笔记
pick f9add14 git笔记
pick 7d94830 git笔记
pick bd78909 git笔记

不会再自动打开一个新文件，需要使用git rebase --continue 继续进行变基
在打开的文件开头添加这次合并commit的原因，此原因和执行git commit -m 后面要带的那个参数是一样的
```

## 怎么比较暂存区和HEAD所含文件的差异

```bash
打开一个文件进行变更
然后使用git add 将变更的文件提交到暂存区
然后使用git diff --cached比较暂存区和HEAD的差异
```

在 Git 中，有三个重要的概念：工作区（Working Directory）、暂存区（Staging Area或Index）、和 HEAD。 工作区是你当前在编辑和修改的文件目录，也就是你在本地的项目目录。 暂存区是 Git 提供的一个“中间层”，用于保存你添加或修改的文件的快照。在提交之前，你需要先将修改过的文件添加到暂存区。 HEAD 则是当前所在的 Git 分支，指向最新一次提交的快照，在你进行某些操作时需要指定 HEAD。 一般而言，Git 工作流程如下： 1. 在工作区修改某些文件。 2. 通过 `git add` 命令将修改的文件添加到暂存区。 3. 通过 `git commit` 命令将暂存区的内容提交到 HEAD 所在的分支中。 在这个过程中，暂存区对于 Git 版本控制非常重要，它可以让你选择性地提交你所修改过的文件，而不是所有文件。同时，HEAD 可以让你在 Git 提交历史中移动，并查看历史提交的详情。

## 如何比较工作区和暂存区的差异

```bash
git diff		#比较工作区和暂存区的差异
git diff -- git/git三板斧.md  #指定要比较的文件，比较git三板斧.md文件暂存区和工作区的差异
git diff -- git/git三板斧.md /git/git  #比较git三板斧.md和git文件暂存区和工作区的差异
```

## 如何让暂存区恢复成和HEAD一样

```bash
git reset HEAD	#让暂存区和HEAD一样
git reset HEAD -- filename #让暂存区的filename文件和HEAD一样
使用git diff --cached比较暂存区和HEAD，没有任何输出结果代表暂存区和HEAD一样
git reset HEAD^1 #让暂存区和HEAD的父亲一样，当你commit之后，HEAD指向最新一次commit，如果想要撤销此次commit，可以使用git reset HEAD^1，让暂存区和当前HEAD的父亲一样，就是和最新一次commit的父亲一样，就等同于撤销了最新一次的commit
```

## 如何让工作区的文件恢复为和暂存区一样

```bash
#变更工作区使用reset，变更工作区使用checkout
git checkout -- git三板斧.md	#--代表后面要跟文件	将工作区中的git三板斧.md，恢复成和暂存区一样
然后使用git diff -- git三板斧.md 比较一下git三板斧.md这个文件工作区和暂存区的差异，发现没有任何输出，说明工作区和暂存区的相同
```

## 怎样取消暂存区部分文件的更改

```bash
git reset HEAD -- git三板斧.md		#取消git三板斧.md对暂存区的提交，让暂存区的git三板斧.md和HEAD一样
然后使用git diff --cached -- git三板斧.md 比较一下git三板斧.md这个文件暂存区和HEAD的差异 没有任何输出，代表暂存区的git三板斧.md和HEAD的git三板斧.md一样
```

## 消除最近几次提交

```bash
~/study-notes main +1 > git log --all  --oneline --graph | more 
* bd78909 git笔记
* 5a2fa83 git笔记
* 7d94830 git笔记
* f9add14 git笔记
*   779bd73 笔记
|\  
| * 34c0ce6 笔记
* | 6dcf422 笔记
* | e0bed90 git笔记
|/  
* 76491ed 笔记
* 7ac54a6 笔记
* c5144d7 笔记
git reset --hard f9add14 #回到f9add14这个commit，让HEAD指向f9add14，同时工作区和暂存区的内容都回到f9add14和这个commit一样
```

## 看看不同提交的指定文件的差异

```bash
~/study-notes main +1 > git log --all  --oneline --graph -n8 | more        
* bd78909 git笔记
* 5a2fa83 git笔记
* 7d94830 git笔记
* f9add14 git笔记
*   779bd73 笔记
|\  
| * 34c0ce6 笔记
* | 6dcf422 笔记
* | e0bed90 git笔记
|/  
~/study-notes main +1 > git diff bd78909 5a2fa83 | more        #比较两个commit的差异
diff --git "a/git/git\344\270\211\346\235\277\346\226\247.md" "b/git/git\344\270
\211\346\235\277\346\226\247.md"
index 326d81d..734ee54 100644
--- "a/git/git\344\270\211\346\235\277\346\226\247.md"
+++ "b/git/git\344\270\211\346\235\277\346\226\247.md"
@@ -595,6 +595,5 @@ f9add14 git笔记
 e0bed90 git笔记
 git rebase -i e0bed90
 会打开一个编译器，将其中的pick改为squash

git diff main master	#比较main分支和master分支的差异
git diff main master -- a.c	#比较main分支和master分支中的文件a.c的差异
git diff commit号 commit号 -- a.c
```

## 正确删除文件的方法

```bash
git rm a.c		#删除文件a.c
等价于
rm a.c   git rm a.c 这两条命令
```

## 开发中临时加塞了紧急任务怎么处理

```bash
#当开发某个功能时，一部分文件进行修改了，然后已经提交到暂存区，一部分文件正在修改，还在工作区中，该部分文件的工作区和暂存区的内容不相同，然后这个功能还没有开发完毕，来了个新的紧急任务，需要先处理紧急任务，应该怎么办
git stash	#将当前工作区的修改存起来
git stash list #查看有stash列表
git stash apply #将stash列表中的内容拿出来，然后git stash list中的那条信息还在
git stash pop #和apply功能相同，不过他会将git stash list显示的那条信息，拿出来
```

1. `git stash` 命令会将当前工作区修改的内容进行暂存，并将暂存内容保存到 stash 列表中。它可以帮助我们在进行分支切换或者合并等操作之前，先暂时保存当前工作区的修改，以免不小心覆盖或者丢失修改内容。
2. `git stash list` 命令用于查看当前项目中所有的 stash 列表，列表中会显示每次 stash 操作的信息，比如 stash 的标识符、stash 的描述信息、stash 的提交时间等参数。
3. `git stash apply` 命令会从 stash 列表中拿出最新的暂存内容并应用到当前工作区和暂存区中。区别于 `git stash pop` 的是，执行 apply 命令并不会删除在 stash 列表中对应的 stash。
4. `git stash pop` 命令也会将 stash 列表中最新一次的暂存内容应用到当前工作区和暂存区中，但它不同于 apply 的地方在于执行 pop 命令会将最新的 stash 从 stash 列表中删除。

## 如何指定不需要git管理的文件

使用.gitignore指定忽略哪些文件

## 如何将git仓库备份到本地

看pdf常用的传输协议

```bash
cd ~
mkdir 666-backup
cd 666-backup
git clone --bare /home/cccmmf/study-notes/.git ya.git   #克隆  采用哑协议
git clone --bare file:///home/cccmmf/study-notes/.git zhineng.git	#采用智能协议
cd ~/study-notes
~/study-notes main +1 !2 > git remote -v                               13:51:42
origin	git@github.com:c1336658570/study-notes.git (fetch)
origin	git@github.com:c1336658570/study-notes.git (push)

git remote add zhineng file:///home/cccmmf/666-backup/zhineng.git	#智能协议

~/study-notes main >1 > git push zhineng                               13:55:32
枚举对象中: 9, 完成.
对象计数中: 100% (9/9), 完成.
使用 16 个线程进行压缩
压缩对象中: 100% (5/5), 完成.
写入对象中: 100% (5/5), 4.26 KiB | 2.13 MiB/s, 完成.
总共 5（差异 3），复用 0（差异 0），包复用 0
To file:///home/cccmmf/666-backup/zhineng.git
   bd78909..e1ed08a  main -> main
   
#study-notes那个目录下的commit情况
~/study-notes main >1 !1 > git log --all  --oneline --graph | more  7s 13:56:19
* e1ed08a git笔记
* bd78909 git笔记
* 5a2fa83 git笔记
* 7d94830 git笔记
* f9add14 git笔记
#远端备份的那个目录的commit情况
~/666-backup/zhineng.git > git log --all  --oneline --graph | more  7s 13:55:49
* e1ed08a git笔记
* bd78909 git笔记
* 5a2fa83 git笔记
* 7d94830 git笔记
* f9add14 git笔记
*   779bd73 笔记
#study-notes那个目录下的分支情况
* main                 e1ed08a [领先 1] git笔记
  remotes/origin/HEAD  -> origin/main
  remotes/origin/main  bd78909 git笔记
  remotes/zhineng/main e1ed08a git笔记
#远端备份的那个目录的分支情况
* main e1ed08a git笔记
```

 `git remote add` 命令添加远程仓库之后，可以使用 `git remote rm` 命令移除对应的远程仓库。

1. 首先需要使用 `git remote` 命令查看当前 Git 仓库中已经存在的远程仓库列表，找到需要删除的远程仓库的名称。

   ```
   git remote
   ```

2. 使用 `git remote rm` 命令加上需要删除的远程仓库的名称进行删除操作。

   ```
   git remote rm <远程仓库名称>
   ```

   其中 `<远程仓库名称>` 是需要删除的远程仓库的名称。

   例如，如果需要删除名为 `origin` 的远程仓库，可以执行以下命令：

   ```
   git remote rm origin
   ```

3. 确认删除后，可以使用 `git remote` 命令再次查看远程仓库列表，应该能够看到被删除的远程仓库已经不再显示。

   ```
   git remote
   ```

## 把本地仓库同步到github

```bash
git remote -v   #查看远端仓库
git remote add github 复制github仓库的那个ssh地址	#将当前仓库和远端建立连接，远程名字为github
git push github --all	#将所有的推送到远端的github上，"--all"选项表示将本地仓库中的所有分支和标签都推送到远程仓库 
#当远端有修改过的东西，但是本地不存在时，git push 会出错。
#比如远端master有一些修改，但是本地master不存在，就会出错，如下是解决办法
git fetch github master	#将远端的github的master拉下来
#git fetch github master 是一个 Git 命令，用于从名为 "github" 的远程仓库中检索 "master" 分支的最新更改，但它并不会自动将这些更改合并到本地仓库中。
#具体来说，这个命令会检查远程仓库 "github" 上的 "master" 分支的最新更新，并将这些更新下载到本地仓库的缓存中（称为 "远程跟踪分支"）。这将使得本地存储库知道远程存储库中的最新更改，但并不会应用于本地 "master" 分支。要将这些更新合并到本地 "master" 分支中，需要使用其他命令（例如 git merge 或 git pull 命令）来完成。
#总之，git fetch github master 命令是 Git 工具中的一个命令，用于检索远程存储库 "github" 上 "master" 分支的最新更改，但它不会自动将这些更改合并到本地存储库中。
git checkout master #切换到本地的master
git merge github/master  #将本地master和远端master合并，此命令用于将名为 "github" 的远程仓库中的 "master" 分支中的更改合并到当前本地分支中。如果两个commit历史都是独立的，即本地分支和远程仓库中的分支没有共同的祖先时，意味着本地和远端的commit在两个不同的树上，进行merge会出错，可以采用如下命令
git merge --allow-unrelated-histories github/master	#会弹出来一个输入页面，让你写merge原因
#git merge --allow-unrelated-histories github/master 是一个 Git 命令，用于将名为 "github" 的远程仓库中的 "master" 分支中的更改合并到当前本地分支中，并且允许合并无关历史的分支。
#当本地分支和远程仓库中的分支没有共同的祖先时，Git 会拒绝合并操作，因为它们的历史记录是独立的，Git 不能自动将它们连接起来。但是，使用 "--allow-unrelated-histories" 选项，Git 就会将它们视为没有共同祖先的两个独立的分支，并允许将它们合并在一起。
#该命令执行合并操作时，可能会导致合并冲突，需要手动解决冲突并提交更改。
#总之，git merge --allow-unrelated-histories github/master 命令是 Git 工具中的一个命令，用于将名为 "github" 的远程仓库中的 "master" 分支中的更改合并到当前本地分支中，并允许合并没有共同祖先的两个分支历史。

#当使用git merge后可以使用如下命令将本地推送到远端
git push github master
```

`git pull` 和 `git fetch` 都是 Git 中用于更新远程仓库代码到本地仓库的命令，但它们的具体含义和行为略有不同。`git fetch` 用于从远程仓库检索最新的代码更改，但不会自动合并这些更改到本地分支。这个命令会将远程代码库的所有分支和标签都更新到本地的缓存中，但是代码库最新的更改并不会应用到本地分支中。因此，如果使用了 "git fetch" 命令，需要使用其他命令（例如 "git merge" 或 "git rebase"）将远程最新的代码更改合并到本地分支上。`git pull` 命令则将本地仓库和远程仓库的代码合并到一个步骤中，包括检索最新的代码更改和自动合并这些更改到当前的本地分支。它实质上相当于运行 "git fetch" 命令检索更新，然后运行 "git merge" 将更新合并到本地分支中。

## 不同人修改了不同文件如何处理

```bash
在远端创建一个仓库其中有一个名为feature/add_git_commands的分支
#a用户克隆远端的仓库，然后使用如下命令在本地创建一个同名分支分支，基于远端的feature/add_git_commands
git checkout -b origin/feature/add_git_commands origin/feature/add_git_commands
#然后a用户修改feature/add_git_commands分支下的文件，并推送到远端
git add .
git  commit -m "a"
git push

#b用户先fetch 远端仓库
git fetch github
#使用如下命令创建新分支
git checkout -b origin/feature/add_git_commands origin/feature/add_git_commands
#然后修改feature/add_git_commands分支下的文件，并推送到远端
git add .
git commit -m "b"

#不进行push，然后切换到a用户，a用户修改feature/add_git_commands下的文件，然后执行如下命令
git add .
git commit -m "a"
git push

#切换回a用户，进行git push github
git push github	#报错，无法推送到远端，远端仓库已经修改了
#先fetch
git fetch github
#然后使用merge
git merge github/feature/add_git_commands
#使用git push推送
git push
```



