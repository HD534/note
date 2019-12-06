##IOC Container  
- resource 可以使用相对路径但不推荐
- 使用 ../ 会让application 依赖在其之外的文件。
- 使用 classpath:../ , 运行时解析过程中会选择 the “nearest” classpath root，然后查看其父目录。
类路径配置的更改可能导致选择其他错误的目录
- 使用完全限定的资源位置来代替相对路径：例如，file：C：/config/services.xml或classpath：/config/services.xml, 但是应用程序的配置将耦合到特定的绝对位置
- 通常最好为这样的绝对位置保留一个间接寻址，例如通过在运行时针对JVM系统属性解析的“ $ {…}”占位符， 通过 JVM 传递参数。

