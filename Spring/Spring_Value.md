Spring_Value

https://www.baeldung.com/spring-value-annotation

```
@Value("#{'${listOfValues}'.split(',')}")
private List<String> valuesList;

```
