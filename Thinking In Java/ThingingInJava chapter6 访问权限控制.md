## ThinkInJava Chapter6 访问权限控制

重构代码可以使得代码更可读，更易理解，更具可维护性。
但是代码的消费者（客户端程序员）需要类库（library）的代码在某些方面保持不变，如果类库更新了，消费者不需要改写代码。另一方面，类库的开发者必须有权限进行修改，并确保客户代码不会因此改动而受影响。

Java提供了访问权限修饰词，以供类库开发人员向客户端程序员指明哪些是可用，哪些不可用。访问权限控制的等级，从最大到最小为：`public`，`protected`，包访问权限（默认访问权限），`private`。
另外，`package`关键字，对访问权限加以控制，修饰词会因类是存在于相同的包还是存在于一个单独的包而受到影响。

### 1 包：库单元

在java.util名字空间下，有一个ArrayList的类，要使用这个类，可用全名来指定:
```
java.util.ArrayList list = new java.util.ArrayList();
```
这使得程序变得冗长，`import`关键字可用来导入单个类
```
import java.util.ArrayList;

//使用
ArrayList list = new ArrayList();

```
当要导入util包下的其他类时，可以这样使用
```
//使用 *
import java.util.*;
```

之所以要导入，就是要提供一个管理名字空间（即包）的机制，所有的类成员名称彼此隔离。如果设计的类名与其他的类库中的类名相同，那么这种名字的冲突，就由java中的名字空间进行控制。名字空间为类创建唯一标识符。


#### 1.1 代码组织

`package`关键字必须是除注释外第一句程序代码，表明你在声明该编译单位的位于哪个package（包）下。包的命名规则全部使用小写字母。


#### 独一无二的包名
创建的包名例如：com.aaa.bbb， package名分解为你机器上的一个目录，所以当java程序运行并且需要加载.class文件时，它就可以确定.class文件在目录上所处的位置。
java解释器的运行过程如下：首先，找到环境变量CLASSPATH，CLASSPATH包含一个或多个目录，用作查找.class文件的根目录。从根目录开始，解释器获取包的名称并将每个句点替换成反斜杆，以从CLASSPATH根中产生一个路径名称（com.aaa.bbb 会变成 com/aaa/bbb 或 com\aaa\bbb 或其他，取决于操作系统）。得到的路径会与CLASSPATH中的各个不同项相连接，解释器就在这些目录中查找与你要创建的类名称相关的.class文件。（解释器还会去查找某些设计java解释器所在位置的标准目录）。
CLASSPATH 可以包含多个可供选择的查询路径，例如你的package放在D:\java\ ，你的类路径是：D;\java\com\aaa\bbb\Test.java 。
你可以在CLASSPATH加上你的包根路径，D:\java\ 。但是使用jar包时，必须在类路径中jar文件的实际名称写清楚，因此，对于一个名为test.jar的jar文件。类路径应该是：D:\java\test.jar 。

如果将两个含有相同类库以 * 的形式导入：
```
//两者都包括类 List ...
import net.mideview.simple.*;
import java.util.*;

```
那么就存在潜在的冲突，但是如果你不写哪些导致冲突的代码，就不会有什么问题，即不使用冲突的类。否则当你使用冲突的类时，编译器就需要你指明。
```
java.util.List list = new java.util.List();
```
由于这样完全指明了List类的位置（配合CLASSPATH），所以排除还要使用java.util中的其他东西，否则就没有必要写`import java.util.*;`
或者，可以使用单个类导入的形式来防止冲突，只要你在用一个程序中没有使用有冲突的名字。`import java.util.List;`
```
package com.andy.chapter6;

public class ArrayList implements List {
}

---------------------------------------
package com.andy.chapter6;

public class ArrayList implements List {
}

---------------------------------------
package com.andy.chapter6;

import com.andy.chapter6.*;
import java.util.*;

public class ListTest {
    public static void main(String[] args) {
        List l = new ArrayList();
        java.util.List list = new java.util.ArrayList(); //编译器会强制你这样使用
    }
}

```

### 2 Java访问权限修饰词

访问权限表：

| 修饰符 | 类内部 | 同包 |子类 | 任何地方
| --- |
|private|YES|NO|NO|NO
|默认|YES|YES|NO|NO
|protected|YES|YES|YES|NO
|public|YES|YES|YES|YES


public、protected、private这几个访问修饰词在使用的时，是置于类中每个成员的定义之前——无论它是域还是方法。每个访问修饰词仅控制它所修饰的特定定义的访问权。如果不添加访问修饰词，则意味它是“包访问权限”。




#### 2.1 包访问权限
默认访问权限没有关键字，但通常是指包访问权限。这意味着当前包中的所有其他类对哪个成员都有访问权限，但对这个包之外的所有类，这个成员是private。由于一个编译单元（即一个文件），只能隶属于一个包，所以经由包访问权限，处于同一编译单元的所有类之间都是自动可访问的。
类控制着哪些代码有权访问自己的成员。
取得对某成员的访问权的途径：
1. 使成员成为 public
2. protected ，子类可访问
3. 默认权限，给予包访问权限
4. 提供get、set方法访问。

#### public 接口访问权限
使用pubic 关键字，就意味着修饰的成员对每个人都是可用的，尤其是使用类库的程序员。

#### private 访问权限

private关键字修饰的成员，除了包含该成员的类之外，其他类都无法访问这个成员。
类库使用者是无法访问包访问权限修饰的成员的。通常需要考虑的是哪些成员想要公开，从而声明为public 。 
private 可以控制其他类不能通过构造器创建对象。
```
class Sundae {
	private Sundae() { }

	static Sundae makeASundae() ｛
		return new Sundae();
	｝
}

public class IceCream ｛
	public static void main(String[] args) {
		// can not use  new Sundae
		Sundae s = Sundae.makeASundae();
	}
}

```

任何作为该类“助手”方法的方法，都可以指定为private，以确保包内其他地方不会误用到。
除非必须公开底层实现，否则就应该把所有的域都指定为private。

#### protected 继承访问权限

protected 在父类中修饰的成员，继承此父类的子类可以访问这些成员，同时 protected 还提供包访问权限，也就是说，相同包内的其他类也可以访问protected 元素。


### 3 接口和实现 
访问权限的控制常被称为是 具体实现的隐藏。 把数据和方法包装进类，以及具体实现的隐藏，常共同被称为 封装。其结果是一个同时带有特征和行为的数据类型。
权限控制可以对类库使用者可以使用和不可使用的代码划清界限。
也带来接口和实现的分离。
当类库使用者只能向public 接口发送消息，那类库设计者就能够随意修改内部实现（不是public的东西），而不会影响类库使用者。


### 4 类的访问权限
1. 每一个编译单元只能有一个public 类，这就表示每个编译单元都有单一的公共接口。
2. public 类的名称必须完全与含有该编译单元的文件名相匹配，包括大小写。
3. 编译单元内不带public 类也是可以的。这样可以随意对文件命名，但是这样不利于阅读和维护代码。

类不可以是private ， protected的。所以对于类的访问权限只有包访问权限或public。
在创建一个包访问权限的类时，把类的域声明为private 的才有意义。但是通常，包访问权限的类的方法是包访问权限的。

如果你不希望其他人对该类有访问权限，可以把所有构造器指定为private，从而阻止其他人创建该类对象，但是你可以在该类的static成员内部创建。
```
class Soup {
	private Soup() { }
	
	public static Soup makeSoup() {
		return new Soup();  // 返回一个对Soup对象的引用
	}
}

class Soup1 {
	private Soup1(){ }
	
	private static Soup1 soup1 = new Soup1();
	//简单的单例模式
	public static Soup1 makeSoup() {
		return soup1;
	}
	
}
```
如果想要在返回对象引用之前在Soup上做一些额外的操作，或者想要记录到底创建了多少个Soup 的引用，那么这种做法很有效。

如果没有为类指定访问权限，则默认是包访问权限，如果此时类的构造器不是 `private` ，这就意味着该类的对象实例可以由包内任何类创建，但在包外不行。（相同目录下的所有不明确package声明的文件，都被视作是该目录下默认包的一部分）。  
然而，如果该类的某个static成员是public的话，客户端成员仍然可以调用该static成员，尽管他们不能创建该类的对象。

### 总结
控制对成员的访问权限有两个原因
1. 为了使用户不触碰他们不该触碰的部分，这些部分对于类内部操作是必要的，但是它们不属于客户端程序员所需接口的部分。因此可以简化他们对类的理解，清楚地看到什么对他们是重要的，什么是可以忽略的。
2. 为了让类库设计者可以更改类内部工作方式，而不会对客户端程序员有重大影响。




