# ThinkInJava Chapter7 复用类
在java中，问题的解决都是围绕类展开的，可以通过创建新类来复用代码，而不必重头开始编写，可以使用别人已经开发调试好的类。
此方法的窍门在于使用类而不破坏现有程序代码。有两种方法可以达到整个目的。
1. 组合：只需在新的类中创建现有类的对象，由于新的类是由现有类的对象组成的，所以这种方法叫做组合，这种方法只是复用了现有代码的功能，而非它的形式。
2. 继承：按照现有类的类型创建新类，无需改变现有类的形式，采用现有类的形式并在其中添加代码。


## 1 组合语法
组合是经常使用到的方法，只需将对象引用置于新类中。例如你需要某个对象，它具有多个String 对象，几个基本类型，和另外一个类的对象。
类中的域为基本类型时能够自动被初始化为零，对象引用被初始化为null ， 若试图调用null 的任何方法，都会得到一个运行时异常。在不抛异常的情况下，在toString 中仍然可以打印一个null。
编译器不是简单地为每一个引用都创建默认对象，想要初始化它们，可以在以下地方进行。
1. 在定义对象的地方，这意味着它们总是能在构造器调用之前初始化。
2. 在类的构造器中
3. 在要使用对象之前，即 惰性初始化。这样可以减少额外的负担。
4. 使用实例初始化。

```
public class Bath {
	private String s = "happy" //定义的时候初始化
	private int i;
	{i = 47;}  //实例初始化 
	private String s1;
	private String s2;
	public Bath (String s1) {
		this.s1 = s1; //在构造器初始化
	}
	
	public String toString () {
		if (null == s2) {
			s2 = "joy"  //惰性初始化
		}
		
		return "s = "s+" s1 = "+s1+" s2 = "+s2+" i = "+i;
	}
	
}

```

##2 继承语法
当创建一个类时，总是在继承，如果指定继承某个类，则都是隐式地继承javad的标准根类 Object
继承需要在类声明的左边花括号之前， 使用extends 关键字实现。当这样做，会自动得到基类中的所有域和方法。


几个小语法：
- 用 “+=”操作符将几个String对象连接成一个String，此操作符是被java设计者重载用以处理String的对象操作符之一，另一个是 “+”。
- 可以为每个类创建main方法，即使是一个程序中有多个类，也只有命令行调用的那个类的main方法会被调用。


- 继承的域是public 和 protected 的
- 使用基类定义的方法，以及对它的方法进行修改是可行的。使用 super关键字来调用基类版本的方法。
- 在子类中也可以添加新方法。
```
public class Child extends Base {

    public static void main(String[] args) {
        Base.main(args);
    }

    @Override
    public void f() {
        //... other code
        super.f();
    }
}
```

### 2.1 初始化基类
当创建一个子类的对象时，该对象还包含了一个基类的子对象。这个子对象与你用基类直接创建的对象是一样的。二者的区别在于，直接创建来自外部，而基类的子对象被包装在子类对象内部。

对基类子对象的初始化很重要，也仅有一种方法来保证：在构造器中调用基类构造器来执行初始化。而基类构造器具有执行基类初始化所需要的所有知识和能力。java会自动在子类的构造器中插入对基类构造器的调用。

构建过程是从基类“向外”扩散的，所以基类在子类构造器可以访问他之前就已经完成了初始化了。即使你不为子类创建构造器，编译器也会为你创建一个默认构造器，该构造器将调用基类构造器。
#### 带参构造器 ####
如果基类没有默认构造器，或者想要调用基类的带参构造器，那么就必须用关键字 super 来显示调用基类构造器。
```
public class Base {
    public Base(int i) {
        System.out.println("Base constructed");
    }
}

public class Child extends Base {
    public Child(int i) {
        super(i);  // super 必须在第一句
        System.out.println("Child constructed");
    }
}
```

##3 代理
第三种关系称为代理，java没有提供对它的直接支持，这是在继承与组合之间的中庸之道。因为我们将一个成员对象置于要构造的类中（例如组合），但与此同时我们在新类中暴露了该类成员对象的所有方法（就像继承）。例如：
太空船需要一个控制模块
```
public class SpaceShipControls {

    void up(){}

    void down(){}

    void left(){}

    void right(){}

}
```
构建太空船使用继承：
```
public class SpaceShip extends SpaceShipControls{

    public static void main(String[] args) {
        SpaceShip spaceShip = new SpaceShip();
        spaceShip.up();
    }
}
```
然而SpaceShip并非真正的SpaceShipControls类型，即便你可以让SpaceShip up。SpaceShip包含SpaceShipControls，与此同时，SpaceShipControls的所有方法都在SpaceShip中暴露出来。
使用代理可以解决这个问题：
```
public class SpaceShipDelegation {

    private final SpaceShipControls spaceShipControls = new SpaceShipControls();

    void up() {
        spaceShipControls.up();
    }

    void down() {
        spaceShipControls.down();
    }

    void left() {
        spaceShipControls.left();
    }

    void right() {
        spaceShipControls.right();
    }
}
```
使用代理可以有更多控制力，我们可以选择只提供成员对象（例如SpaceShipControls）的方法的某个子集。

## 4 结合使用组合和继承
同时使用组合和继承是很常见的。
使用组合和继承时，对于基类初始化，编译器会帮你默认初始化（当你有默认构造器时），或强制你初始化基类（当你只有带参构造器时）,并且在继承子类构造器的起始处就这么做。
但对于成员变量来说，你自己需时刻注意它们的初始化。
####4.1 确保正确清理
想要类清理一些东西，需要显式地编写特殊方法来做这件事，并确保客户端程序员知道这件事。
在清理方法中，还需要注意对基类清理方法和成员对象清理方法的顺序调用，以防止某个子对象依赖另一个子对象的情形发生。一般而言，只需类的特定清理动作，其顺序与生成对象的顺序相反，然后调用基类的清理方法。
许多情况下，清理交给垃圾回收器完成。垃圾回收器回收对象的顺序可能是任意的，所以除了内存以外，最好不依赖垃圾回收器做任何事情，如果要进行清理，最好编写自己的清理方法，而不要使用`finalize() `。

#### 4.2 名称屏蔽
如果java的基类已经拥有多个已被重载的方法名称，那么在它的子类中重新定义该方法名称并不会屏蔽其在基类的任何版本，即重载机制在基类和子类都可以正常使用。

当你想要覆写基类的某个方法时，可以使用@override的注解。如果使用这个注解的方法并不是基类的方法，那么会有编译时错误。

##5 组合和继承的选择 ###
组合和继承都允许在新的类中放置子对象，组合是显式这样做，而继承是隐式地做。
组合技术用于想在新类中使用现有类的功能而非它的接口，即在新类中嵌入某个对象，让其实现所需要的功能，但新类的用户看到的只是为新类定义的接口，而非所嵌入对象的接口，为此，嵌入的现有类对象最好为private。
但有时允许用户访问新类中的组合成分也是有意义的，也就是说将成员对象声明为public。

在继承的时候，使用现有类并开发它的一个特殊版本。通常，这意味着你在使用一个通用类，并为了某种特殊需要而将其特殊化。继承是用”is-a”的关系来表达的，即“车”是一种交通工具，而组合是用“has-a”的关系表达的，即“车”有引擎。

## 6 protected 关键字
关键字protected指明，就用户而言，这是private的，但对于任何继承此类的子类或其他任何位于同一个包内的类来说，它是可以访问的。
尽管可以创建protected域，最好还是将域保持为private，类库设计者应该一直保留“更改底层实现”的权利，然后通过protected方法来控制继承者的访问权限。

## 7 向上转型 

```
public class Instrument {

    public void play(){

    }

    static void tune(Instrument instrument){
        instrument.play();
    }

}

public class Wind extends Instrument {

    public static void main(String[] args) {
        Wind flute = new Wind();
        Instrument.tune(flute);
    }

}

```
在例子中，tune方法可以接收一个Instrument的引用。但在Wind的main方法中，传递给tune的是一个Wind引用，因为Wind是一种Instrument 。tune对Instrument和它的所有子类都起作用，这种将wind引用转换为Instrument的动作，称为向上转型。

在需要考虑使用继承或组合的情况下，想一想是否新类需要向基类向上转型，如果需要，那么继承是必要的；如果不需要，那么就要考虑以下是否真的需要继承。

## 8 final 关键字 
final通常指“这是无法改变的”。不想做出改变可能出于：设计或效率。final可能使用的三种情况：数据，方法和类。
#### 1 final 数据 ####
一块数据恒定不变是有其意义的，比如一个永不改变的编译时常量，一个在运行时被初始化的值而不希望被改变。 对于编译期常量，编译器可以将改常量带入计算式中，在编译时执行计算式可以稍微减轻一些运行时的负担。在Java中，这类常量必须是基本类型，并且以关键字final表示。在对这个常量定义时，必须对其赋值。
一个既是static又是final的域只占据一段不能改变的存储空间。
当对象引用使用final时，引用不变，即一旦final引用被初始化指向一个对象，就无法再把它改为只想另外一个对象。然而，对象本身可以修改，例如对象的非final域。java并未提供是对象恒定不变的途径，但可以自己编写类以达到这种效果。这一限制同样适用于数据，数组也是对象（final的数组不能重新指向其他引用或重新赋值，但是可以改变数组里面的数据）。

常量通常用大写字母作为变量名。
`private static final int VAL_ONE = 10;`
定义为static，强调只有一份，定义为final则说明他是个常量。
某数据是final的，不能认为在编译时就知道它的值。
```
private static Random random = new Random(47);

private static final int VAL_TWO = random.nextInt(10);
//运行时才知道它的值
```   
- **空白 final**，所谓空白final是指被声明为final但又未给定初值的域，但这个域在使用前必须被初始化（在构造器中）。空白final提供了对final域使用的灵活性，可以根据情况给final域设定不同的值，而又保持其恒定不变的特性。

```
public class BlankFinal {
    
    private final int i;

    public BlankFinal(int i) {
        this.i = i;
    }

    public BlankFinal() {
        this.i = 10;
    }
}
```
必须在域的定义处或者每个构造器中对final 域进行赋值，这是final 域在使用前总是被初始化的原因。

- **final 参数**
Java 允许在方法的参数列表将参数指定为final。这意味着你在方法中无法改变参数引用所指向的对象。

```
public class FinalArguement {
    
    void f(final int i){
        // i=10; // can't change
    }
    
    void g(final FinalArguement finalArguement){
        // finalArguement = new FinalArguement(); // can't change
    }
    
}
```
可以读参数或者使用参数引用的方法，但无法改变参数。这一特性主要用来向匿名内部类传递数据。

#### 2 final 方法 ####
使用final 方法有两个原因，第一个是把方法锁定，防止被继承的子类修改，这是出于设计考虑，确保final方法在继承中保持不变，不会被覆盖。
过去建议使用final方法的第二个原因是效率。在早期的java实现中，final方法的调用都会转为内嵌调用。编译器会跳过 插入代码来执行方法调用机制（将参数压入栈，跳至方法代码处执行，跳回并清理栈参数，处理返回值），而是将方法调用替换为方法体中实际代码的副本。这就消除方法调用的开销。然而如果方法很大，程序代码就会膨胀，因而可能看不到内嵌带来的性能提高。在使用java SE5/5时，应该让编译器和jvm去处理效率的问题，只有在想明确禁止覆盖，才将方法设置为final。
- final 和 private 关键字
类中的private方法都隐式地指定为final，由于其他类无法调用private方法，随意也就无法覆盖它。可以对private方法添加final修饰，但是毫无意义。
如果你试图“覆盖”一个基类的private方法，似乎是奏效的。但是覆盖只有在某方法是基类的接口的一部分才会出现，如果某方法为private，它就不是基类接口的一部分，只是隐藏在类中的代码。子类的“覆盖”，实际上只是具有相同名称的方法而已。如果你在子类中创建的public，protected和包访问权限的方法但是并没有override 基类方法，那么就仅仅只是一个新方法，与基类的方法没有关系。

#### 3 final 类 
final 类表明不能继承此类，可能是出于设计或安全考虑，不希望它有子类。final类中的域可以是final或不是，不论类是否被定义为final，相同规则同样适用于定义final域。然而由于final类不能被继承，所以类中的方法也隐式指定为final。

##9 初始化及类的加载
有些语言中，程序是作为启动过程的一部分立刻被加载，然后是初始化，之后程序再运行，这时候就要控制初始化过程，以确保某些static的东西的初始化顺序不会造成麻烦。例如C++中，如果某个static期望使用另外一个static，但另外一个static还没初始化，那么就会出现问题。

Java的类加载机制是另外一种形式。编译后的程序代码是存在每个独立文件中的，只有在需要程序代码时才会加载此文件。通常是第一次construct这个类时会加载，或者是是调用类的static方法或者域（类是在任何static朝成员被访问时加载的，构造器也是static方法，尽管没有显示写出来）。

初次使用之时也是static初始化发生之时。所有的static对象和代码块会按照代码的编写顺序一次初始化。static只初始化一次。

### 继承与初始化
初次调用某个类上的main方法（static方法）时，加载器开始启动类的编译代码，在对类进行加载过程中，如果类有基类，那么编译器继续进行加载基类，如果基类还有其自身的基类，那么第二个就会被加载，以此类推。
接下来初始化基类中static，然后是下一个子类，以此类推。这种方式很重要，因为子类的static初始化可能会依赖于基类成员能否被正确初始化。
至此，必要的类都以加载完毕，对象就可以被创建。首先，对象中所有的基本类型都会被设为默认值，对象引用被设为null，这是通过将对象内存设为二进制零值而一举生成的。
然后，基类的构造器会被调用，它是被自动调用的。但也可以用super来指定对基类构造器的调用。
基类构造器和子类构造器一样，以相同的顺序来经历相同的过程。在基类构造器完成之后，实例变量按其次序被初始化，最后，构造器的其余部分被执行。

## 总结 ##




