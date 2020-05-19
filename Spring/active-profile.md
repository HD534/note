###配置active 环境
在 application.yml 中配置
```
spring:
  profiles:
    active:@profileActive@
```

`@profileActive@` 是一个参数，可以在 `maven` 的 `pom` 中配置。
配置以下对应多个环境的 `profile`，可以在 `maven` 生命周期  `package` 通过 `profile` 参数 `-P sit` `profile id` 指定特定环境
```
<profiles>
    <profile>
        <id>dev</id>
        <activation>
            <activeByDefault>true</activeByDefault>
        </activation>
        <properties>
            <profileActive>dev</profileActive>
        </properties>
        <build>
            <resources>
                <resource>
                    <directory>src/main/resources</directory>
                    <excludes>
                        <!--  exclude the config file when package the application. -->
                        <exclude>sit/*</exclude>
                        <exclude>uat/*</exclude>
                        <exclude>application-sit.yml</exclude>
                        <exclude>application-uat.yml</exclude>
                    </excludes>
                    <filtering>true</filtering>
                </resource>
            </resources>
        </build>
    </profile>
    <profile>
        <id>sit</id>
        <properties>
            <profileActive>sit</profileActive>
        </properties>
        <build>
            <resources>
                <resource>
                    <directory>src/main/resources</directory>
                    <excludes>
                        <!--  exclude the config file when package the application. -->
                        <exclude>develop/*</exclude>
                        <exclude>application-dev.yml</exclude>
                        <exclude>uat/*</exclude>
                        <exclude>application-uat.yml</exclude>
                        <exclude>prod/*</exclude>
                        <exclude>application-prod.yml</exclude>
                    </excludes>
                    <filtering>true</filtering>
                </resource>
            </resources>
        </build>
    </profile>

    <profile>
        <id>uat</id>
        <properties>
            <profileActive>uat</profileActive>
        </properties>
        <build>
            <resources>
                <resource>
                    <directory>src/main/resources</directory>
                    <excludes>
                        <!--  exclude the config file when package the application. -->
                        <exclude>develop/*</exclude>
                        <exclude>application-dev.yml</exclude>
                        <exclude>sit/*</exclude>
                        <exclude>application-sit.yml</exclude>
                        <exclude>prod/*</exclude>
                        <exclude>application-prod.yml</exclude>
                    </excludes>
                    <filtering>true</filtering>
                </resource>
            </resources>
        </build>
    </profile>

    <profile>
        <id>prod</id>
        <properties>
            <profileActive>prod</profileActive>
        </properties>
        <build>
            <resources>
                <resource>
                    <directory>src/main/resources</directory>
                    <excludes>
                        <!--  exclude the config file when package the application. -->
                        <exclude>develop/*</exclude>
                        <exclude>application-dev.yml</exclude>
                        <exclude>sit/*</exclude>
                        <exclude>application-sit.yml</exclude>
                        <exclude>uat/*</exclude>
                        <exclude>application-uat.yml</exclude>
                    </excludes>
                    <filtering>true</filtering>
                </resource>
            </resources>
        </build>
    </profile>
</profiles>
```