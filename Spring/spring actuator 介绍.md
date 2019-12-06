# spring actuator#
官方文档：[Spring Boot Actuator](https://docs.spring.io/spring-boot/docs/2.0.7.RELEASE/reference/htmlsingle/#production-ready)

maven项目配置：
添加依赖
```
<dependency>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-actuator</artifactId>
</dependency>
```
在项目的application.yml 里面配置
具体配置参考：
[https://docs.spring.io/spring-boot/docs/2.0.7.RELEASE/reference/htmlsingle/#production-ready-endpoints-enabling-endpoints](https://docs.spring.io/spring-boot/docs/2.0.7.RELEASE/reference/htmlsingle/#production-ready-endpoints-enabling-endpoints)

```
management:
  endpoints:
    web:
      exposure:
        include: "*"  #暴露所有接口
  endpoint:
    shutdown.enabled: true  #允许shutdown
    health.show-details: always #展示详细的health信息
    jolokia:
      enabled: false #允许 jolokia
      config.debug: true
 
  security:
    enabled: true #开启security

```
添加 security
```
 <dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-security</artifactId>
</dependency>
```
对url进行拦截
允许swagger 的 url
除了 /actuator/health，/actuator/info，其他endpoint都需要权限验证。
权限验证是简单的basic auth（base 64）。
Note: 使用post man 发送请求。

```
@EnableWebSecurity
public class WebSecurityConfig {

    @Configuration
    @Order(1)
    public static class FormLoginWebSecurityConfigurerAdapter extends WebSecurityConfigurerAdapter {
        @Override
        protected void configure(HttpSecurity http) throws Exception {
            http.csrf().disable()
                    .authorizeRequests()
                    //for swagger UI, just by pass security checking.
                    .antMatchers("/swagger-ui.html",
                            "/swagger-resources",
                            "/swagger-resources/**/*",
                            "/webjars/**/*",
                            "/v2/api-docs").permitAll()
                    //for all url start with /pub(for public endpoint), by pass security checking.
                    .antMatchers("/actuator/health","/actuator/info").permitAll()
                    .antMatchers("/actuator/*").hasAnyRole("ADMIN")
                    //for all other endpoints, cannot access until authenticated.
                    //if you want to disable the checking for development, please change it to permitAll().
                   // .anyRequest().permitAll()
                    .and().httpBasic()
            ;
        }


        @Override
        public void configure(AuthenticationManagerBuilder auth) throws Exception {
            auth.inMemoryAuthentication().withUser("abc").password("def").roles("ADMIN")
                    .and().passwordEncoder(new PasswordEncoder() {
                @Override
                public String encode(CharSequence rawPassword) {

                    return rawPassword.toString();
                }

                @Override
                public boolean matches(CharSequence rawPassword, String encodedPassword) {
                    return rawPassword.toString().equals(encodedPassword);
                }
            });

        }
    }

}
```


- 添加 jolokia
```
<dependency>
    <groupId>org.jolokia</groupId>
    <artifactId>jolokia-core</artifactId>
</dependency>
```
可以在actuator里面展示jolokia的信息。

- actuator 默认展示自动配置的data source的信息，因为spring boot默认使用HikariCP的连接池，所以在actuator的metrics里面会有以hikari开头的一些信息。自动配置的数据源可以是以java形式配置的。
也可以使用以下的形式将数据源加入在metrics中：
```
    @Bean
    @ConfigurationProperties("properties")
    public DataSource DataSource1() {

	  DataSource dataSource = DataSourceBuilder.create().build();
        new DataSourcePoolMetrics(dataSource,
                val->new HikariDataSourcePoolMetadata((HikariDataSource) dataSource),
                "data source name",
                Tags.empty())
                .bindTo(meterRegistry);

        return dataSource;

    }
```

