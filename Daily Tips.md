
## Daily Tips ##
IDEA debug时候会遇到代码的缓存问题，导致debugger打断点的记录跟实际的java代码不对应。


### About java stream list to map

[https://docs.oracle.com/javase/8/docs/api/java/util/stream/Collectors.html#toMap-java.util.function.Function-java.util.function.Function-](https://docs.oracle.com/javase/8/docs/api/java/util/stream/Collectors.html#toMap-java.util.function.Function-java.util.function.Function-)
```
Map<String, Student> studentIdToStudent = students.stream().collect(toMap(Student::getId,Functions.identity());
```