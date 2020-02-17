
tee

运行输出打印到控制台，同时输入到文件里面

`ping google.com | tee output.txt`

By default, the tee command overwrites information in a file when used again. However, if you want, you can change this behavior by using the -a command line option.

`[command] | tee -a [file]`  
So basically, the '-a' option forces tee to append information to the file.