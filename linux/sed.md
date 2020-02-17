
linux命令怎么显示文件某一行或几行内容

用sed的方法是`sed -n 'n,np' | awk '{print $X}'  `  
第2个与第3个n表示你要打印第几行  
比如  
要打印5-8行就是 `sed -n '5,8p' filename`  
你想打印第3行就是 `sed -n '3,3p' filename`  

`|`管道符
就是把sed输出的值输入给awk，$X里的X表示你想输出的第几个字段，awk默认是以空格为分隔符的，要想指定分隔符就是-F
比如以 , 作为分隔符就写作awk -F "," '{print $X}'
还有一种方法不用sed也可以锁定某一行 比如我想锁定/etc/passwd的第10行
语句就是head -10 /etc/passwd | tail -1
如果想打印第十行的以‘：’分割的第2个字段，那么执行语句就是
head -10 /etc/passwd | tail -1 |awk -F: '{print $2}'
head -10 /etc/passwd |tail -1 |cut -d ":" -f2


https://zhidao.baidu.com/question/937504394313593132.html