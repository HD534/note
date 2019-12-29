###What 

事务的参与者、支持事务的服务器、资源服务器以及事务管理器位于不同的分布式系统的不同节点上。

事务管理器（DB）

###CAP

- 一致性 （Consistency）： 客户端知道一系列的操作都会同时发生
- 可用性 （Available） ： 每个操作都必须以可预期的响应结束
- 分区容错性（Partition tolerance） ： 即使出现单个组件无法可用，操作依然可以完成

在分布式系统中， C，A，P 三个最多只能选择两个

###BASE

- BA ： Basic Available，基本可用
- S ： Soft State， 柔性状态
- E ： Eventually Consistency， 最终一致性