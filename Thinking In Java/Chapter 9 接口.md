#Chapter 9 接口

接口和内部类为我们提供了一种将接口与实现分离得更加结构化的方法。

## 1 抽象类
抽象方法仅有声明，没有方法体
```
abstract void f();
```
包含抽象方法的类就叫抽象类，如果一个类包含一个或多个抽象方法，该类就必须被限定为抽象。
创建一个抽象类的对象是不安全的，因为抽象类的方法不完整，所以编译器会报错以保证抽象类的纯粹性。
如果继承一个抽象类，那么就必须实现所有的抽象方法，否则子类也必须是抽象类，使用`abstract` 关键字限定这个类。
我们可能会创建一个没有任何抽象方法的抽象类，如果有一个类，让其包含任何抽象方法都没有实际意义，但是又想阻止产生这个类的任何对象。


抽象类和抽象方法使类的抽象性明确，告诉用户和编译器打算怎么使用它们。

## 2 接口
`interface` 关键字产生一个完全抽象的类，没有提供任何具体实现（Java 8 开始可以有具体实现）。它允许创建者确定方法名，参数列表和返回类型。
接口用来创建类与类之间的协议。
`interface`允许人们通过创建一个能够被向上转型为多种基类的类型，来实现某种类似多重继承的特性。
```
public interface I {
	public void f();
}
```
`interface`与`class`一样有访问权限控制，可以加上`public` 修饰，或者不加表示包访问权限。接口中可以包含域，**这些域隐式是`static`和f`inal`的**。

使用`implements` 关键字表示类实现某个接口。可以选择在接口中定义方法为`public`，但默认也只能是`public`的。接口的修饰默认是`public abstract`。

## 3 完全解耦
只要一个方法操作的是类而非接口，那么你就只能使用这个类及其子类，这样你就不能将这个方法应用于不在此继承结构的其他类。接口在很大程度上放宽这种限制，如果你的方法接收的是一个接口，那么只要实现这个接口的类你都能使用，因此可以写出可复用性更高的代码。

假设有一个Processor类，作为基类被扩展。process 返回返回类型是协变类型（即子类覆盖父类的方法可以返回父类方法返回类型的子类，在这里父类方法的返回类型是所有类的父类 Object，所以子类可以返回任意类型）
```
class Processor {

    public String name(){
        return getClass().getSimpleName();
    }

    //a processor to process something and return the thing after process
    Object process(Object input){
        return input;
    }
}

class Upcase extends Processor{

    @Override
    Object process(Object input) {
        return ((String) input).toUpperCase();
    }
}

class Downcase extends Processor{

    @Override
    Object process(Object input) {
        return ((String) input).toLowerCase();
    }
}

class Splitter extends Processor{

    @Override
    Object process(Object input) {
        return Arrays.toString(((String) input).split(" "));
    }
}

public class Apply{

    // Apply.process, 能够根据所传递的参数对象不同而有不同的行为的方法，称为策略模式
    // 这类方法包含所要执行的算法中固定不变的部分，而策略包含变化的部分，
    // 策略就是传递进去的参数对象，它包含要执行的代码，这里的Processor对象就是一个策略
    public static void process(Processor processor,Object s){
        System.out.println("Using processor : "+processor.name());
        System.out.println(processor.process(s));
    }
    //

    public static String s = "Disagreement with beliefs is by definition incorrect";
    public static void main(String[] args) {
        System.out.println("original string is : "+s);
        //三种不同的策略应用在同一对象上。
        process(new Upcase(),s);
        process(new Downcase(),s);
        process(new Splitter(),s);
    }

}
```
假设这时候发现另外的类库里面的某个类可以适用Apply.process()

```
public class Waveform {

    private static long counter;

    private final long id = counter++;

    @Override
    public String toString() {
        return "Waveform "+id;
    }
}


public class Filter {
    public String name(){
        return getClass().getSimpleName();
    }


    public Waveform process(Waveform input){
        return input;
    }
    
}

public class LowPass extends Filter {
    double cutoff;
    public LowPass(double cutoff){
        this.cutoff = cutoff;
    }

    @Override
    public Waveform process(Waveform input) {
        return input; //dummy process here
    }
}

public class HighPass extends Filter {
    double cutoff;

    public HighPass(double cutoff) {
        this.cutoff = cutoff;
    }

    @Override
    public Waveform process(Waveform input) {
        return input;
    }
}
```
虽然Filter 与  Processor 有相同的接口元素，但是因为它不是继承Processor（创建者可能根本不知道它要用作Processor），因此不能将Filter用于Apply.process()。这里Processor 和 Apply.process() 耦合过紧，使得Apply.process() 难以复用。还有Filter.process 的 的输入和输出都是 Waveform。
如果Processor是接口，那么就会限制小一些。

```
public interface Processor {
    String name();
    Object process(Object input);
}

public class Apply {

    public static void process(Processor processor,Object s){
        System.out.println("Using processor : "+processor.name());
        System.out.println(processor.process(s));
    }
}
```
之前的直接继承自Processor的类可以变成这样
```
public abstract class StringProcessor implements Processor {
    @Override
    public String name() {
        return getClass().getSimpleName();
    }

    @Override
    public abstract Object process(Object input);

    public static String s = "Disagreement with beliefs is by definition incorrect";
    public static void main(String[] args) {
        System.out.println("original string is : "+s);
        Apply.process(new Upcase(),s);
        Apply.process(new Downcase(),s);
        Apply.process(new Splitter(),s);
    }
}

class Upcase extends StringProcessor{

    @Override
    public Object process(Object input) {
        return ((String) input).toUpperCase();
    }
}

class Downcase extends StringProcessor{

    @Override
    public Object process(Object input) {
        return ((String) input).toLowerCase();
    }
}

class Splitter extends StringProcessor{

    @Override
    public Object process(Object input) {
        return Arrays.toString(((String) input).split(" "));
    }
}
```
而 Waveform就可以这样使用
```

/**
 * 有时候你无法修改你要想使用的类，例如{@link Waveform} 是在类库中发现而不是创建的，
 * 那么我们可以使用适配器设计模式，在 适配器 中的代码将接受你所有用的接口，并产生你所需要的接口。
 */
class FilterAdapter implements Processor{

    private Filter filter;

    public FilterAdapter(Filter filter) {
        this.filter = filter;
    }

    @Override
    public String name() {
        return filter.name();
    }

    @Override
    public Waveform process(Object input) {
        return filter.process((Waveform)input);
    }
}

/**
 * 使用适配器, {@link FilterAdapter} 接受你所拥有的接口{@link Filter},
 * 然后生成具有你需要的{@link Processor}接口, {@link FilterAdapter} 类中用到了代理
 */
public class FilterProcessor {
    public static void main(String[] args) {
        Waveform waveform = new Waveform();
        Apply.process(new FilterAdapter(new LowPass(1.0)),waveform);
        Apply.process(new FilterAdapter(new HighPass(10.0)),waveform);
        Apply.process(new FilterAdapter(new BandPass(1.0,10.0)),waveform);
    }
}
```

## 4 多重继承 
接口没有任何实现，所以没有任何跟接口相关的存储，所以多个接口可以组合，也就是可以表达“一个 X 即是a，又是b，还是c”。
子类只能继承一个类，可以实现多个接口。
```
class Parent {
	void f() { }
}

interface Inter {
	void f();
}
Interface Inter1 {
	void g();
}

class Child extends A implements I, I1 {
	void g(){ }
}
```
类 `Child` 继承类 `Parent` ，实现接口 `Inter，Inter1`，由于类 `Parent`  中的方法 `f` 与 接口 `Inter` 的 `f` 方法的特征签名一样，所以在类 `Child` 中没有显示地实现方法 `f`，因为类 `Parent` 中已经定义了。
使用接口的核心原因就是为了能够向上转型为多个基类以及由此带来的灵活性，第二是为了防止客户端程序员创建该类的对象，确保它仅仅只是一个接口。

## 5 通过继承扩展接口
接口可以继承一个或多个接口，通过继承可以在新接口中组合接口。
```
interface I extends I1, I2{

}
```
### 1. 组合接口时的名字冲突

在接口多继承中，使用相同的方法名的多个接口可能会造成代码的可读性混乱和编译错误，所以尽量避免这种情况。
```
public interface I1 {
    void f();
}

interface I2 {
    int f(int i);
}

interface I3 {
    int f();
}

class C{
    public int f(){
        return 0;
    }
}

class C1 implements I1, I2 {

    @Override
    public void f() {
    }

    @Override
    public int f(int i) {
        return 0;
    }
}

class C2 extends C implements I2{

    @Override
    public int f(int i) {
        return 0;
    }
}

class C4 extends C implements I3{
    //不用实现接口中的方法，继承的类中已经有了。
}


class C5 implements I1,I3{

    //I1 和 I3 的方法签名和参数（无）相同，但是返回类型不同，所以实现这两个接口会报错，因为编译器不知道 f 这个方法是哪个接口的。
    @Override
    public int f() {
        return 0;
    }

}

class C6 extends C implements I1{
    //覆盖 实现 和 重载方法混合在一起，重载方法仅通过返回类型是区别不开的
}
```

## 6 适配接口
同一接口可以具有不同的实现，一个方法接受接口类型作为参数，那么传递给该方法的对象就取决于方法的使用者。
因此接口的一种常见用法是 策略模式，此时你编写一个执行某些操作的方法，而调用该方法将接受一个你指定的接口，这样就是声明：你可以用任何你想要的对象来调用我的方法，只要你的对象遵循我的接口。这使得你的方法更加灵活、通用、高可复用性。
Java SE5 的 `Scanner` 类的构造器接受一个 `Readable` 的接口。
假设发现有一个 `RandomDoubles` 类，想要让Scanner 作用于它，那我们可以通过适配器，适配器产生的类继承`RandomDoubles`和实现`Readable` 。
```
public class RandomDoubles {
    private static Random random = new Random(47);

    public double next(){
        return random.nextDouble();
    }

    public static void main(String[] args) {
        RandomDoubles randomDoubles = new RandomDoubles();
        for (int i = 0; i < 7; i++) {
            System.out.println(randomDoubles.next()+" ");
        }
    }
}


public class RandomDoubleAdapter extends RandomDoubles implements Readable {

    private int count;

    public RandomDoubleAdapter(int count) {
        this.count = count;
    }

    @Override
    public int read(CharBuffer cb) throws IOException {
        if (count--==0){
            return -1;
        }
        String result = Double.toString(next())+" ";
        cb.append(result);

        return result.length();
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(new RandomDoubleAdapter(7));
        while (scanner.hasNextDouble())
            System.out.print(scanner.nextDouble()+" ");
    }
}

```
在这种方式中，我们可以在任何现有类上添加新的接口，让方法接受接口类型，其他类都可以对该方法进行适配。

## 7 接口中的域
接口中的域默认是 `static` 和 `final` 的，所以接口就成了一种很便捷的创建常量组的工具。但是Java SE5 之后，我们可以使用 `enum` 来做这种工作。

### 1 初始化接口中的域
接口中的域不能是“空 final”，但是可以被非常量表达式初始化。这些域不是接口的一部分，它们的值被存储在该接口的静态存储区域内。
```
public interface RandVals{
	Random RAND = new Random(47);
	int RAND_INT = RAND.nextInt();
	//...
}

public class TestRand {

	public static void mian() { 
 		RandVals.RAND_INT;
		//...
	}
}
```

## 8 嵌套接口
接口可以嵌套在类或其他接口中。
嵌套在类中的接口可以是private的，这样的好处是类中的private接口只能在类中使用。

嵌套在接口中的接口，因为所有的接口元素都是public的，所以嵌套在另一个接口中的接口就自动是public的。

当实现某个接口时，并不需要实现嵌套在其内部的接口。
而且，private的接口不能在定义它的类之外被实现。

## 9 接口和工厂 
接口是实现多重继承的途径，而生成遵循某个接口对象的典型方式就是工厂方法设计模式。与直接调用构造器不同，在工厂对象上我们调用创建方法，而工厂对象将生成接口的某个实现的对象。理论上通过这种方式我们的代码将完全与接口的实现分离。
如果不是用工厂方式，你要使用接口的实现类时就要指定要哪个具体的实现类。
使用这种方式的一个原因是要创建框架。

## 10 总结
确定接口是理想选择，因而总是选择接口而不是具体的类，这不是一种好的设计，虽然你总是可以使用接口和工厂类来创建新的类。但是这是一种草率的优化设计。
任何的抽象都应该是实际需求驱动出来的，应该是优选选择类而不是接口，从类开始，如果在编码的过程中发现接口的必须性非常明确，抽象很有必要的时候，那么就进行重构。

