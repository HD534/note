## ThinkInJava Chapter5  初始化和清理##
### 重载方法的区分 ###
每个重载方法都必须有独一无二的参数类型列表
参数顺序不同也可以区分，但是建议不这样写，因为代码难以维护

### 基本类型的重载 ###
当一个int类型调用f1时
如果有某个重载方法接受int类型，则该方法会被调用，如果传入的数据类型（实际参数类型）小于方法的中声明的的形式参数类型，则实际数据类型就会被提升。char类型略有不同，如果无法找到恰好接受char参数的方法，就会把char直接提升到int型

```
void f1(char x){ }
void f1(byte x){ }
void f1(short x){ }
void f1(int x){ }
void f1(long x){ }
void f1(float x){ }
void f1(double x){ }
```

如果方法接受的基本类型较小，而传入实际参数较大，则需要通过强制类型转换来执行窄化转换，不然编译器会报错。

```
void f1(char x){}

when call:
double x = 0;
f1((char)x)

```
 以返回值来区分重载方法是不可取的，因为有时候你并不关心返回值，如果调用时忽略方法的返回值，那Java如何才能判断该调用哪一个方法呢？

```
void f1(){}

int f1(){ return 1; }

call:

f1();

```

### 默认构造器 ###
默认构造器是没有形式参数的，他的作用是创建一个默认的对象。如果你写的类中没有构造器，则编译器会自动帮你创建一个默认构造器。  
如果你定义了一个构造器（无论是否有参数），编译器就不会自动帮你创建默认构造器。  

### this关键字
this关键字只能在方法内部使用，表示对“调用方法的那个对象”的引用。this的用法和其他对对象引用相同，但要注意如果在方法内部调用同一类的方法，就不必用this，直接调用即可。只有当需要明确指出对当前对象的引用时，才使用this关键字。例如，当需要返回当前对象的引用时，常常在`return`语句中使用：
```
public class Leaf{
	int i = 0;
	Leaf increment(){
		i++;
		return this;
	}
}
```
由于`incrememnt()`通过this关键字返回当前对象的引用，所以很容易在一条语句中对同一个对象进行多次操作。
```
Leaf leaf = new Leaf();
leaf.incrememnt().incrememnt().incrememnt();
```
### 在构造器中调用构造器
在一个构造器中调用另外一个构造器，避免重复代码，可使用this关键字做到这一点。
```
public class Flower {

    int petalCount = 0;
    String s = "init value";

    public Flower(int petalCount) {
        this.petalCount = petalCount;
    }

    public Flower(String s) {
        this.s = s;
    }

    public Flower(int petalCount, String s) {
        //must be put in the first line
        this(petalCount);
        //this(s);    //can't call two constructor
        this.s = s;
    }

    public Flower() {
        System.out.println("default constructor");
    }

    void f(){
        //this(11);
        System.out.println(this.petalCount);
    }
}
```
可以使用this调用一个构造器，但却不能调用两个。此外，构造器必须在最起始处被调用。  
由于参数s的名称与数据成员s的名字相同，所以会产生歧义，使用this来代表数据成员来解决这个问题。  
除构造器外，编译器禁止在其他任何方法调用构造器。正如上面的方法。

### static的含义 ###
static方法就是没有this的方法，在static方法内部不能调用非静态方法（如果把类的引用传递到static方法中，通过这个引用来调用非静态方法和访问非静态域数据成员。）在没有创建类对象的时候，可以通过类本身来调用static方法，这是static方法的实际用途。

## 垃圾回收  ##
- 对象可能不被垃圾回收
- 垃圾回收并不等于“析构”（析构函数是出C++中销毁对象使用的）
- 垃圾回收只与内存有关  
使用垃圾回收器的唯一原因是为了回收程序不再使用的内存。

### 对象终结条件 ###
当对某个对象不再感兴趣--也就是它可以被清理了，这个对象应该处于某种状态，使它的内存可以被安全地释放。例如，要是对象表示一个打开的文件，在对象被回收之前程序应该关闭这个文件。要是对象中存在没有被适当清理的部分，程序就存在隐晦的缺陷。finaliaze()可以用来最终发现这种情况，尽管它并不总是被调用。
  
finalize()可能是使用方法：
```
public class TerminationCondition {

    public static void main(String[] args) {
        Book b1 = new Book("Think in java", true);
        //proper cleanup
        b1.checkIn();
        //drop the reference, forget to clean up
        new Book("hello world",true);
        //force garbage collection & finalization
        System.gc();
    }

}

class Book{

    private boolean checkedOut = false;
    private String name = "";

    public Book(String name, boolean checkedOut) {
        this.name = name;
        this.checkedOut = checkedOut;
    }

    void checkIn(){
        checkedOut = false;
    }

    @Override
    protected void finalize() throws Throwable {
        if (checkedOut)
            System.out.println("Error: the book : <<"+ this.name+">> was checkedOut!");
        super.finalize();
    }
}

/*Output:
Error: the book : <<hello world>> was checkedOut!

```
本例的终结条件是，所有的book对象在被垃圾回收之前应该checkIn。但在main方法中，由于一本书没有checkIn，如果没有finalize()来检验终结条件，很难发现这个问题。  
应该总是假设基类版本的finalize()方法也要做某些重要的事情，所以要用super来调用它。

### 垃圾回收器如何工作

引用计数是一种简单但速度很慢的垃圾回收计数。每个对象都含有一个引用计数器。当有引用连接到对象时，引用计数加1。当引用离开作用域或被置为null时，引用计数减1.虽然管理引用计数的开销不大，但这项开销在整个程序生命周期中将持续发生。垃圾回收器会在含有全部对象的列表上遍历，当发现某个对象的引用计数为0时，就释放其空间（但是引用计数模式经常会在计数值变为0时立即释放对象）。这个方法有个缺陷，如果对象之间循环引用，可能会出现“对象应该被回收，但引用计数不为零“的情况。对垃圾回收器来说，定位这样交互自引用的对象组需要的工作量极大。引用计数常用来说明垃圾收集的工作，但似乎从未被应用于任何一种java虚拟实现中。  

在一些更快的更快的模式中，垃圾回收器依据的思想是，对任何”活“的对象，


## 成员初始化 ##
方法成员必须初始化，否则会有编译时错误。  
类的数据成员，即字段，如果是基本类型，则会有一个默认的初始值。类中的引用对象如果不初始化，则赋予null
```
boolean   false
char      [ ]
byte      0
short     0
int       0
long      0
float     0.0
double    0.0
Object    null
```

### 指定初始化

### 构造器初始化

####  初始化顺序
在类的内部，变量定义的先后顺序决定了初始化的顺序，即使变量定义散布于方法定义之间，它们仍会在任何方法（包括构造器）被调用之前得到初始化。

#### 静态数据的初始化 
无论创建多少个对象，静态数据都只占用一份存储区域。static关键字只能用于域变量，不能用于局部变量。一个静态域没有进行初始化，则会按照成员的类型进行初始化。
```

class Bowl{
    Bowl(int marker){
        System.out.println("Bowl( " + marker + " )");
    }

    void bowlFunction(int marker){
        System.out.println("bowlFunction("+marker+")");
    }
}

class Table{
    static Bowl bowl1 = new Bowl(1);

    Table(){
        System.out.println("Table()");
        bowl2.bowlFunction(1);
    }

    void tableFunction(int marker){
        System.out.println("tableFunction("+marker+")");
    }
    static Bowl bowl2 = new Bowl(2);
}

class Cupboard{
    Bowl bowl3 = new Bowl(3);
    static Bowl bowl4 = new Bowl(4);
    Cupboard(){
        System.out.println("Cupboard()");
    }

    void cupBoardFunction(int marker){
        System.out.println("cupBoardFunction("+marker+")");
    }
    static Bowl bowl5 = new Bowl(5);
}

public class StaticInit {
    static Table table = new Table();
    static Cupboard cupboard = new Cupboard();
    //尝试注释掉上面的静态初始化以及main方法中的调用，
    //会发现table并没有静态的table以及其静态域bowl都不会被初始化	
    public static void main(String[] args) {
        System.out.println("Creating new Cupboard() in main");
        new Cupboard();

        System.out.println("Creating new Cupboard() in main");

        new Cupboard();

        table.tableFunction(1);
        cupboard.cupBoardFunction(1);
    }
}

output:
Bowl( 1 )
Bowl( 2 )
Table()
bowlFunction(1)
Bowl( 4 )
Bowl( 5 )
Bowl( 3 )
Cupboard()
Creating new Cupboard() in main
Bowl( 3 )
Cupboard()
Creating new Cupboard() in main
Bowl( 3 )
Cupboard()
tableFunction(1)
cupBoardFunction(1)

```

静态初始化只有在必要时可才会进行。如果不创建Table对象，也不引用Table.bowl1 或 Table.bowl2，则静态的Bowl bowl1和bowl2永远都不会被创建。只有在第一个Table对象被创建（或者第一次访问静态数据）的时候，它们才会初始化。此后，静态对象不会再次被初始化。  
初始化的顺序是先静态对象（如果它们还未初始化），而后是“非静态”对象。  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;在例子中可以看到，执行main方法之前，必须先加载main方法所在的类，然后其静态域被初始化。  

总结一下对象创建过程，假设有个Dog类
1. 即使没有显示使用static关键字，构造器实际上也是静态方法。因此当首次创建Dog对象或者Dog类的静态方法/域首次被访问时，java解释器必须查找类路径，以定位Dog.class文件
2. 然后载入Dog.class（这将创建一个Class对象），有关静态初始化的动作都会执行。因此，静态初始化只在Class对象首次加载的时候进行一次。
3. 当用new Dog() 创建对象的时候，首先在堆上为Dog分配足够的存储空间。
4. 这块存储空间会被清零，这就自动将Dog对象中的所有基本类型都设置为默认值，引用设置为null
5. 执行所有出现于字段定义处的初始化动作。
6. 执行构造器。这将会牵涉到其他动作，尤其是继承的时候。

#### 显示的静态初始化

java 允许将多个静态初始化动作组织成一个特殊的“静态子句”（静态块）。静态块仅执行一次。
```
static int i;
static {
	i  = 77;
}
```

#### 非静态实例初始化
```
Object o;
{
	o = new Object():
}

```
与静态块一样，只是少了static关键字。这种语法对于支持匿名内部类的初始化是必须的。初始化子句是在构造器之前执行的，无论调用哪个显示构造器，块中的操作都会发生。

#### 数组的初始化

数组是相同类型的、用一个标志符名称封装到一起的一个对象序列或基本类型数据序列、数据是通过方括号下表操作符[ ]来定义和使用的。要定义一个数据，只需在类型名后加上一对空方括号即可。
```
int[] a;
int a[];
```

```
int[] a = {1,2,3,4,5};
a.length; //5 最大下标是4，从0开始。

// 通过 new 创建
Integer[] integers = new Integer[10];
Random random = new Random(47);
System.out.println(Arrays.toString(integers));
for (int i1 = 0; i1 < integers.length; i1++) {
    integers[i1] = random.nextInt(500);
}
System.out.println(Arrays.toString(integers));


//可以用花括号括起来的列表初始化对象
Integer[] a = {
	new Integer(1),
	new Integer(2),
	3, //autoboxing
}

```

#### 可变参数列表

```
//参数列表可变，可以传入一个或多个,或者数组，或者0个参数
public class ChangeableParam {

    static void f(Object... objects){
        for (Object object : objects) {
            System.out.println(object);
        }
    }

    static void g(int required,String... option){
        System.out.println("required: "+required);
        for (String s : option) {
            System.out.println(s);
        }
    }

    public static void main(String[] args) {
        f(new Integer(1),new Double(2));
        f(new Integer[]{1, 2, 3});	
        g(10,"aaa","bbb");
        g(100);
    }

}

output：
1
2.0
1
2
3
required: 10
aaa
bbb
required: 100

```

自动包装机制也可以在可变参数列表中使用。
```
f(new Integer(1),2);
...
```
可变参数列表使得重载过程变得复杂。
```
void f(Object... o){
}

void f(int... i){
}

//main:
f();   //编译不通过，因为编译器不知道应该调用哪个方法

```
应该总是在重载方法的一个版本上使用可变参数列表，或者不使用可变参数列表。

### 枚举类型
enum关键字
```
public enum Spiciness {
    NOT, MILD, MEDIUM, HOT, FLAMING
}

```

```
public class SimpleEnum {
    public static void main(String[] args) {
        //有toString方法
        Spiciness howHot = Spiciness.MEDIUM;
        System.out.println(howHot);

        //声明顺序
        for (Spiciness value : Spiciness.values()) {
            System.out.println(value + ", ordinal " + value.ordinal());
        }
    }
}
```

## 总结
构造器能确保正确的初始化和清理。  
java的垃圾回收期会自动为对象释放内存，在很多情况下，清理的动作是不太需要的。这极大地简化编程工作，在处理内存时候也更安全。  垃圾回收器也确实增加了运行时的开销。










