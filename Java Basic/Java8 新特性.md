# JAVA 8 新特性 #
----
## 1. Lambda 表达式 ##

Lambda表达式在Scala中已经很流行了。在Java中，Lambda表达式（或者Function）只是一个匿名方法，ie：一个方法没有方法名也没有绑定标识符。只是写在他们需要用到的地方，一般用在作为其他方法的一个参数。

基本的Lambda表达式语法如下：
```
either
(parameters) -> expression
or
(parameters) -> { statements; }
or
() -> expression
```

一个典型的Lambda表达式：
```
(x, y) -> x + y    //把两个参数加起来并返回值
```

要注意的地方是，x和y的类型在不同的调用场合可能会是不同的，x和y的类型可以是int，Integer或者String等等。

### Lambda表达式的规则 
1. 一个lambda表达式可以用一个或多个参数
2. 参数类型可以明确声明或者通过上下文推断
3. 多个参数必须用括弧包起来，参数之间用逗号隔开。括弧中可以没有参数
4. 当只有一个参数时，如果类型是推断的，则可以不用加括弧，例如：
`a -> return a*a`
5. lambda表达式的方法体内可以有多句代码，也可以没有代码
6. 如果方法体内只有单句代码，可以不加大括即 ：{} ，而且匿名方法的返回类型类型就是这单句的返回类型。当有超过一句代码时，大括号是必须的

## 2. 函数式接口 Functional Interface ##
Functional interfaces are also called Single Abstract Method interfaces (SAM Interfaces).  
函数式接口也被称为单一抽象方法接口。有名字可以看出，函数式接口里面有且只有一个抽象函数。Java8 中采用了一个注解：` @FunctionalInterface` ，当你注释的接口违反函数式接口的规定时，会有编译错误。  
函数式接口例子：
```
@FunctionalInterface
public interface MyFirstFunctionalInterface {
    public void firstWork();
}
```

需要注意的是，一个函数式接口即使没有加上`@FunctionalInterface`的注解，也是有效的。 这个注解只是为了引起编译器检查加上此注解的接口是否是单一抽象方法的。  
同时，由于default的方法不是抽象方法，所以你可以在函数式接口中添加default的方法。  
还有一点就是，如果一个接口声明了继承自`java.lang.Object`的方法，也不会被当作是接口的抽象方法，因为接口的任何实现都将具有`java.lang.Object`或其他地方的实现。以下是一个函数式接口的例子：
```
@FunctionalInterface
public interface MyFirstFunctionalInterface
{
    public void firstWork();
 
    @Override
    public String toString();                //从 Object 重写的方法
 
    @Override
    public boolean equals(Object obj);    //从 Object 重写的方法

}
```
Functionnal Interface 在使用lambda 表达式时，可以简化为以下用法：
```
new Thread(
            () ->   {
                        System.out.println("My Runnable");
                    }
         ).start();

```

Statement lambda can be replaced with expression lambda，也就是说这种语句式的lambda 可以被表达式lambda代替。
可以去掉花括号和语句后的分号。
```
new Thread(
        () ->
     	 	System.out.println("")
        ).start();
```
Runnable 是一个 Functinonal Interface
之前的写法：
```
new Thread(new Runnable() {
    @Override
    public void run() {
        System.out.println("howtodoinjava");
    }
}).start();
```

## 3. Default Methods  默认方法
Java8 允许在接口中添加非抽象方法。 这是方法必须声明为默认方法(default)。默认方法使你可以向库的接口添加新功能，也能确保与为这些接口的旧版本编写的代码的二进制兼容性。
看一下例子：
```
public interface I1 {
    default void f(){
        System.out.println("call f in "+this.getClass().getName());
    }
}
```

接下来的的实现类可以重写或者不重写这个方法。
```
public class K1 implements I1 {
    public static void main(String[] args) {
        K1 k1 = new K1();
        k1.f();
    }
    //override or do not need to  override just call the default method in I1.
    @Override
    public void f() {
		
    }
}
```

## 4.  Java 8 Streams ##
Java8 的一个主要改变是加入**Java 8 Streams API**，这个API提供了一个可以多种方式处理数据集的机制，包括过滤，转换以及其他好用的方法。  
Stream支持不同类型的迭代，你只需定义要处理的数据集、对数据集中的数据要执行的操作、以及这些操作输出的结果是什么。
Stream的具体使用可以参考另外一篇记录。

## 5. Java 8 Date/Time API 的改变 ##
JSR-310（Java Specification Requests）中新的Date和Time的API，会改变你在应用中处理date的方式。

### Dates ###
`Date`类已经开始变得过时了，新加入的类`LocalDate, LocalTime, LocalDateTime`是用来取代`Date`类的。
1. `LocalDate ` 　　表示一个date，没有时间或时区的表示。
2. `LocalTime ` 　　表示一个time，没有日期或时区的表示。
3. `LocalDateTime `   表示 一个date和time，没有时区的表示。

如果要将日期功能与时区信息一起使用，lambda提供了额外三个跟上面相似的类：`OffsetDate, OffsetTime, OffsetDateTime`，时区的偏移量可以用“+05:30” 或“Europe/Paris”的格式来表示，这需要另外一个类来帮助实现`ZoneId`。
```
LocalDate localDate = LocalDate.now();
LocalTime localTime = LocalTime.of(12, 20);
LocalDateTime localDateTime = LocalDateTime.now();
OffsetDateTime offsetDateTime = OffsetDateTime.now();
ZonedDateTime zonedDateTime = ZonedDateTime.now(ZoneId.of("Europe/Paris"));
```
### Timestamp and Duration ###
为了表示一个特定时刻的时间戳，需要使用`Instant`这个类。 `Instant`表示一个时间精确到纳秒的时刻。Instant的操作包括比较两个Instant，添加或减去一个持续时间。
```
Instant instant = Instant.now();
Instant instant1 = instant.plus(Duration.ofMillis(5000));
Instant instant2 = instant.minus(Duration.ofMillis(5000));
Instant instant3 = instant.minusSeconds(10);
```

`Duration` 是一个引入Java的新概念，用来表示两个时间戳的时间差。
```
Duration duration = Duration.ofMillis(5000);
duration = Duration.ofSeconds(60);
duration = Duration.ofMinutes(10);
```

`Duration` 处理小的时间单元，例如毫秒，秒，分，小时。它们更适合与应用程序代码交互。为了与人交互，需要获得更大的持续时间（Duration)，这些持续时间用`Period`类表示。
```
Period period = Period.ofDays(6);
period = Period.ofMonths(6);
period = Period.between(LocalDate.now(), LocalDate.now().plusDays(60));
```


https://stackoverflow.com/questions/1005523/how-to-add-one-day-to-a-date
https://stackoverflow.com/questions/56568762/issue-with-parsing-localdate-to-date-in-java
https://stackoverflow.com/questions/22929237/convert-java-time-localdate-into-java-util-date-type

