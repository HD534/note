https://robotframework.org/

### Use plugin to run robot in maven project, see 
https://robotframework.org/MavenPlugin/run-mojo.html

### maven dependency
```
<plugin>
    <groupId>org.robotframework</groupId>
    <artifactId>robotframework-maven-plugin</artifactId>
    <version>1.4.6</version>
    <configuration>
        <libdoc></libdoc>
        <testdoc></testdoc>
        <extraPathDirectories>
            <extraPathDirectory>target/test-classes</extraPathDirectory>
            <extraPathDirectory>target/classes</extraPathDirectory>
        </extraPathDirectories>
        <externalRunner>
            <jvmArgs>
                <jvmArg>-Dwebdriver.chrome.driver=${basedir}\drivers\chromedriver.exe</jvmArg>
                <!--<jvmArg>-Dphantomjs.binary.path=${basedir}\drivers\phantomjs.exe</jvmArg>-->
                <jvmArg>-Xmx1024m</jvmArg>
                <jvmArg>-Dfile.encoding=UTF8</jvmArg>
                <jvmArg>-client</jvmArg>
            </jvmArgs>
        </externalRunner>

        <testCasesDirectory>src/test/cases/</testCasesDirectory>
        <debugFile>${project.build.directory}/robotframeworkreports/robot_debug.log</debugFile>

        <listener>com.demo.selenium.util.RobotListener</listener>
        <logLevel>DEBUG</logLevel>
    </configuration>

</plugin>

```

### command usage
Robot framework  maven config
Maven command Run 
https://robotframework.org/MavenPlugin/run-mojo.html

In maven pom file  or maven command, exclude case should be use like below:

`-Dexcludes=tag1,tag2,`
The  comma in the end of the command can be include or not.

Or: 
`robotframework:run -Dincludes=TC001,TC002,TC003,TC004`


Robot run variables, see 
https://robot-framework.readthedocs.io/en/2.9.2/_modules/robot/run.html

reference,
https://github.com/robotframework/robotframework/issues/2087#issuecomment-148559931

Pass case,
http://robotframework.org/robotframework/latest/libraries/BuiltIn.html#Length%20Should%20Be

### robot file usage
1. In maven project, you can config robot file location in robot plugin like
`<testCasesDirectory>src/test/cases/</testCasesDirectory>`

2. Use numeric naming to sort `.robot` files so that you can control the order in which test cases run, such as,
    ```
    01_login.robot
    02_logout.robot
    ...
    ```

3. `__init__.robot`
http://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#id555
    - View `__init__.robot` in the same directory as the current file
    - And you can have a file to do thing for each test suit 

4. can have a `common_resource.robot` to control each test case
    - View `common_resource.robot` in the same directory as the current file 
    - Config the test setup and teardown, and the resource file is another file that have the setup and teardown detail info.  
    - The Library should include the test cases and  the keywords'  Java class


### Setting criticality

From <http://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#id717> 


The final result of test execution is determined based on critical tests. 
If a single critical test fails, the whole test run is considered failed. 
On the other hand, non-critical test cases can fail and the overall status is still considered passed.

All test cases are considered critical by default