# Chapter 10 内部类 #
可将一个类的定义放在另一个类的定义内部，这就是内部类。
内部类可以把一些逻辑相关的类组织在一起，并控制内部类的可视性，内部类与组合是完全不同的概念。

## 1 创建内部类 ##
如果想从**外部类**的**非静态方法**之外的任意位置创建某个内部类的对象，那么就必须指明对象的类型：OuterClassName.InnerClassName
外部类将有一个方法可以返回一个指向内部类的引用。
```
public class Outer {

    public class Inner{

    }

    Inner inner(){
       return new Inner();
    }

    public static void main(String[] args) {
        Outer outer = new Outer();
        Outer.Inner inner = outer.inner();
        // can not new Inner();
        //Inner is not static so it requires an instance of the outer class.
    }

}
```
## 2 链接到外部类 ##
当生成一个内部类对象时，此对象与制造它的外围对象（enclose onject） 之间就有了一种联系，内部类对象可以访问外部类对象的所有成员，而不需要任何特殊条件。此外，内部类还有外部类所有元素的访问权。
```
public class Outer1 {
    
    private int i;
    
    private void f(){
        
    }
    
    private class Inner{
        void g() {
            System.out.println(i);
            f();
        }
    } 
    
}

```
内部类可以访问它的外部类的方法和字段，当外部类对象创建了一个内部类对象时，此内部类必定会捕获一个指向那个外部类的引用，然后在内部类访问此外部类成员时，就是用那个引用来选择外部类的成员。当内部类是非 `static` 类的时候，创建内部类对象总是需要一个指向它的外部类的引用。

## 3 使用 .this 和 .new  
如果你需要生成对外部类的引用，可以使用外部类的名字和 `.this`，这样产生的引用就自动具有正确的类型。这一点在编译期间就被知晓并检查，所以没有运行时的开销。
```
public class DotThis {
    
    class Inner{

        DotThis outer(){
            return DotThis.this;
        }

        Inner inner(){
            return this;
        }
    }
    
    DotThis getThis(){
        return DotThis.this;
    }
    
    Inner getInner(){
        return new Inner();
    }
    
}
```
有时候想直接创建内部类，那么可以使用外部类对象的引用，加上 `.new Inner()` 。因为内部类会连接到它的外部类对象上。

```
public static void main(String[] args) {
        DotThis dotThis = new DotThis();
        DotThis.Inner inner = dotThis.new Inner();
    }
```
如果创建的是嵌套类（静态内部类），那么它就不需要对外部类的引用，而只是一个普通的静态类。
```
public class OuterWithStaticInner {

    private int i;

    private static void f(){}

    void g(){}

    static class Inner{

        void f(){
            OuterWithStaticInner.f();
        }

    }

    public static void main(String[] args) {
        Inner inner = new Inner();
    }

}
```

## 4 内部类与向上转型

```
class A{
}

class B extends A{
}

interface I{
}

class B1 implememnts I{
}

A a = new B();
I i = new B1();
//效果是一样的
```
内部类用在向上转型为其基类或接口时很有用。因为内部类对某个接口的实现可以被隐藏在类内部而只是得到指向基类或接口的引用。
```
public interface Destination {
    String readLabel();
}

public interface Contents {
    int value();
}


public class Parcel {
    private class PContent implements Contents {
        private int i = 11;
        @Override
        public int value() {
            return i;
        }
        private void g(){
        }
    }

    protected class PDestination implements Destination{

        private String label;

        public PDestination(String whereTo) {
            this.label = whereTo;
        }

        @Override
        public String readLabel() {
            return label;
        }
    }

    public Destination destination(String s){
        return new PDestination(s);
    }

    public Contents contents(){
        return new PContent();
    }

    // can access private field in inner class.
    void f(){
        PContent pContent = new PContent();
        System.out.println(pContent.i);
        pContent.g();
    }	
}

public class TestParcel {

    public static void main(String[] args) {
        Parcel parcel = new Parcel();
        Contents contents = parcel.contents();
        Destination destination = parcel.destination("GZ");
        //parcel.new PContent();  //can not new private inner class, 
    }
}
```
内部类PContents 是 private 的， 所以除了 Parcel ，其他类都不能访问， PDestination 是 protected ，所以只有 Parcel 及其子类还有同包的类可以访问。所以在TestParcel 中不能访问PContents。 private 内部类可以隐藏内部实现的细节，通过这种方式可以完全阻止任何依赖于类型的编码。而客户端程序员由于不能访问任何新增加的、不属于公共接口的方法，所以也无法扩展接口。这也给Java编译器提供生成更高效代码的机会。

## 5 在方法和作用域内的内部类
如果内部类的语法覆盖了大量的技术，例如在方法或者方法的任意作用域内定义内部类，那么有几个理由：
1.	 实现了某类型的接口，于是创建并返回对其的引用。
2.	 要解决一个复杂的问题需要借助一个类，但是又不希望此类是公共可用的。

- 1 定义在方法中的类

```
public class MethodParcel {

    public Destination destination(String s){
        class PDestination implements Destination{
            private String label;

            public PDestination(String label) {
                this.label = label;
            }

            @Override
            public String readLabel() {
                return label;
            }
        }
        return new PDestination(s);
    }

    public static void main(String[] args) {
        MethodParcel methodParcel = new MethodParcel();
        Destination destination = methodParcel.destination("des");
    }

}
```
方法中的类只是方法的一部分，所以在方法外部不能访问，在return 语句中的向上转型，返回的是接口。这样你可用在同一目录下的任意类中对某个内部类使用重复的类标识，并不会有命名冲突。

- 2 任意作用域嵌入类

```
public class MethodParcel1 {
    private void internalTracking(boolean b){
        if (b){
            class TrackingSlip{
                private String id;

                public TrackingSlip(String id) {
                    this.id = id;
                }
                
                String getSlip(){
                    return id;
                }
            }
            TrackingSlip trackingSlip = new TrackingSlip("s");
            trackingSlip.getSlip();
        }
    }
    
    public void track(){
        internalTracking(true);
    }

    public static void main(String[] args) {
        MethodParcel1 methodParcel1 = new MethodParcel1();
        methodParcel1.track();
    }
}
```
if 语句的作用域中的类，并不是该类的创建是有条件的，它其实与其他类一起编译过了。然而在定义此类的作用域外，即这个 if 语句外，它是不可用的。

## 6 匿名内部类
下面是一个匿名内部类的例子。返回值的生成与类的定义结合在一起，这个类是匿名的，没用名字。
```
public class AnonymousParcel {
    public Contents contents(){
        return new Contents() {
            @Override
            public int value() {
                return 0;
            }
        };
    }
    public static void main(String[] args) {
        AnonymousParcel anonymousParcel = new AnonymousParcel();
        Contents contents = anonymousParcel.contents();
    }
}

```
这个匿名内部类是下面形式的简化版
```
public class Parcel1 {
	class MyContens implements Content {
		public int value () { return 0; }
	}
	
	public Contents contents () { return new MyContent(); }
}
```
也可以传参给有参的匿名内部类的构造器
```
public class Parcel2 {
	public Warpping warpping (int x){
		return new Warpping(x){
			public int value () {
				return super.value() * 47;
			}
		};
	}

	public static void main(String[ ] args) {
		Parcel2 p = new Parcel2();
		p.warpping(10);
	}

}
```
在返回匿名内部类的语句末尾的分号是标记表达式的结束，与其他语句的分号一致。
```
public class Parcel9 {
    public Destination destination (final String dest){
        return new Destination() {
            private String label = dest;
            @Override
            public String readLabel() {
                return label;
            }
        };
    }

    public static void main(String[] args) {
        Parcel9 parcel9 = new Parcel9();
        System.out.println(parcel9.destination("123").readLabel());
    }
}
```
如果匿名内部类要使用一个外部对象， 那么编译器要求参数引用是 `final` 的。(在 Java 8 之后不需要 final )。

如果想做一些类似构造器的行为，那么可以使用 实力初始化 的方式，达到为匿名内部类创建一个构造器的效果。（匿名内部类不可能有命名构造器，因为它没有名字）
```
abstract class Base{
    public Base(int i){

    }
    public abstract void f();
}

public class AnonymousConstructor {
    public static Base getBase(int i){
        return new Base(i) {
            @Override
            public void f() {
                System.out.println("in anonymous class");
                        
            }
        };
    }

    public static void main(String[] args) {
        Base base = getBase(10);
        base.f();
    }
}
```
这样的形式中，参数i 不要求是final的，因为它是传给基类构造器，并不会在匿名内部类中使用。

```
public class Parcel10 {
    public Destination destination(String dest , float price){
        return new Destination() {
            private int cost ;
            {
                cost = Math.round(price);
                if (cost>100) System.out.println("cost over 100");
            }
            @Override
            public String readLabel() {
                return null;
            }
        };
    }
}

```
在实例初始化，即 `new Destination()` 中可以看到一段代码, 他们不能作为字典初始化的一部分动作来执行（即if语句）。所以对于匿名内部类而言，实例初始化的实际效果就是构造器。但不能重载实例初始化方法，所以仅有一个构造器。

匿名内部类既可以扩展类也可以实现接口，但是不能两者兼备，实现接口一次只能实现一个接口。

1. 工厂方法
在工厂模式中使用匿名内部类。

```
public class FactoryWithAnonymous {
    public static void main(String[] args) {
        serviceConsumer(Service1.factory);
        serviceConsumer(Service2.factory);
    }

    public static void serviceConsumer(ServiceFactory factory){
        Service service = factory.getService();
        service.f();
        service.g();
    }

}

interface Service{

    void f();
    void g();
}

interface ServiceFactory{
    Service getService();
}

class Service1 implements Service{
    private Service1(){}
    @Override
    public void f() {
    }

    @Override
    public void g() {
    }

    public static ServiceFactory factory =
            new ServiceFactory() {
                @Override
                public Service getService() {
                    return new Service1();
                }
            };
}

class Service2 implements Service{
    private Service2(){};
    @Override
    public void f() {
    }

    @Override
    public void g() {
    }

    //public static ServiceFactory factory1 = () -> new Service2(); //lambda
    public static ServiceFactory factory = Service2::new; //lambda
}
```
Service1 和 Service2 的构造器都可以是private 的，并且没有必要去创建工厂的具名类。另外也只需要单一的工厂对象，所以在本例中它被创建为 Service 中的 static 的域。

## 7 嵌套类
如果不需要内部类对象与外围类对象之间有联系，那么可以将内部类声明为 `static` 。这通常称为嵌套类。普通内部类对象隐式保存了一个指向创建它的外围类对象。
嵌套类意味着：
-  `static` 内部类，即嵌套类的创建不需要外围类对象
-  不能从嵌套类对象中访问非静态的外围类对象。

普通内部类的字段和方法只能放在类的外部层次上，所以普通内部类不能有 `static` 数据和字段，也不能包含嵌套类，但是嵌套类可以。
嵌套类没有特殊的 this 引用。

### 7.1 接口内部的类 ###
正常情况下不能在接口中放置代码，但嵌套类可以作为接口的一部分。在接口中的任何类都自动是public 和 static 的。因为类是 static 的，只是将嵌套类置于接口的命名空间中，这并不违反接口的规则。你甚至可以在内部类中实现其外围接口。
```
public interface Inter1 { 
	void f();

	class Test implememts Inter1 {
		public void f() {
			//....
		}
		public static void main (String[ ] args) {
			new Test.f();
		}
	}
}
```
如果想要创建某些公共代码，使得它们可以被某个接口的所有不同实现公用，那么可以使用接口的嵌套类。

### 7.2 从多层嵌套类中访问外部类的成员 ###
一个内部类被访问多少层并不重要，它能透明地访问所有它所嵌入的外围类的所有成员。
```
class MNA {
	private void f() {}

	class A {
		private g() {}

		public class B {
			void h() {
				f();
				g();
			}
		}
	}

	public static void main(String[ ] args) {
		MNA mna = new MNA();
		MNA.A mnaa = mna.new A();
		MNA.A.B mnaab = mnaa.new B():
		mnaab.h();
	} 
}
```
从上述例子可以看出，嵌套在最内部的类可以访问外围类的成员（即使是 `private` 的）。同时我们也看到如何使用 .new 的语法从不同的类中创建内部类对象， .new 语法能产生正确的作用域，所以不必在调用构造器时限定类名。

## 8 为什么使用内部类
一般来说内部类继承自某个类或实现某个接口，内部类的代码操作创建它的外围类对象。
如果能设计外围类接口来满足需求，那么就不需要设计内部类来实现接口。内部类的好处是 ：
> 每个内部类都能独立地继承自一个（接口的）实现，所以无论外围类是否继承了某个（接口的）实现，对于内部类都没有影响。
 
内部类使得多重继承的解决方案变得完整，接口解决了部分问题，而内部类有效地实现了“多重继承”。也就是说，内部类允许继承多个非接口类型（类或抽象类） 。
当你必须在一个类中以某种方式实现两个接口，你有两种选择：
```
public class MultiInterface {
    static void takeA(A a){}
    static void takeB(B b){}

    public static void main(String[] args) {
        X x = new X();
        Y y = new Y();
        takeA(x);
        takeA(y);
        takeB(x);
        takeB(y.makeB());
    }
}

interface A{}
interface B{}

class X implements A,B{}

class Y implements A{
    
    B makeB(){
        return new B() {};
    }
    
}
```
这两种方式都有逻辑意义且都能运行。然而当遇到问题时，通常问题本身就能给出某些指引，是使用单一的类还是使用内部类。

如果拥有的是抽象类或具象类而不是接口，那么就只有使用内部类实现多重继承。
```
public class MultiImplementation {
    static void takeD(D d){}
    static void takeE(E e){}

    public static void main(String[] args) {
        Z z = new Z();
        takeD(z);
        takeE(z.makeE());
    }
}

class D {}

abstract class E{}

class Z extends D{
    E makeE(){
        return new E() {};
    }
}
```
如果不需要解决多重继承的问题，那么就可以用别的方式编码，而不需要使用内部类。
使用内部类还可以获得其他一些特性：
1. 内部类可以有多个实例，每个实例都有自己的状态信息，并且与其外围类对象信息相互独立。
2. 在单个外围类中可以让多个内部类以不同的方式实现同一个接口，或继承同一个类。
3. 创建内部类对象的时刻并不依赖于外围类对象的创建。（创建外部类是内部类并没有创建）
4. 内部类没有令人疑惑的“is-a”关系，它是一个独立的实体。

### 8.1 闭包与回调 ###
闭包（closure） 是一个可调用的对象，它记录了一些信息，这些信息来自于创建它的作用域。
通过这个定义，可以看出内部类是面向对象的闭包，因为它不仅包含外围类对象（创建内部类的作用域）的信息，还自动拥有一个指向此外围类对象的引用。在此作用域内，内部类有权操作所有的成员，包括 private 成员。

通过回调（callback），对象能够携带一些信息，这些信息允许它在稍后的某个时刻调用初始的对象。
通过内部类提供闭包的功能是优良的解决方案。
```
interface Incrementable{
    void increment();
}
// 继承接口的简单实现
class Callee1 implements Incrementable{
    private int i = 0;

    @Override
    public void increment() {
        i++;
        System.out.println(i);
    }
}

class MyIncrement{
    public void increment(){
        System.out.println("Other operation");
    }
    static void f(MyIncrement mi){
        mi.increment();
    }

}

//由于父类已经有increment 方法并且不是用来实现 Incrementable接口的
// 所以需要一个内部类来实现接口并且返回
class Callee2 extends MyIncrement{
    private int i = 0;
    @Override
    public void increment() {
        super.increment();
        i++;
        System.out.println(i);
    }
    private class Closure implements Incrementable{
        @Override
        public void increment() {
            Callee2.this.increment();
        }
    }
    Incrementable getCallbackReference(){
        return new Closure();
    }
}

class Caller {
    private Incrementable callbackReference;
    Caller(Incrementable cbh){
        this.callbackReference = cbh;
    }
    void go(){
        callbackReference.increment();
    }
}

public class Callbacks {
    public static void main(String[] args) {
        Callee1 c1 = new Callee1();
        Callee2 c2 = new Callee2();
        MyIncrement.f(c2);
        Caller caller1 = new Caller(c1);
        Caller caller2 = new Caller(c2.getCallbackReference());
        caller1.go();
        caller1.go();
        MyIncrement.f(c2);
        MyIncrement.f(c2);
        caller2.go();
        caller2.go();
    }
}
```
内部类 `Closure` 实现了 `Incrementable` ， 以提供一个返回 `Caller2` 的 钩子（`hook`），而且是一个安全的钩子，无论谁获得此 `Increment` 的引用，都只能调用 i`ncrement()` ，除此之外没有其他功能。


### 8.2 内部类与控制框架
应用程序框架是被设计用以解决某特定问题的一个类或一组类。要运用某个框架，通常是继承一个或多个类，并覆盖某些方法，在覆盖后的方法中，编写代码定制框架提供的通用解决方案，以解决你的特定问题（这是设计模式中**模板方法**的一个例子）。
模板方法包含算法的基本结构，并且会调用一个或多个可覆盖的方法，以完成算法的动作。设计模式总是将变化的事物与不变的事物分离开，在这个模式中，**模板方法是保持不变的事物**，**可覆盖的方法就是变化的事物**。

控制框架是一类特殊的应用程序框架，它用来解决响应事件的需求。主要用来响应事件的系统被称作事件驱动系统。图形用户接口（GUI）几乎完全是事件驱动的系统。


## 9 内部类的继承 
因为内部类的构造器必须连接到指向其外围类对象的引用，所以在继承内部类时，问题在于那个指向外围类对象的“秘密”引用必须被初始化，而在类中不再存在可连接的默认对象。因此必须使用特殊的语法来说清它们之间的关联。
```
class WithInner{
    class Inner{}
}

public class InheritInner extends WithInner.Inner{
    InheritInner(WithInner withInner){
        withInner.super();
    }

    public static void main(String[] args) {
        WithInner withInner = new WithInner();
        InheritInner inheritInner = new InheritInner(withInner);
    }
}
```

可以看到 InheritInner 只继承内部类，而不是外围类，但是当要生成构造器时，默认的构造器并不算好，而且不能只是传递一个指向外围类对象的引用，此外，必须在构造器内使用如下语法：
**`enclosingClassReference.super()`  **， 这才提供了必要的引用，然后才能编译通过。

## 10 内部类可以被覆盖吗 
如果创建了一个内部类，然后继承其外围类并重新定义其此内部类，虽然看起来像是覆盖，但是实际上并不起作用。
```
class Egg{
    private Yolk yolk;
    protected class Yolk{
        public Yolk(){
            System.out.println("Egg.Yolk()");
        }
    }

    public Egg(){
        System.out.println("new Egg()");
        yolk = new Yolk();
    }
}

public class BigEgg extends Egg{
    public class Yolk{
        public Yolk(){
            System.out.println("BigEgg.Yolk()");
        }
    }

    public static void main(String[] args) {
        new BigEgg();
    }
}

---------
output: 
new Egg()
Egg.Yolk()
```
默认的构造器是编译器自动生成的，这里调用基类版本的默认构造器（即 `Egg()` ），虽然创建了`BigEgg` 对象，但是 `Egg` 中的 内部类 并不是 `BigEgg` 中的内部类。
内部类各自在自己的命名空间中，当继承了外围类时，“覆盖”的内部类跟外围类的内部类是两个独立的实体。当然你可以明确继承某个内部类。

## 11 局部内部类
可以在代码块中创建内部类，典型的方式是在一个方法体内创建，局部内部类不能有访问说明符，因为他不是外围类的一部分（只是方法体或代码块内），但是它可以访问当前代码块内的常量以及外围类的所有成员。
```
interface Counter {
    int next();
}

public class LocalInnerClass {
    private int count = 0;

    Counter getCounter(String name) {
        class LocalCounter implements Counter {
            public LocalCounter() {
                System.out.println("LocalCounter ");
            }

            @Override
            public int next() {
                System.out.print(name);
                return count++;
            }
        }
        return new LocalCounter();
    }

    Counter getCounter2(String name) {
        return new Counter() {
            {
                System.out.println("Counter()");
            }

            @Override
            public int next() {
                System.out.print(name);
                return count++;
            }
        };
    }

    public static void main(String[] args) {
        LocalInnerClass localInnerClass = new LocalInnerClass();
        Counter
                c1 = localInnerClass.getCounter("Local inner"),
                c2 = localInnerClass.getCounter2("Anonymous inner");
        for (int i = 0; i < 5; i++) {
            System.out.println(c1.next());
        }
        for (int i = 0; i < 5; i++) {
            System.out.println(c2.next());
        }
    }
}
```
Counter 接口有一个方法。使用局部内部类和匿名内部类实现了这个功能，它们具有相同的行为和能力。
既然局部内部类的名字在方法外是不可见的，那为什么使用局部内部类呢？如果需要一个已命名的构造器，或者需要重载构造器，那么就使用局部内部类来做，匿名内部类只能用于实例始化；还有一个理由就是，你需要创建多个该内部类对象。

## 12 内部类标识符
由于每个类都会产生一个 .class 文件，其中包含了如何创建该类型对象的全部信息（此信息产生一个 "meta-class"，叫做 Class 对象），内部类也必须生成一个 .class 文件以包含它们的 Class 对象信息。这些类文件有严格的命名规则：外围类的名字，加上 "$"，再加上内部类的名字。例如，`LocalInnerClass` 生成的 .class 文件包括：
> Counter.class
> LocalInnerClass$1.class
> LocalInnerClass$1LocalCounter.class
> LocalInnerClass.class

如果内部类是匿名的，编译器会简单地生成一个数字作为其标识符，如果内部类是嵌套在别的内部类之中，只需将它们的名字加在其外围类标识符与 "$" 之后。
虽然这种命名格式简单，但是足以应对绝大多数情况。因为这是 Java 标准命名方式，所以产生的文件都是平台无关的。

## 13 总结
接口和内部类等特性是相当直观的，但就像多态机制一样，这些特性的使用应该是设计阶段考虑的问题。