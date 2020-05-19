##概述
1. 异步通信，扩展解耦能力
2. 消息代理（message broker）， 目的地（destination）
当消息发送后，由broker 接管，broker 保证传递到 destination

3. 形式
队列（queue） 点对点通信
主题（topic）  发布（publisher）/订阅（subscribe） 消息通信

###实现
1. 点对点  

    - 发送消息到队列，接收者从队列获取信息，信息移除出队列
    - 消息只有唯一发送者和接收者，但并不是说只有一个接收者
 
2. 发布订阅
发布者发送消息到主题，多个接收者（订阅者）监听（订阅）这个主题，那么消息到达时，同时收到消息

3. JMS（Java message Service） Java消息服务
基于JVM 消息代理的规范。ActiveMQ、HornetMQ 是JMS实现

4. AMQP (Advanced Message Queuing Protocol)
高级消息队列协议，兼容JMS，RabbitMQ 是一种实现

### Spring 支持
- JMS
- rabbit

spring boot auto config

### Rabbit MQ

