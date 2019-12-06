
## 基本类型与类 ##

基本类型在java中包括(an integer, a double-precision floating point binary number, etc).  
因为这些类型可能会有不同的长度，包含它们的变量也可能有不同的长度（考虑 `float` 和 `double`）  

另一方面，类变量包含对实例的引用。引用通常在许多语言中实现为指针（或与指针非常相似的东西）。这些东西通常具有相同的大小，无论它们引用的实例的大小如何（Object，String，Integer等）。


基本类型变量不能以相同的方式互换，既不能彼此互换，也不能与Object互换。最显而易见的原因但不是唯一原因的是他们的大小不同。这使得基本类型在这方面不方便，但我仍然需要他们。主要归结为性能的原因。


## 泛型和类型擦除 ##

泛型是具有一个或多个类型参数的类型（确切的数量被称为泛型元数）。例如，`List<T>`这个泛型定义有一个类型参数`T`，`T` 能指`Object (List<Object>)` , `String (List<String>)` `Integer (List<Integer>)` 等等。  
泛型比非泛型复杂得多。为了避免对JVM进行根本性更改，并可能破坏与旧二进制文件的兼容性的问题，Java的创造者决定使用一种侵略性最小的方法实现泛型，即 `List<T>` 的所有具体类型，实际上都被编译成(二进制等效) `List<Object>`，（对于其他类型，绑定可能不是Object）。泛型元数和类型参数的信息在处理的过程中都丢失了，这就叫类型擦除。

## 总结 ##
现在问题是上述情况的结合，如果在任何情况下 `List<T>` 都会变成`List<Object>` ，那么 `T` 就必须是能直接指向 `Object` 的类型，其他的类型都不被允许。但由于 `int` ， `float` ， `double` 等都不能与 `Object` 互换，所以也就不能有 `List<int>` ， `List<float>` ， `List<double>` （除非JVM中存在更复杂的泛型实现）。  
但Java提供了 `Integer`  ， `Float` 和 `Double`等类型，这些类型将基本类型包含在类实例中，使得他们能够有效地替代为 `Object` ， 从而允许泛型类型间接地与基本类型一起使用（因为你可以使用 `List<Integer>` ， `List<Float>` ， `List<Double>`等等）。
将一个 int 转变成一个  Integer，一个 float 变成 Float 等等的这些过程叫做boxing，反过来就叫unboxing。因为每次都将基本类型boxing成 `Object` 类型是很不方便的，所以才有自动装箱拆箱。