- tar   [tar usage](https://www.tecmint.com/18-tar-command-examples-in-linux/)
The Linux “tar” stands for tape archive (磁带存档)
	1.  create tar archive file
	```
	tar -cvf tarname.tar tarFileOrFolder.txt
	```
		
	c – Creates a new .tar archive file.
	v – Verbosely show the .tar file progress.
	f – File name type of the archive file.

	2. create tar.gz archive file
	To create a compressed gzip archive file we use the option as **z**. 
	For example the below command will create a compressed MyImages-14-09-12.tar.gz file for the directory /home/MyImages. (Note : tar.gz and tgz both are similar).
	```
	tar cvzf MyImages-14-09-12.tar.gz /home/MyImages
	```
	3. Create tar.bz2 Archive File
	The **bz2** feature compress and create archive file less than the size of the **gzip**. The **bz2** compression takes more time to compress and decompress files as compared to **gzip** which takes less time. To create highly compressed tar file we use option as **j**. The following example command will create a Phpfiles-org.tar.bz2 file for a directory /home/php. (Note: tar.bz2 and tbz is similar as tb2).
	```
	 tar cvfj Phpfiles-org.tar.bz2 /home/php
	OR
	 tar cvfj Phpfiles-org.tar.tbz /home/php
	OR 
	 tar cvfj Phpfiles-org.tar.tb2 /home/php
	```

	4.  Untar tar Archive File
	To untar or extract a tar file, just issue following command using option **x (extract)**. For example the below command will untar the file public_html-14-09-12.tar in present working directory. If you want to untar in a different directory then use option as **-C (specified directory)**. 
	```
	## Untar files in Current Directory ##
	# tar -xvf public_html-14-09-12.tar
	
	## Untar files in specified Directory ##
	# tar -xvf public_html-14-09-12.tar -C /home/public_html/videos/
	```

	5. Uncompress tar.gz Archive File
	To Uncompress ** tar.gz ** archive file, just run following command. If would like to untar in different directory just use option** -C and the path of the directory**,  like we shown in the above example.
	```
	# tar -xvf thumbnails-14-09-12.tar.gz
	```

	6. Uncompress tar.bz2 Archive File
	To Uncompress highly compressed tar.bz2 file, just use the following command. 
	```
	# tar -xvf videos-14-09-12.tar.bz2
	``` 
	7. List Content of tar Archive File
 	To list the contents of tar archive file, just run the following command with option **t (list content)**. The below command will list the content of uploadprogress.tar file.
	```
	tar -tvf uploadprogress.tar
	```

	8. List Content tar.gz Archive File
	Use the following command to list the content of tar.gz file.
	```
	# tar -tvf staging.tecmint.com.tar.gz
	```

	9.  List Content tar.bz2 Archive File
	To list the content of tar.bz2 file, issue the following command.
	```
	# tar -tvf Phpfiles-org.tar.bz2
	```
	
	10. Untar Single file from tar File
	To extract a single file called cleanfiles.sh from cleanfiles.sh.tar use the following command.
	```
	# tar -xvf cleanfiles.sh.tar cleanfiles.sh
	OR
	# tar --extract --file=cleanfiles.sh.tar cleanfiles.sh
	```	

	11. Untar Single file from tar.gz File
	To extract a single file tecmintbackup.xml from tecmintbackup.tar.gz archive file, use the command as follows.
	```
	# tar -zxvf tecmintbackup.tar.gz tecmintbackup.xml
	OR
	# tar --extract --file=tecmintbackup.tar.gz tecmintbackup.xml
	```

	12. Untar Single file from tar.bz2 File
	To extract a single file called index.php from the file Phpfiles-org.tar.bz2 use the following option.
	```
	# tar -jxvf Phpfiles-org.tar.bz2 home/php/index.php
	OR
	# tar --extract --file=Phpfiles-org.tar.bz2 /home/php/index.php
	```
	