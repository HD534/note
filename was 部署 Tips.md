## was 部署  Tips

###1 打包 ###
使用 `war` 包可以先添加一个 `META-INF` 的文件夹，文件夹里面添加一个 `application.xml`，即是用来配置当前的war包的信息。
然后使用 `java` 命令
`jar -cf WarName_war.ear .\*` 
将当前文件夹的所有东西打包成一个 `ear` 包

```
<?xml version="1.0" encoding="UTF-8"?><application id="Application_ID" version="6" xmlns="http://java.sun.com/xml/ns/javaee" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/application_6.xsd">
    <description>Demo</description>
    <display-name>appDemo</display-name>
    <module>
        <web>
            <web-uri>WarName.war</web-uri>
            <context-root>/ContextRoot</context-root>
        </web>
    </module>
</application>
```

### 2 部署
在 was 的 console 部署之后，如果是新的程序以及新的`context-root`，则要在你配置的 `Web servers` 上将新的 `context-root` 发布出去。具体的操作是，
1. 在 was 的 console 的右边导航栏选择 Web servers   
 页面上具体结构是 Servers - ServersTypes  - Web servers
2. 然后在 Web servers 的列表中选中你部署时所选的 Web server
3. 勾选上后点击列表左上方的按钮 `Generate Plug-in`；
4. 完成后再勾选对应的 Web server，点击列表左上方的按钮 `Propagate Plug-in` ，完成后即可暴露新添加的 context-root.


###3 http 和 https
在部署时选择的 Virtual Hosts 是部署项目的ip或者是域名，默认 http 是port 80（访问时可不填），https 是 port 443（访问时可不填）。


