https://stackoverflow.com/questions/19498378/setting-precedence-of-multiple-controlleradvice-exceptionhandlers

https://spring.io/blog/2013/11/01/exception-handling-in-spring-mvc

Code snippet :


可以添加@Order 来设置 advice 优先级
```
@ControllerAdvice
@Slf4j
@Order(Ordered.HIGHEST_PRECEDENCE)
public class GlobalExceptionHandler {


    @ExceptionHandler({Throwable.class})
    @ResponseBody
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public String handlerException(Throwable throwable) {
        log.error(throwable.getMessage(),throwable);
        log.error("in the first exception handler");
        return throwable.getMessage();
    }

}
```




```
@ControllerAdvice
@Slf4j
public class ExceptionHandler2 {

    @ExceptionHandler({Throwable.class})
    @ResponseBody
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public String handlerException(Throwable throwable) {
        log.error(throwable.getMessage(),throwable);
        log.error("in the second exception handler");
        return throwable.getMessage();
    }
}
```