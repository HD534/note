
##启动 spring 后 运行某个方法
```
    @Autowired
    ApplicationContext applicationContext;

    @EventListener(ApplicationReadyEvent.class)
    public void doSomethingAfterStartup() {
        System.out.println("hello world, I have just started up");
        DynamicRoutingDataSource dynamicRoutingDataSource = applicationContext.getBean(DynamicRoutingDataSource.class);
        DataSource sqlServerDataSource = (DataSource)applicationContext.getBean(SQL_SERVER_DATASOURCE);

        Map<Object, DataSource> newDataSource = new HashMap<>(1);
        newDataSource.put("SQL_SERVER_DATASOURCE", sqlServerDataSource);
        dynamicRoutingDataSource.addDataSource(newDataSource);

    }
```

---

## Jpa

加上注解 `@Converter(autoApply = true)`  可以使Jpa的entity使用上枚举类的自动转换。

```
@Converter(autoApply = true)
public class FileItemStatusConverter implements AttributeConverter<FileItemStatus, String> {
    @Override
    public String convertToDatabaseColumn(FileItemStatus attribute) {
        if (null == attribute) return "";
        return attribute.getText();
    }

    @Override
    public FileItemStatus convertToEntityAttribute(String dbData) {
        return FileItemStatus.getByText(dbData).get();
    }
}

```

---

## spring 启动传参 

具体可参考spring官网
[https://docs.spring.io/spring-boot/docs/current/reference/html/boot-features-external-config.html](https://docs.spring.io/spring-boot/docs/current/reference/html/boot-features-external-config.html)

`java -D `  传参需要放置在 jar 包前面。

关于 `--spring.config.loaction` 的配置，file 形式的需要填写的是相对路径，即相对运行java命令的路径。

---

## Spring Boot 打包成war包 ###

在maven 项目中，将pom文件的打包方式war即可
```
<packaging>war</packaging>
```
如果打包成jar包，而web的文件例如html页面等放在 webapp 目录下，那么使用maven 打包的时候有可能不会把webapp目录打包进来。
参考文档：
[spring-mvc-static-content](https://docs.spring.io/spring-boot/docs/current/reference/html/boot-features-developing-web-applications.html#boot-features-spring-mvc-static-content)

打包成的war包也可以使用` java -jar xxx.war` 的命令来启动springboot，这个时候就会把 webapp 打包进来。

PS：
在打包成war包的情况下，可以添加springboot访问静态资源路径，在配置文件(示例为 yml )中配置如下：
```
spring:
  mvc:
    view:
      suffix: .html
    static-path-pattern: /**
  resources:
    static-locations: file:D:\static\resource
```

如果需要将war包部署到 tomcat 或 websphere 等服务器上：
（参考[howto-traditional-deployment](https://docs.spring.io/spring-boot/docs/current/reference/html/howto-traditional-deployment.html) ）
1. 创建 `war` 包需要 `Application` 继承 `SpringBootServletInitializer` 并实现 `configure` 的方法。
2. 如果是 maven 项目需要将 pom 文件中的 package 方法改成war `<packaging>war</packaging> `  ，默认是 jar 。
3. 将内嵌的 `tomcat` 的 `scope` 改成 `provided` ，这样打包的时候会把 `tomcat` 相关的 `jar` 包都放到一个 `lib-provided` 的文件夹下

```
<dependencies>
  <!-- … -->
  <dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-tomcat</artifactId>
    <scope>provided</scope>
  </dependency>
  <!-- … -->
</dependencies>
```
---

## spring cloud eureka
如果使用java 9 之后（如java11）的版本，需要引入javax.xml 等其他依赖，
Java9 之前不需要引入是因为之前的jdk自带了这些包。


