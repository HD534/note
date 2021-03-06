> 参考文章 https://www.cnblogs.com/Jetictors/p/8506757.html

###1. 标题

# 一级标题

## 二级标题

### 三级标题

#### 四级标题

##### 五级标题

###### 六级标题

###2. 列表
2.1 有序列表   

1. 中国
2. 美国
3. 英国

2.2 无序列表

> ```
> - 中国                 + 中国                 * 中国
> - 美国      <===>      + 美国     <===>       * 美国
> - 英国                 + 英国                 * 英国
> 上面三个符号的效果是一样的，并且可以混用。看下效果：
> ```

- 中国
- 美国
- 英国

###3. 引用
3.1 基本使用
   在一段文本的前面加上英文的右尖括号，即 `>` 符号,
   例如：

> 我是引用文本

3.2 嵌套使用

> 我是引用文本1
> 
> > 我是嵌套的引用文本1
> > 我是嵌套的引用文本2
> > 
> > > 1. 在嵌套一层1   
> > > 2. 在嵌套一层2
> > 
> > 我是嵌套的引用文本3
> 
> 我是引用文本2

###4. 文本样式
4.1 **加粗**

> 在文本的两端分别加上两个星号（**）或者下划线（__）。比如**xxx**，注意:不能有空格

举例说明：
**我是加粗的文本1**
__我是加粗的文本2__

4.2 *斜体*

> 在文本的两端分别加上一个星号（*）或者一个下划线（_）。比如*xxx*，注意:不能有空格

举例说明：
*我是倾斜的文本1*
_我是倾斜的文本2_

4.3 ~~删除线~~

> 在文本的两端分别加上两个波浪号 `~~` 。比如 `~~xxx~~` ，注意:不能有空格

举例说明：
~~我是要删除的文本~~

4.4 下划线
原生无法不支持，可以使用HTML来实现

1. 使用Html标签中的<u></u>标签，但是这种方案不推荐，因为Html5的代码规范以及<u></u>标签的不可定制性。
   
   举例说明：
   
    <u>我是带有下划线的文本</u>

2. 用Html语言中的<span></span>标签
   
   举例说明：下划线为绿色，并且高度为1px，并且下划线为虚线。
   
    <span style="border-bottom:1px dashed green;">所添加的需要加下划线的行内文字</span>

4.5 数学公式
参考 https://www.jianshu.com/p/a0aa94ef8ab2
只举例说明数学公式中的上划线与下划线。

举例说明：

上划线：
        $\overline{X}$
下划线：
        $\underline{X}$

###5. 链接与图片
5.1 链接

> 链接的使用：英文下的一对中括号[]来包裹住链接的文本，中括号后面跟上英文下的一对小括号()来包裹住链接的地址。
> 比如 ```[百度](http://www.baidu.com) ```

举例说明：
[百度](http://www.baidu.com)
[掘金](https://juejin.im)

5.2 图片

> 图片的使用和链接的使用几乎相同，只要在[]前面加上一个英文的感叹号即可，即(!)符号。
> 比如```[图片1](图片的连接) ```

举例说明：
![图片1](图片的连接)    
![图片2](图片的连接) 

###6. 表格
6.1 基本使用
举例说明：

```
|  列名1  |  列名2  |  列名3  |
|---------|---------|---------|
|  值1    |   值1   |  值2    |
|  值1    |   值1   |  值2    |
|  值1    |   值1   |  值2    |
```

实际效果：
|  列名1  |  列名2  |  列名3  |
|---------|---------|---------|
|  值1    |   值1   |  值2    |
|  值1    |   值1   |  值2    |
|  值1    |   值1   |  值2    |

6.2 表格的对齐方式

> 默认的对齐方式为：左对齐方式。

举例说明：第一列左对齐，第二列居中对齐，第三列右对齐。

```
注意和上面例子的不同之处,在第二行的减号 - 前或后加上英文冒号 :

|  左对齐列名1  |  居中对齐列名2  |  右对齐列名3  |
|:--------|:-------:|--------:|
|  值1    |   值1   |  值2    |
|  值1    |   值1   |  值2    |
|  值1    |   值1   |  值2    |
```

实际效果：
|  左对齐列名1  |  居中对齐列名2  |  右对齐列名3  |
|:--------|:-------:|--------:|
|  值1    |   值1   |  值2    |
|  值1    |   值1   |  值2    |
|  值1    |   值1   |  值2    |

###7. 关键字、代码块、多行文本、换行

####7.1 关键字

> 关键字的使用：在文本的两端分别加上英文的 ``` ` ``` 这个符号。例：``` `xxx` ```,``` `yyy` ```

举例说明：
`关键字1`、`Java`、`Android`、`ios`

####7.2 代码块

> 代码框的使用：在一段文本的前面加上4个空格

    //注意看下面的每一行前面都有一个Tab键的额长度，即4个空格
    for(int i = 0 ; i < 5; i++){
        println("asdasdasdasd")
    }

####7.3 纯文本

> 纯文本的使用：在一段文本的两端分别加上3个英文的 ``` ` ``` 符号，
> 例：` ```xxxxx``` `
> 使用三个 ``` ` ``` 符号的表现在不同的渲染器下面效果可能不同。

可以尝试使用三个 ``` 来写代码块，不过在某些渲染器下会变成纯文本格式。
代码块：

```
for(int i = 0 ; i < 5; i++){
    println("asdasdasdasd")
}
```

某些渲染器的纯文本的效果：
```for(int i = 0 ; i < 5; i++){ println("asdasdasdasd") }```

#### 7.4 换行符

> 换行符的使用这里提供三种方式：
> 
> - 使用Html中的```<br/>```标签（不推荐），因为在某一些工具或在线平台中达不到效果
> - 段落与段落之间使用一个空行（推荐）
> - 在第一段文本结束后使用两个空格，在换行写第二段文本。（推荐）****$$
