[Spring Batch 4.0 官方文档](https://docs.spring.io/spring-batch/4.0.x/reference/html/index-single.html "Spring Batch 4.0")  
[Spring Batch 4.1 官方文档](https://docs.spring.io/spring-batch/4.1.x/reference/html/index-single.html#domainLanguageOfBatch)
## Spring Batch介绍 

### 批处理的原则和指南
 - 批处理的框架和上线框架直接会互相影响，尽可能使用通用构建块来考虑架构和环境。
 - 尽可能简化并避免在一个批应用程序中构建复杂的逻辑结构。
 - 保持数据的处理和存储物理上紧密相连（换句话说，将数据保存在处理过程中）。
 - 最大限度地减少系统资源的使用，尤其是I / O.在内存执行尽可能多的操作。
 - 查看应用程序I / O（分析SQL语句）以确保避免不必要的物理I / O 。
 - 在批处理中不要做同样的事情两次。例如，如果需要数据汇总以用于出报告，则应该（如果可能）在最初处理数据时，递增存储总量，这样，报告应用不必重新处理相同的数据。
 - 在批处理应用程序开始时分配足够的内存，以避免在此过程中进行耗时的重新分配。
 - 总是假设数据完整性最差的情况。插入足够的检查和记录验证以维护数据完整性。
 - 尽可能实施校验和以进行内部验证。例如，文件应该有一个记录的预告，告诉文件中的记录总数以及关键字段的汇总。  
 
 - 在具有真实数据量的类似生产环境中尽早计划和执行压力测试。
 - 在大批量系统中，备份可能具有挑战性，特别是如果系统以24-7为基础同时在线运行。数据库备份通常在在线设计中得到很好的处理，但文件备份应该被视为同样重要。如果系统依赖于文件，则文件备份过程不仅应该到位并记录在案，还应定期进行测试。
 
### 批处理策略

## Spring Batch 4.0 的变化 ##

### Java 8 的版本要求  ###
### 更新依赖关系基准 ###
Spring Batch 4正在全面更新依赖关系。新的依赖版本与Spring Framework 5一致
### 提供 ItemReaders, ItemProcessors,  ItemWriters 的  builders

## 批处理的领域语言

![](https://docs.spring.io/spring-batch/4.0.x/reference/html/images/spring-batch-reference-model.png)
批处理模型

### Job ###
Job是一个封装整个批处理过程的实体。与其他Spring项目一样，Job与XML配置文件或基于Java的配置连接在一起。

Job只是整体层次结构的顶部，如下图所示：
![](https://docs.spring.io/spring-batch/4.0.x/reference/html/images/job-heirarchy.png)

在Spring Batch中，Job只是Step实例的容器。它结合了逻辑上是同一流程的多个步骤，允许为所有步骤配置全局属性，例如重启功能。Job 包括以下配置：
- Job的名字
- Step 实例的定义和顺序
- Job释放支持重启

Spring Batch以SimpleJob类的形式提供了Job接口的默认简单实现，它创建了Job的一些标准功能。使用基于java的配置时，可以使用一组构建器来实例化Job，如以下示例所示：
```
@Bean
public Job footballJob() {
    return this.jobBuilderFactory.get("footballJob")
                     .start(playerLoad())
                     .next(gameLoad())
                     .next(playerSummarization())
                     .end()
                     .build();
}
```

#### 1. Job Instance 
Job Instance 指向对应的一个Job，JJobInstance指的是逻辑上Job运行的概念。  
JobInstance的定义绝对不会影响要加载的数据。应该由ItemReader的实现，来确定如何加载数据。  
使用新的JobInstance意味着“从头开始”，使用现有JobInstance通常意味着“从您离开的地方开始”。

#### 2. JobParameters
一个JobInstance如何区别于另一个？答案是：JobParameters  
JobParameters对象包含一组用于启动batch job的参数  
它们可以在运行期间用于识别或用作参数数据
![](https://docs.spring.io/spring-batch/4.1.x/reference/html/images/job-stereotypes-parameters.png)  

可以这样理解：
JobInstance = Job + identifying JobParameters  
这允许开发人员有效地控制JobInstance的定义方式，因为它们控制传入的参数

#### 3. JobExecution

JobExecution指的是单次尝试运行Job的技术概念。  
JobExecution可能以失败或成功结束，但除非JobExecution成功完成，否则对应于给定执行的JobInstance不被视为完成。  
Job定义了 Job是什么以及如何执行Job，JobInstance是一个纯粹的组织对象，用于将Execution组合在一起，主要是为了启用正确的重启语义。但是，JobExecution是运行期间实际发生的主要存储机制，包含许多必须控制和保留的属性。  
参考：[JobExecution Properties](https://docs.spring.io/spring-batch/4.1.x/reference/html/index-single.html#jobexecution)  


### Step 

![](https://docs.spring.io/spring-batch/4.1.x/reference/html/images/jobHeirarchyWithSteps.png)

[StepExecution Properties](https://docs.spring.io/spring-batch/4.1.x/reference/html/index-single.html#stepexecution)

### ExecutionContext

