使用 jasypt 对 配置文件中的敏感信息进行加密
具体参考：
[https://github.com/ulisesbocchio/jasypt-spring-boot](https://github.com/ulisesbocchio/jasypt-spring-boot)

- spring boot 项目，在 maven项目的依赖中添加

```
<dependency>
    <groupId>com.github.ulisesbocchio</groupId>
    <artifactId>jasypt-spring-boot-starter</artifactId>
    <version>2.1.0</version>
</dependency>
```

Note: 其他配置参考官网

- 加密过程 在jasypt 的包下，使用命令行进行加密

```
	
	java -cp jasypt-1.9.2.jar  org.jasypt.intf.cli.JasyptPBEStringEncryptionCLI input="sa" password=supersecretz algorithm=PBEWithMD5AndDES saltGeneratorClassName=org.jasypt.salt.RandomSaltGenerator
	
	----------------具体运行信息如下-------------------
	
	D:\maven-repository\org\jasypt\jasypt\1.9.2>java -cp jasypt-1.9.2.jar  org.jasyp
	t.intf.cli.JasyptPBEStringEncryptionCLI input="sa" password=supersecretz algorit
	hm=PBEWithMD5AndDES
	
	----ENVIRONMENT-----------------
	
	Runtime: Oracle Corporation Java HotSpot(TM) 64-Bit Server VM 25.144-b01
	
	
	
	----ARGUMENTS-------------------
	
	algorithm: PBEWithMD5AndDES
	input: sa
	password: supersecretz
	
	
	
	----OUTPUT----------------------
	
	KGFTipzDEtyxGHHyhqkqGw==

```

 - 解密可以使用如下方法：
```
java -cp jasypt-1.9.2.jar  org.jasypt.intf.cli.JasyptPBEStringDecryptionCLI input='FAm1t+5It6VrBSJz9FuSyA==' password=supersecretz
```
加密的默认配置参考：
[https://github.com/ulisesbocchio/jasypt-spring-boot#encryption-configuration](https://github.com/ulisesbocchio/jasypt-spring-boot#encryption-configuration)

- 在spring的配置文件（实例为yml配置文件）中添加密钥
` jasypt.encryptor.password: supersecretz`

- 为了安全起见，可以不将密钥（即password）写在properties或其他配置文件中，然后在启动springboot时通过传参的方式传入。
或者打包的时候不包括项目的配置文件，然后将配置文件写在其他地方，在启动spring boot 的时候传入配置文件，同理，加密的密钥也可通过此时的参数传入。

```
java -Djasypt.encryptor.password=supersecretz -jar myApp.jar --spring.config.loaction=file:D:\workspace\application\application.yml 

java -jar myApp.jar --spring.config.loaction=file:D:\workspace\application\application.yml 
```
具体可参考spring官网
[https://docs.spring.io/spring-boot/docs/current/reference/html/boot-features-external-config.html](https://docs.spring.io/spring-boot/docs/current/reference/html/boot-features-external-config.html)

`java -D `  传参需要放置在 jar 包前面。

关于 `--spring.config.loaction` 的配置，file 形式的需要填写的是相对路径，即相对运行java命令的路径。
