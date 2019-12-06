## Runnable 和 Thread 

继承Thread 和 实现Runnable 是java 中创建线程的两种方法。

### 创建
```
public class DemoRunnable implements Runnable {
    public void run() {
        //Code
    }
}
 
//start new thread with a
// "new Thread(new demoRunnable()).start()" call

------------------------------------------------

public class DemoThread extends Thread {
    public DemoThread() {
        super("DemoThread");
    }
    public void run() {
        //Code
    }
}
//start new thread with a
// "new demoThread().start()" call

```

### 区别
1. 继承Thread 的类可以使用Thread 类中的很多特性，Thread类中有许多已经实现的机制，例如 priority， threadQ 等等， Thread类也是实现Runnable接口的。但是由于java 是单继承的，所以继承Thread类的子类不能继承其他类。  
而实现Runnable是更加单纯的一个线程，它只是需要你实现要Run 什么东西。这是组合而不是继承。
2. 实现Runnable接口的类实例可以传递给一些 executor service，或将其作为单个线程应用程序中的任务传递。 当然继承Thread的类实例也可以这样做，因为Thread也是实现Runnable接口的，但是这样做实际上只是使用到Thread类实现Runnable接口的特性，继承是完全不必要的。




### sync 和 thread
关于线程的可见性。

```
public class TestThread {

    public static void main(String[] args) throws InterruptedException {
        Run1 run1 = new Run1();
        new Thread(run1).start();
        Thread.sleep(1000);
        System.out.println("11111111111111111111111");
        run1.b = false;
    }
}

class Run1 implements Runnable {

    private final Object lock = new Object();

    boolean  b = true;

    @Override
    public void run() {
        willStop();
    }

    private void willStop() {
        while (b) {
            synchronized (lock) {
//                System.out.println("22222222");
            }
        }
    }

    private void notStop() {
        synchronized (lock) {
            while (b) {
//                System.out.println("22222222");
            }
        }
    }
}

```
- 在线程中使用某个标志做循环判断，如果循环是在一个同步代码块中，那么即是在其他线程改变了这个标志，循环的线程也不知道;      
如果是循环中有同步代码，那么线程解锁前，必须把共享变量的最新值刷新到主内存中，线程加锁时，将清空工作内存中共享变量的值，使用共享变量时需要从主内存中重新获取最新的值，所以可以实现可见性。

- 此外，由于 System.out.println 的 代码是同步的，所以while循环中有打印的操作，那么也会导致刷新共享变量。

- 同时也可以使用 `volatile` 的关键字，使变量在多个线程间可见，强制线程从主内存中取 volatile修饰的变量。 
但是volatile 不能保证线程安全，假设几个线程同时对一个共享变量i 进行增量修改，这时候线程修改的值都是线程空间的，修改后再刷新到主内存中，那么一个线程的修改就有可能覆盖其他线程的修改或其修改被覆盖， 也有可能读取到的值不是最新的。
- volatile 修饰的变量会禁止指令重排序（有序性）

参考文章：
[https://howtodoinjava.com/java/multi-threading/java-runnable-vs-thread/](https://howtodoinjava.com/java/multi-threading/java-runnable-vs-thread/)
[http://ifeve.com/java-memory-model-1/](http://ifeve.com/java-memory-model-1/)
[https://www.cnblogs.com/hapjin/p/5492880.html](https://www.cnblogs.com/hapjin/p/5492880.html)
