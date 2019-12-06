Git
-----
## 文件状态
已修改 modified  
已暂存 staged (index)   文件村入暂存区
已提交 committed    存入版本库 (本地的)

### add, 将文件添加到 stage, commit 后到 版本库, push 推送到远程版本库 



## git 常用命令

### 创建仓库
git init 创建本地的版本库
git clone

### 版本管理

git add  添加文件到暂存区

git commit 将暂存区的文件添加到版本库

git rm 删除版本库中特定的文件

### 查看信息
git help 
git log 查看版本日志

git diff 比较

### 远程协作
git pull 拉取到本地
git push 推送到远程


### Branch 
new branch:  
git branch 'branch name'

switch branch:  
git checkout 'branch name'

delete branch:  
git branch -d 'branch name'    

### .gitignore
ignore files 


### git rm 与 操作系统的 rm

git rm 会将变动添加到暂存区

git reset HEAD 'filename'  
use "git reset HEAD 'filename'..." to unstage

git checkout -- 'filename'

### git mv 与操作系统的 mv

git mv 会将变动添加到暂存区


### git fetch
让local repo 获取 remote repo 的信息


### git push




### Push a new local branch to a remote Git repository and track it too

1. Create a new branch:
    `git checkout -b feature_branch_name`
2. Edit, add and commit your files.
3. Push your branch to the remote repository:
    `git push -u origin feature_branch_name`



