### for sql server
Liquibase 连接SqlServer 时，如果SQL Sqlserver版本是2008， liquibase 使用 3.6.3 版本。

https://liquibase.jira.com/browse/CORE-3242
https://github.com/liquibase/liquibase/pull/850

解决
	1. ChangeLogLock 表的字段问题（Boolean -> Bit）
	2. SqlServer 繁体中文插入数据问题
	3. TimeStamp 在SqlServer 中使用datetime类型
