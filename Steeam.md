# Stream #


## 1.   characteristics of Stream ##
- Not a data structure   
  不是数据结构
- Designed for lambdas  
  为lambda设计的
- Do not support indexed access  
  不支持索引
- Can easily be outputted as arrays or lists  
  能产出array和list
- Lazy access supported  
   支持懒访问
- Parallelizable  
  支持并行

## 2.  Different ways to create streams ##
- `Stream<Integer> stream = Stream.of(1,2,3,4,5,6,7,8,9);`
- `Stream<Integer> stream = Stream.of( new Integer[]{1,2,3,4,5,6,7,8,9} );`
- `Stream<Integer> stream = Arrays.asList(1,2,3,4,5,6).stream();`
- `Stream<Date> stream = Stream.generate(() -> { return new Date(); });`
- `IntStream stream = "12345_abcdefg".chars();`
  `Stream<String> stream = Stream.of("A$B$C".split("\\$"));`

- using Stream.Buider or using intermediate operations


## 3.  Convert streams to collections ##

- Convert Stream to List – Stream.collect( Collectors.toList() )
  `List<Integer> evenNumbersList = stream.filter(i -> i%2 == 0).collect(Collectors.toList());`

-  Convert Stream to array – Stream.toArray( EntryType[]::new )
  `Integer[] evenNumbersArr = stream.filter(i -> i%2 == 0).toArray(Integer[]::new);`

- collect stream into set, map or into multiple ways. Just go through Collectors class

- ### About java stream list to map

	[https://docs.oracle.com/javase/8/docs/api/java/util/stream/Collectors.html#toMap-java.util.function.Function-java.util.function.Function-](https://docs.oracle.com/javase/8/docs/api/java/util/stream/Collectors.html#toMap-java.util.function.Function-java.util.function.Function-)
	```
	Map<String, Student> studentIdToStudent = students.stream().collect(toMap(Student::getId,Functions.identity());
	```

## 4. Core stream operations 
 First,  we build out example on this list, and we can use this list in below parts.
 ` List<String> memberNames = Arrays.asList("Amitabh", "Shekhar", "Aman", "Rahul", "Shahrukh", "Salman", "Yana", "Lokesh");`
### Intermediate operations 
 Intermediate operations return the stream itself so you can chain multiple method calls in a row

-  Stream.filter()  
  Filter accepts a predicate to filter all elements of the stream

	 `memberNames.stream().filter((s) -> s.startsWith("A")).forEach(System.out::println);`

- Stream.map()  
The intermediate operation map converts each element into another object via the given function
     
	`memberNames.stream().filter((s) -> s.startsWith("A")) .map(String::toUpperCase) .forEach(System.out::println);`  

- Stream.sorted()  
Sorted is an intermediate operation which returns a sorted view of the stream. The elements are sorted in natural order unless you pass a custom Comparator. 

	`memberNames.stream().sorted()  
.map(String::toUpperCase)
.forEach(System.out::println);`

##  Terminal operations  
Terminal operations return a result of a certain type instead of again a Stream.

- Stream.forEach()

    `memberNames.forEach(System.out::println);`

- Stream.collect()  
collect() method used to recieve elements from a sream and store them in a collection and metioned in parameter funcion.  
    ```
	List<String> memNamesInUppercase = memberNames.stream()
							.sorted()
							.map(String::toUpperCase)
							.collect(Collectors.toList());

- Stream.match()  
Various matching operations can be used to check whether a certain predicate matches the stream. All of those operations are terminal and return a boolean result.
	```
	boolean matchedResult = memberNames.stream()
	                    .anyMatch((s) -> s.startsWith("A"));
	 
	System.out.println(matchedResult);
	 
	matchedResult = memberNames.stream()
	                    .allMatch((s) -> s.startsWith("A"));
	 
	System.out.println(matchedResult);
	 
	matchedResult = memberNames.stream()
	                    .noneMatch((s) -> s.startsWith("A"));
	 
	System.out.println(matchedResult);
	 
	Output:
	 
	true
	false
	false
	```

- Stream.count()  
Count is a terminal operation returning the number of elements in the stream as a long.  
	```
	long totalMatched = memberNames.stream()
	                    .filter((s) -> s.startsWith("A"))
	                    .count();
	```

- Stream.reduce()  
This terminal operation performs a reduction on the elements of the stream with the given function. The result is an Optional holding the reduced value.
```
Optional<String> reduced = memberNames.stream()
                    .reduce((s1,s2) -> s1 + "#" + s2);
 
reduced.ifPresent(System.out::println);
 
Output: Amitabh#Shekhar#Aman#Rahul#Shahrukh#Salman#Yana#Lokesh
```

## 5.  Stream short-circuit operations 
Though, stream operations are performed on all elements inside a collection satisfying a predicate, It is often desired to break the operation whenever a matching element is encountered during iteration. In external iteration, you will do with if-else block. In internal iteration, there are certain methods you can use for this purpose. Let’s see example of two such methods:

- Stream.anyMatch()  
This will return true once a condition passed as predicate satisfy. It will not process any more elements.
```
boolean matched = memberNames.stream()
                    .anyMatch((s) -> s.startsWith("A"));
 
System.out.println(matched);
 
Output: true
```

- Stream.findFirst()  
It will return first element from stream and then will not process any more element.

```
String firstMatchedName = memberNames.stream()
                .filter((s) -> s.startsWith("L"))
                .findFirst().get();
 
System.out.println(firstMatchedName);
 
Output: Lokesh
```

## 6. Parallelism in Java Steam ##

With the Fork/Join framework added in Java SE 7, we have efficient machinery for implementing parallel operations in our applications. But implementing this framework is itself a complex task; and if not done right; is a source of complex multi-threading bugs having potential to crash the application. With the introduction of internal iteration, we got the possibility of operations to be done in parallel.

To enable parallelism, all you have to do is to create a parallel stream, instead of sequential stream. And to surprise you, this is really very easy. In any of above listed stream examples, anytime you want to particular job using multiple threads in parallel cores, all you have to call method **parallelStream()** method instead of stream() method.
```
public class StreamBuilders {
     public static void main(String[] args){
        List<Integer> list = new ArrayList<Integer>();
         for(int i = 1; i< 10; i++){
             list.add(i);
         }
         //Here creating a parallel stream
         Stream<Integer> stream = list.parallelStream(); 
         Integer[] evenNumbersArr = stream.filter(i -> i%2 == 0).toArray(Integer[]::new);
         System.out.print(evenNumbersArr);
     }
}
```





