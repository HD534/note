# Chapter 11 持有对象
数组是保存一组对象的最有效方法，但是数组具有固定的大小。
Java 还提供了集合类如 List，Set，Queue，Map，它们也是保存对象的容器。
## 1 泛型和类型安全的容器 ##
ArrayList 的使用简单，可以当作“可以自动扩充自身尺寸的数组”。在声明ArrayList 的时候如果不指定泛型，那么可以放入 Object 类型，而用 get 方法取出的时候也是 Object 。
使用泛型创建的 List，编译器只会允许放入指定类型的对象，将元素取出时也不需要做类型转换。
指定的类型也包括该类型的子类。

## 2 基本概念
Java 容器类类库的用途是保存对象，其中有两种不同的概念。
1. Collection 一个独立元素的序列，这些元素都服从一条或多条规则。
2. Map 一组成对的“键值对”对象，允许使用键来查找值。

ArrayList 允许使用数字索引来查找值，因此某种意义上把数组和对象关联在一起。映射表允许我们使用另外一个对象来查找某个对象，他也称为“关联数组”，因为它将某些对象与另外一些对象关联起来，或者称为“字典”。

理想情况下大部分代码与接口打交道，在容器类中，你可以这样创建一个List：
```
List<Dogs> dogs = new ArrayList<>();
```
注意ArrayList 已经被向上转型为 List 。接口的目的在于如果你修改实现，只需要在创建的时候修改：
```
List<Dogs> dogs = new LinkedList<>();
```
因此建议创建一个具体类对象，将其转换为对应的接口，然后使用这个接口。
当然有时候某个具体类会有额外的功能，例如 LinkedList 中包含List 未包含的方法。 TreeMap 也具有 Map 接口中未包含的方法。如果需要使用这些方法，就不能使用更通用的接口。

Collection 接口概括了序列的概念 —— 一种存放一组对象的方式， add 方法表明将一个新元素放置到容器中。
Collection 的一个子类 Set 中，只有元素不存在的情况下才会添加， ArrayList 或在其他 List 不关心是否存在重复。
所有的 Collection 都可以用 foreach 的语法遍历。

## 3 添加一组元素
Arrays.asList() 方法 接受一个数组或一个用逗号隔开的元素列表（可变参数 ...）` public static <T> List<T> asList(T... a)` 
Collection.addAll() 方法接受一个 Collection 对象以及一个数组或用逗号分隔的列表。

使用Arrays.asList() 底层表示的是数组，因此不能添加或删除元素。

使用**显示类型参数说明** 告诉编译器产生的 List 的类型。
```
List<Snow> sonws = Arrays.<Snow>asList(new Light(), new Heavy());
```

## 4 容器的打印
使用Arrays.toString() 来产生数组的可打印表示，但是打印容器不需要。Collection 类会将元素按照顺序用逗号隔开打印出来，而 Map 类会将键值对打印出来。

## 5 List
1. ArrayList，擅长随机访问元素，中间插入和移除元素较慢。
2. LinkedList，中间插入和删除操作代价较低，提供了优化的顺序访问，在随机访问方面较差，但是特性集比 ArrayList 大。

## 6 迭代器
get 方法是取出元素的方法之一。
要使用容器，必须对容器的确切类型进行编程，例如是 List 或者 Set ，如果原本是对着List编码，后来发现如果将相同的代码应用与 Set ，将会更加方便。从头开始编写通用的代码，或者说我们只是使用容器，并不关心容器的类型。
迭代器 `Iterator`（也是一种设计模式）的概念可以达到此目的。迭代器是一个对象，它的工作室遍历并选择序列中的对象。而客户端程序员不必知道该序列底层结构。此外，迭代器通常被称为 轻量级对象 ，创建它的代价小。
Java 中的 Iterator 只能单向移动。这个 Iterator 只能用来：
1. 容器类的 Iterator 方法 返回一个 Iterator 对象， Iterator 将准备好返回序列的第一个元素。
2. 使用 next 方法获得序列的下一个元素
3. 使用 hasNext 方法判断序列是否还有元素
4. 使用 remove 方法将迭代器新近返回的元素删除

使用 Iterator 不必为容器中元素的数量操心，而关心 next 和 hasNext 。

如果只是向前遍历 List 而不修改List 本身 ， 使用 foreach 语法会更加简洁。 

Iterator 还可以移除由 next 产生的最后一个元素，这意味着在调用 remove 方法之前必须先调用 next 。

```
public void display(Iterator<Pet> it) {
	while(it.hasNext()){
		Pet pet = it.next();
		System.out.println(pet);
	}

}
```
迭代器能够将遍历序列的操作与序列的底层结构分离开。正由于此，我们有时候会说，迭代器同一了对容器的访问方式。

### 6.1 ListIterator
ListIterator 是一个更加强大的 Iterator 的子类。他只能用于各种 List 的访问。ListIterator 可以双向移动，获取相对于迭代器在列表中指向的当前位置的前一个和后一个元素的索引，并且可使用 set 方法替换它访问过的最后一个元素。
```
ListIterator<Pet> listIterator = pets.listIterator();
listIterator.next();
listIterator.set(new Pet())
```

## 7 LinkedList
执行中间插入和移除比ArrayList 高效，在随机访问操作方面逊色。
LinkedList 还添加了可以使其作为栈、队列或双端队列的方法。


## 8 Stack 栈
栈 通常是指 先进后出（LIFO）的容器，有时栈也被称为叠加栈，因为最后压入栈的元素将会第一个弹出。


## 9 Set
Set 不保存重复的元素。Set 具有与 Collection 完全一样的接口，因此没有额外的功能，只是行为跟 Collection 不同。
HashSet 使用的散列，其所维护的顺序与 TreeSet 或 LinkedHashSet 都不同，因为它们的实现具有不同的元素存储方式。 TreeSet 将元素存储在红-黑树数据结构中，而 HashSet 使用的是散列函数， LinkedHashSet 因为查询速度的原因也使用了散列，但是看起来它使用了链表来维护元素的插入顺序。
如果想对结果狗进行排序，则可以使用 TreeSet 。

## 10 Map
将对象映射到其他对象的能力是解决编程问题的杀手锏。
```
public class Statistic {
    public static void main(String[] args) {
        Random random = new Random(47);
        Map<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < 10000; i++) {
            int r = random.nextInt(20);
            Integer freq = map.get(r);
            map.put(r, freq == null ? 0 : freq + 1);
        }
        System.out.println(map);
    }
}

output:
{0=480, 1=501, 2=488, 3=507, 4=480, 5=502,
 6=518, 7=470, 8=467, 9=548, 10=512, 11=530, 12=520, 
13=505, 14=476, 15=496, 16=532, 17=508, 18=477, 19=463}
```
使用map 来计算随机数字的计数。

Map 与数组和其他的 Collection 一样，可以很容易扩展到多维。因此我们可以将容器组合起来生成更加复杂的数据结构。
例如 `Map<Person, List<Pet>>` 等等。

## 11 Queue
队列是一个典型的先进先出（FIFO）的容器，事物放进容器的顺序与取出的顺序是相同的。队列常被当作一种可靠的将对象从程序的一个区域传输到另外一个区域的途径。队列在并发编程中特别重要。

LinkedList 提供了方法以支持队列的行为，并且实现了 `Queue` 的接口。

### 1 PriorityQueue
先进先出描述了最典型的队列规则。队列规则是指给定一组队列元素，确定下一个弹出队列的元素的规则，先进先出的规则声明，下个要弹出的元素应该是等待时间最长的元素（即进入队列的时间最早，等待的时间最长）。

优先级队列声明的下一个要弹出的元素是最需要（优先级最高）的元素。例如有一个消息系统，某些消息比其他消息更重要，因而应该更快得到处理，那么它们何时得到处理就与它们何时到达无关。
当你在 `PriorityQueue` 上调用 `offer()` 方法插入一个对象时，这个对象会在队列中被排序，默认的排序将使用对象在队列中的自然排序，但是你可以提供自己的 `Comparator` 来修改这个顺序。
`PriorityQueue` 确保你调用 `peek` ，`poll` ，`remove` 方法获取的元素将是队列中优先级最高的元素。 

在队列中重复是允许的，默认最小的值拥有最高的优先级（如果是 String ，空格也算作值，并且比字母的优先级高）

## 12 Collection 和 Iterator
`Collection` 是描述所有序列容器的共性的更接口。使用接口描述的一个理由是它可以使我们创建更通用的代码。整队接口编写的代码可以应用于更多的对象类型。

实现 `Collection` 就意味着需要提供 `iterator` 方法。
当你要实现一个不是 `Collection` 的外部类时，由于实现 `Collection` 接口可能比较困难或麻烦，因此使用 `Iterator` 就会更加方便。

继承 `AbstractCollection` 还是需要实现 `iterator` 和 `size` 等方法，但有可能我们不需要这些方法。
实现 `Collection` 就需实现 `iterator` 方法。只实现 `iterator` 方法 和继承 `AbstractCollection` 相比，代价稍微少了一点，但是如果你的类已经继承了其他类，那么就不能继承 `AbstractCollection`，这种情况，继承并创建 `Iterator` 就会容易一些。

```
class PetSequence{
	
}

class CollectionSequence extends PetSequence {
	public Iterator<Pet> iterator() {
		return new Iterator<Pet>(){
			//...  实现 iterator 
		}
	}
}

```

## 13 Foreach 与 迭代器 ##
`foreach` 能和所有的 `Collection` 对象一起工作，之所以这样，是因为 `Collection` 继承了 `Iterable` 的接口，该接口包含一个能够产生 `Iterator` 的 `iterator()` 方法，并且 `Iterable` 接口被 `foreach` 用来在序列中移动，如果你创建了任何实现 `Iterable` 的类，都可以应用上 `foreach`
```
public class IterableClass implements Iterable<String> {
    protected String[] words = ("And that is how we know the Earth to be banana-shaped").split(" ");
    @Override
    public Iterator<String> iterator() {
        return new Iterator<String>() {
            private int index = 0;
            @Override
            public boolean hasNext() {
                return index<words.length;
            }

            @Override
            public String next() {
                return words[index++];
            }
        };
    }

    public static void main(String[] args) {
        for (String s : new IterableClass()) {
            System.out.print(s+" ");
        }
    }
}
```

foreach 可以应用于数组或 Iterable ，但这并不意味着数组肯定也是一个 Iterable，也不存在从数组到 Iterable 的自动转换。

### 1 适配器方法惯用法
当你有一个实现 Iterable 的类，想要添加多种在 foreach 语句中使用这个类的方法，应该怎么做？ 
例如，假设我们希望能有正向和反向迭代一个单词列表，如果直接继承这个类，并覆盖 iterator 方法，你只能替换现有的方法，而不能实现选择。
适配器方法可以让你提供特定的接口方法来满足 foreach 语句。
```
public class MultiIteratorClass extends IterableClass {

    public Iterable<String> reverse(){
        return new Iterable<String>() {
            @Override
            public Iterator<String> iterator() {
                return new Iterator<String>() {
                    int current = words.length-1;
                    @Override
                    public boolean hasNext() {
                        return current>-1;
                    }

                    @Override
                    public String next() {
                        return words[current--];
                    }
                };
            }
        };
    }

    public Iterable<String> randomized(){
	  // Functional Interface 的 lambda 表达式创建
        return ()->{
            List<String> shuffled = new ArrayList<>(Arrays.asList(words));
            Collections.shuffle(shuffled);
            return shuffled.iterator();
        };
//        return new Iterable<String>() {
//            public Iterator<String> iterator(){
//                List<String> shuffled = new ArrayList<>(Arrays.asList(words));
//                Collections.shuffle(shuffled);
//                return shuffled.iterator();
//            }
//        };
    }

    public static void main(String[] args) {
        MultiIteratorClass multiIteratorClass = new MultiIteratorClass();
        for (String s : multiIteratorClass.reverse()) {
            System.out.print(s+" ");
        }
        System.out.println();
        for (String s : multiIteratorClass.randomized()) {
            System.out.print(s+" ");
        }
        System.out.println();
        for (String s : multiIteratorClass) {
            System.out.print(s+" ");
        }
    }
}
```