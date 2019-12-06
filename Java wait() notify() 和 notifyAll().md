## Java wait() notify() 和 notifyAll() ##
[https://howtodoinjava.com/java/multi-threading/wait-notify-and-notifyall-methods/](https://howtodoinjava.com/java/multi-threading/wait-notify-and-notifyall-methods/)

### 简介
Java中的Object类有三个`final`方法，允许线程就资源的锁定状态进行通信。

1. wait()
它告诉调用线程放弃锁定并进入`sleep`状态，直到某个其他线程进入同一个`monitor `并调用`notify()`。
wait() 方法在进入等待之前释放锁，在从`wait()`方法返回之前重新获取锁。`wait `方法是一个**native method**。
调用wait 方法的一般语法是这样的：
```
synchronized( lockObject )
{
	    while( ! condition )
	    {
	        lockObject.wait();
	    }
	     
	    //take the action here;
}
```

	`wait` 方法 的java doc 补充：
	使当前线程等待直到其他线程对此对象调用 `notify` 或 `notifyAll` 方法。此方法的行为就像它只是执行调用 `wait(0)` 一样。
	当前线程必须持有对象的 monitor。当前线程释放对象的 monitor，然后等到另外的线程 notify 那些在等待这个对象的 monitor 的线程的时候，当前线程就继续等待直到它可以重新获取monitor。

2. notify()
它唤醒了一个在同一个对象上调用wait 的线程。应该注意的是，调用notify实际上并没有放弃对资源的锁定。它唤醒等待线程，但是在它的同步块完成之前，不会放弃锁定。
调用notify 方法的一般语法是这样的：
```
synchronized(lockObject)
{
    //establish_the_condition;
 
    lockObject.notify();
     
    //any additional code if needed
}
```
notify 方法的java doc上有些许补充：
notify 唤醒正在此对象监视器上等待的单个线程。如果任何线程正在等待此对象，则选择其中一个线程被唤醒。选择是任意的，选择取决于线程管理的OS实现。线程通过调用wait方法等待对象的监视器。
在当前线程放弃对该对象的锁定之前，唤醒的线程是无法继续。唤醒的线程将以通常的方式与可能正在竞争同步此对象的任何其他线程竞争，例如，唤醒线程在成为锁定此对象的下一个线程时没有可靠的特权或劣势。
此方法只应由作为此对象监视器 owner 的线程调用。有三种方式能让线程成为对象监视器的 owner：
	1. 通过执行该对象的同步实例方法。
	2. 通过执行在对象上同步的同步语句代码块。
	3. 对于Class类型的对象，通过执行该类的同步静态方法。  
 
 一次只有一个线程可以拥有对象的监视器。  

3. notifyAll()
它唤醒了在同一个对象上调用wait 的所有线程。在大多数情况下，优先级最高的线程将首先运行，但不能保证。其他的东西与上面的notify 方法相同。

### 问题
1. 调用notify 但是没有线程在 waiting会怎么样？
没有什么事情发生。
如果没有其他线程在等待时调用notify 方法，则notify 只是返回并且通知丢失。由于等待和通知机制不知道它发送通知的条件，因此它假定如果没有线程在等待通知，那么通知就被丢弃。稍后执行wait 方法的线程必须等待另一个通知发生。

2. 在wait 方法释放或重新获取锁期间是否会出现竞争条件？
 在等待线程已经处于可以接收通知的状态之前，实际上不释放对象锁。这可防止此机制中出现任何竞争条件。
释放后的锁会被其他等待此锁的线程竞争获取。
在wait线程获取锁之前，它首先需要被唤醒，然后与其他等待此锁的线程竞争获取锁。

3. 什么情况下要用notifyAll ？
有几个原因。例如，可能有多个条件需要等待。由于我们无法控制哪个线程获得通知，因此通知可能会唤醒正在等待完全不同的条件的线程。
通过唤醒所有线程，我们可以设计程序，以便线程自己决定下一个应该执行哪个线程。
另一种可能是生产者生成可以满足多个消费者的数据。由于可能难以确定有多少消费者需要需被唤醒，因此可以选择通知所有消费者，允许消费者在他们之间进行分类。

