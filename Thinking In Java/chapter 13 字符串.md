# chapter 13 字符串
## 1 不可变 String
String 对象是不可变的，String类中每一个看起来会修改 String 值的方法，实际上都是创建了一个全新的 String 对象，以包含修改后的字符串内容。

每当把String 对象作为方法的参数时，都会复制一份引用，而该引用所指的对象其实一直待在单一的物理位置上，从未动过。

## 2 重载 "+" 与 StringBuilder
String 对象具有只读特性，指向它的任何引用都不能改变它的值。

重载的意思是，一个操作符在引用于特定的类时，被赋予了特殊的意义。（用于 String 的 "+" ，"+=" 是 Java 中仅有的两个重载过的操作符，Java中不允许程序员重载操作符）

当你使用重载符"+" 时，编译器创建了一个 StringBuilder 对象，用以构造器最终的String，并为每个字符串调用一次 StringBuilder 的 append 方法。


当需要循环对 String 对象做添加的动作时，在性能方面上会有些不同。

```
    String f(String[] fields){
        String result = "";
        for (String field : fields) {
            result += field;
        }
        return result;
    }

    String g(String[] fields){
        StringBuilder result = new StringBuilder();
        for (String field : fields) {
            result.append(field);
        }
        return result.toString();
    }
```
第一种方式会在每一次循环内都创建一个 StringBuilder对象。
第二种方式是只生成一个 StringBuilder 对象。

StringBuilder 提供了丰富而全面的操作String 的方法。
在Java SE5 前使用的是 StringBuffer ，是线程安全的，因此开销也会大些。

## 3 无意识的递归
当你希望打印出对象的地址时，可能在 toString 方法中使用 this 关键字，
```
public String toString () {
	return "address : "+ this + "\n";
}
// 调用 对象的 toString 方法 或者 使用 System.out.print();
```
这里发生了自动类型转换，由原来的对象转换成String对象 `String.valueOf(obj)` ，然后由于String 后面还跟着一个 "+" 而后面的对象不是 String ，于是编译器试着将 this 转换成一个 String，它怎么转换呢，正是通过调用 this.toString() ，于是发生了递归调用。最终会栈溢出报错 `StackOverflowError` 。
所以要打印对象的内存地址，应该使用 Object.toString() 方法，这才是负责此任务的方法，即使用 super.toString() 而不是使 this。

## 4 String的操作
当需要改变字符串内容时， String 类的方法都会返回一个新的String 对象。 同时如果内容没发生改变，String 的方法只是返回指向原对象的引用而已。这可以节约存储空间以及避免额外的开销。

## 5 格式化输出 

## 6 正则表达式

### 1 基础
正则表达式是以某种方式描述字符串。因此你可以说，如果一个字符串包含这些东西，那么它就是我正在找的东西。
例如，要找一个数字，它可能有一个负号在最前面，那你就写一个负号加上一个问号：  `-?`.

要描述一个整数，你可以说它有一位或多位阿拉伯数字。在正则表达式中，` \d` 表示一位数字。

在其他语言中，` \\ `表示”我想要在正则表达式中插入一个普通的（字面上的）反斜杠，请不要给它任何特殊意义“。
而在java 中，`\\` 表示”我要插入一个正则表达式的反斜杆，所以其后的字符具有特殊意义“。
例如，如果你想要表示一位数字，那么正则表达式是 `\\d` ，如果你像插入一个普通的反斜杆，则应该是 `\\` 。不过换行和制表符之类的只需要单反斜线` \n , \t` 。

要表示一个或多个之前的表达式，应该使用 + 。所以如果要表示”有一个负号跟着一位或多位数字“，则可以这样写：`-?\\d+`

应用正则表达式最简单的途径就是利用 String 类内建的功能
- String.match()
 `String.match("")`  ，例如：
```
 "-123".match("-?\\d+") ;
 "+911".match("(-|\\+)?\\d+");
```
描述 可能以一个加号或减号开头。在正则表达式中，括号有这将表达式分组的效果，竖直线 `|` 表示或操作，因此可以用 `(-|\\+)?` 
这个正则表达式表示字符串的起始字符可能是一个 - 或 + 或两者都没有，因为字符 + 在正则中要特殊意义，所以需要使用 `\\` 将其转义，使之成为一个普通字符。

- `String` 类的 `split()` 方法，是将字符串从正则表达式匹配的地方切开成一个数组。
```
String.split(" "); //按空格划分字符串
String.split("\\W+"); //  \W 意思是非单词字符，即以非单词字符划分
String.split("n\\W+"); // 字母 n 后面跟着一个或多个非单词字符
```
在正则中， `\W` 表示非单词字符，如果是` \w` 小写的w 则表示一个单词字符。

- `String` 的 `replace` 和 `replaceAll` 方法，用于替换字符串。
`String.replace("f\\w+","located");`  把字符中以 `f`  开头，后面跟着一个或多个字母的，替换成 `located` 这个字符 ，并且值替换第一个匹配的部分。


### 6.2 创建正则表达式

 
    


