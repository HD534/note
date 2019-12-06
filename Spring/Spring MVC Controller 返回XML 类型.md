Spring MVC Controller 返回XML 类型
------------------------------

```
@PostMapping(value = "/login",produces = MediaType.APPLICATION_XML_VALUE)
public @ResponseBody LoginXmlReturnView login(@RequestBody LoginForm loginForm){
    return new LoginXmlReturnView();
}


@XmlRootElement(name = "details") // 默认的xml 的标签是类名，配置name 可以修改标签名， 同理子标签也可以配置修改。
public class LoginXmlReturnView {

    @XmlElement(name = "test")
    private String LoginResult;

    private String ErrorMessage;

    // 其他参数 和 Get Set 方法

}

```