# chapter 14 类型信息

##1 运行时类型信息 （RTTI）
所以的类型转换都是在运行时进行正确性检查的，在运行时，识别一个对象的类型正是RTTI的含义。

通过RTTI，可以查询某个引用指向的对象的确切类型。

## 2 Class 对象
Class 对象是用来创建类的所有的”常规“对象的，它包含了与类相关的信息。每一个类都有一个Class对象，换言之，每当编译一个新类，就会产生一个 Class 对象（更恰当的说是被保存在一个同名的.class 文件中）。为了生成这个类的对象，JVM将使用被称为”类加载器“的子系统。

所以类在第一次使用时动态加载到jvm ，当程序创建第一个对类的静态成员引用时就会加载这个类，所以构造器也是类的静态方法，使用 new 创建类对象也会被当作对类的静态成员的引用。

类的Class 对象被载入内存，它就被用来创建这个类的对象。
```
Class.forName("ClassName");
```
`Class` 对象和其他对象一样，我们可以获取并操作它， `forName` 是它的一个 `static` 方法，调用是为了它的”副作用“：如果类没被加载就加载它， 如果找不到此类，会抛出 `ClassNotFoundException`。

可以使用  对象引用的 `getClass()` 方法来获取 `Class` 对象。

### 2.1 类字面常量
另外一种生成 `Class` 对象的引用的方法，是使用 类字面常量
`Class c = FancyToy.class;` 
这样不仅简单而且更安全，因为在编译时会受到检查。
类字面常量还可应用于接口、数组以及基本数据类型，对于基本类数据类型的包装器类，还有一个标准字段 `TYPE`。 `TYPE` 是一个引用，指向基本数据类型的 `Class` 对象，例如 
```
boolean.class  ==> Boolean.TYPE
int.class      ==> Integer.TYPE
....
```
建议使用 " .class " 的形式，以保持与普通类的一致性。
当使用  ".class" 来创建 `Class` 对象引用时，不会自动初始化该对象，为了使用类而做的准备工作有三步：
1. 加载，这是有类加载器执行的。
2. 链接，在链接阶段将验证类中的字节码 ，为静态域分配存储空间， 如果必需的话将解析这个类创建的对其他类的所有引用。
3. 初始化，如果该类有超类则对其初始化，执行静态初始化构造器和静态初始化块。

初始化被延迟到对静态方法或者非常数静态域进行首次引用时才执行，这实现了尽可能的“惰性”。
仅有 `.class` 语法 不会引发初始化，但是为了产生 `Class` 引用，`Class.forName()` 立即进行了初始化。

### 2.2  泛化的 Class 引用
Class 引用总是指向某个 Class 对象，它可以制造类的实例，并包含作用与这些实例的方法代码。它还包含该类的静态成员，因此Class 引用表示的就是它所指向的对象的确切类型，而该对象便是 Class 类的一个对象。
Java SE5 之后，允许对 Class 引用所指向的 Class 对象的类型进行限定，这里用到了泛型语法。
```
public class GenericClassReference {
    public static void main(String[] args) {
        Class intClass = int.class;
        Class<Integer> genericIntClass = int.class;
        genericIntClass = Integer.TYPE;
        genericIntClass = Integer.class;
        intClass = double.class;
        // genericIntClass = double.class;   //Illegal
    }
}

```
上面的语法都是正确的。泛型类引用只能赋值为指向其声明的类型，但是普通类引用可以被重新赋值给其他Class 类型。
如果你想使用 `Class<Number> genericIntClass = int.class` ，因为 Integer 继承自 Number，但是它无法工作，因为 Integer Class 对象并不是 Number Class 对象的子类。

在使用泛化的Class 引用时，可以使用通配符 ` ? `，表示任何事物，这样在上面的例子中就可以将 `double` class 赋值给 泛型的Class 对象。 
`Class<?>` 的好处是，表示你不是出于疏忽或者其他原因，而使用一个非具体的类引用。
现在可以将通配符与 extends 结合使用：
```
Class<Number> numberClass = Number.class;
//numberClass = int.class;  //illegal
Class<? extends Number> numberGenericClass = Number.class;
numberGenericClass = int.class;
numberGenericClass = double.class;
numberGenericClass = numberClass;
// numberClass = numberGenericClass; //illegal
```
添加泛型语法的原因仅仅是为了提供编译器的类型检查，如果你操作有误，可以很快发现，如果运行时再发现，就有点不方便了。

下面的例子告诉我们在使用泛型 Class 对象时 newInstance() 的不同：
```
Class intClass = int.class;
Class<Integer> genericIntClass = int.class;
Object o = intClass.newInstance();
Integer integer = genericIntClass.newInstance();
Class<? super Integer> superclass = genericIntClass.getSuperclass();
// Class<Number> c = genericIntClass.getSuperclass(); //illegal
Object object = superclass.newInstance();
```
泛型语法的 `Class` 的 `newInstance()` 可以返回该对象的准确类型。
如果你想获得某个类的父类引用，那编译器只允许你声明父类引用是“某个类，它是 Integer 的父类”，`Class<? super Integer> superclass` 。正由于这种模糊性，所以 `superclass.newInstance()` 只能是 `Object `。

### 2.3 新的转型语法
Java SE5 还添加了用于Class 引用的转型语法，即 `cast()` 方法。
```
class ParentClass {}

class ChildClass extends ParentClass {}

public class ClassCast {
    public static void main(String[] args) {
        ParentClass parentClass = new ChildClass();
        Class<ChildClass> bClass = ChildClass.class;
        ChildClass childClass = bClass.cast(parentClass);
        ChildClass childClass1 = (ChildClass) parentClass;//or just do this
    }
}
```

## 3 类型转换前先做检查
Java 中可以自由向上转型，但是向下转型需要做显示转换，而且编译器将检查向下转型是否合理。
在运行时类型信息中有一种方式，关键字 instanceof ，它返回一个布尔值，告诉我们对象是不是某个特定类型的实例。
```
public class InstanceOfDemo {
    public static void main(String[] args) {
        Animal animal = new Animal();
        if (animal instanceof Dog){
            ((Dog) animal).bark();
        }
        ((Dog) animal).bark();
    }
}

class Dog extends Animal{
    public void bark(){}
}

class Animal{}
```
如果直接转换不使用 instanceof ，那么类型不正确的话会得到一个 ClassCastException 。

动态的 instanceof  —— Class.isInstance() 方法，它接收一个对象实例，判断当前确定指定的 Object 是否与此 Class 表示的对象具有赋值兼容性。


....

## 6 反射：运行时的类信息
如果不知道某个对象的确切类型，RTTI 可以告诉你，前提是这个类型在编译时已知，这样 RTTI 才能识别并利用这些信息。换句话说，在编译时，编译器就须知道所有要通过 RTTI 来处理的类。

Class 类和 java.lang.reflect 类库一起对反射的概念进行了支持，该类库包含的 Field、Method以及 Constructor 类（每个类都实现了Member接口）。这些类型的对象是由JVM在运行时创建的，用以表示未知类里对应的成员。通过反射类库提供的类和方法，可以调用方法，获取修改字段等，匿名对象的类型在运行时确定下来，而在编译时不需要知道任何事情。

当通过反射与一个未知类型对象打交道时，JVM 只是简单的检查这个对象，看他属于哪个特定的类。在用它之前必须先加载那个类的 Class 对象。因此类的 .class 文件对JVM 是必须可获取的：在本地或是通过网络获取。

RTIT与反射的真正区别在于：对 RTTI 来说，编译器在编译时打开和检查 .class 文件（换句话说，用”普通“的方式调用对象的方法）。而对于反射机制，.class 文件在编译时是不可获取的，所以在运行时打开和检查 .class 文件。



##7 动态代理
利用反射可以对类进行代理，代理类通常作为被代理的类的中间人角色。

```
public interface Interface {
    void doSomething();
}


public class RealObject implements Interface {
    @Override
    public void doSomething() {
        System.out.println("real object do something");
    }
}

// 代理类和被代理的类实现同一个接口，代理类持有一个被代理的类
public class SimpleProxy implements Interface {

    private Interface proxied;

    public SimpleProxy(Interface proxied) {
        this.proxied = proxied;
    }

    @Override
    public void doSomething() {
        System.out.println("proxy do something");
        proxied.doSomething();
    }

}


public class SimpleProxyDemo {
    // 参数是一个接口，所以可以把代理类传进来
    public static void comsume(Interface i){
        i.doSomething();
    }

    public static void main(String[] args) {
        comsume(new RealObject());
        comsume(new SimpleProxy(new RealObject()));
    }

}


```

Java 的动态代理比代理思想更进一步，因为它可以动态地创建代理并动态地处理对所代理方法的调用。在动态代理上所做的所有调用都会被重定向到单一的调用处理器上。调用处理器的工作是揭示调用的类型并确定相应的对策。

```
public class DynamicProxyHandler implements InvocationHandler {

    private Object proxied;

    public DynamicProxyHandler(Object proxied) {
        this.proxied = proxied;
    }
    // 可以通过传入的参数例如 method，或 args 做一些判断和特定操作
    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        System.out.println("*** dynamic proxy: " + proxy.getClass() + ", method: " + method + ", args: " + args);
        if (args != null) {
            for (Object arg : args) {
                System.out.println("  " + args);
            }
        }
        return method.invoke(proxied,args);
    }
}

public class SimpleDynamicProxy {

    public static void consume(Interface i){
        i.doSomething();
    }
    //通过静态方法 Proxy.newProxyInstance 创建动态代理，这个方法需要一个类加载器，
    // 一个你希望该代理实现的接口列表，一个 InvocationHandler 的实现类
    public static void main(String[] args) {
        RealObject realObject = new RealObject();
        consume(realObject);
        //insert a proxy and call again
        Interface proxy = (Interface) Proxy.newProxyInstance(Interface.class.getClassLoader(), new Class[]{Interface.class}, new DynamicProxyHandler(realObject));
        consume(proxy);
    }
}



// output:
real object do something
*** dynamic proxy: class com.sun.proxy.$Proxy0, method: public abstract void com.andy.chapter14.porxy.Interface.doSomething(), args: null
real object do something
```

##8 空对象

##9 接口与类型信息


