1. -DskipTests，不执行测试用例，但编译测试用例类生成相应的class文件至target/test-classes下  

2. -Dmaven.test.skip=true，不执行测试用例，也不编译测试用例类  
  
3. profile
mvn package –PprofileId

4. 设置 maven 项目jdk编译版本
```
<properties>
    <maven.compiler.source>1.8</maven.compiler.source>
    <maven.compiler.target>1.8</maven.compiler.target>
</properties>
```
