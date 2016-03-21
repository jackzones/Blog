####[git简介](http://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000/00137586810169600f39e17409a4358b1ac0d3621356287000)

#####local enviroment

- git config --global user.name "jackzones"
- git config --global user.email "jackzones1991@gmail.com"

#####initial a reposity

`git init`

#####add files

`git add filename`

`git commit -m 'add a file'`

#####status

find which file modified and the branch


`git status`

#####verify the difference

see the modified content

`git diff filename`


result:
```
diff --git a/readme.txt b/readme.txt
index 46d49bf..9247db6 100644
--- a/readme.txt
+++ b/readme.txt
@@ -1,2 +1,2 @@
-Git is a version control system.
+Git is a distributed version control system.
 Git is free software.
 ```
#####git log

show the log that we commited from the farest to the latest 

show the compact log on one line

`git log --pretty=online`

#####版本回退 git reset --hard commit_id

回退到上一个commit版本


`git reset --hard HEAD^`

回退到没知道版本号的commit版本,查看命令历史:


- 查找已经无法找到的commit id

`git reflog`

- 根据commit id 回退到所在版本,id不用写全,至少6位:

`git reset --hard 2222222`


#####工作区,暂存区,版本库

工作区指本地的reposity,暂存区指add之后保存文件的位置,然后暂存区的code通过commit提交到版本库.
版本库中有HEAD指针,通过commit_id来进行版本管理.

#####丢弃工作区的修改,保持和暂存区或版本库中的一样,版本库里的版本替换工作区的版本

`git checkout -- filename`

#####暂存区的修改撤销掉（unstage）

`git reset HEAD filename`

#####删除文件

`git rm filename`

#####remote reposity

- create public ssh key `ssh-keygen -t rsa -C "youremail@example.com"`
- add the ssh key in the github

######clone from the remote

`git clone git@github.com:jackzones/Blog.git`

######push the reposity to the reomote

- create a new reposity in the github the same name with the reposity
- initial the link `git remote add origin git@github.com:jackzones/learngit.git`
- push `git push -u origin master`

#####branch

######show the branch

`git branch`

######create the branch and switch to it

`git checkout -b name`

######switch to the brache

`git checkout name`

######merge the branch to the current branch

`git merge name`

######delete the branch

`git branch -d name`

#####set the abbreviation

`git config --global alias.co checkout`




















