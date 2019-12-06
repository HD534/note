
## maven项目获取在resource下的文件路径 ##


- maven项目编译后的target的简单文件目录如下：
	.
	├── target
	│   ├── classes 
	│   ├── test-classes
	│   ├── ...  //其他文件
	
	classes 里面是 src/main/ 下的所有文件，resouces下的文件放置在classes 的根目录下，java下的文件按照package摆放。
	
	test-classes 的文件摆放与 classes 相同，只是其中放置的是test 下的文件。


- 获取当前测试或正式目录下文件的路径。

	src/test/resouces目录下的文件会编译在target\test-classes目录下
	
	src/main/resouces目录下的文件会编译在target\classes目录下
	
	String parentPath = Main.class.getClassLoader().getResource("./").getPath();// 获取当前路径下类的编译路径
	// 当前类的绝对路径+/target/classes/
	
	String testXMLPath = Main.class.getClassLoader().getResource("test.xml").getPath();// 获取 test.xml 所在路径
	
	同理，在 test 类  也可以通过以上方法获取 src/test/resouces


