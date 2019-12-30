# Java Boxed Stream Java装箱流 #

在Java8中，如果你想将一个 object 的流变成 collection，你可以直接使用
```
List<String> strings = Stream.of("AAA", "BBB", "CCC", "DDD", "EEE")
                    .collect(Collectors.toList());
```
然而对于基本类型却不能直接做相同的操作。
```
IntStream.of(1,2,3,4,5)
    .collect(Collectors.toList());  // 会有编译时异常
```

为了转化一个基本类型的流，需要先装箱这些元素，这种流被称为**boxed stream**

## IntStream to List of Integers ##
```
List<Integer> ints = IntStream.of(1,2,3,4,5)
                .boxed()
                .collect(Collectors.toList());
         
System.out.println(ints);
 
Output:
 
[1, 2, 3, 4, 5]
```
