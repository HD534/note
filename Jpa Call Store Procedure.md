# Jpa call store procedure #

###第一种 使用 native sql 

```
// 参数需要使用(?1,?2) 这样的调用方式，
String storeProcedureName = "{call sp_1(?1)}";
// call sp 一定需要添加 { } 
Query nativeQuery = entityManager.createNativeQuery(storeProcedureName,TestPo.class); 
// 设置参数
nativeQuery.setParameter(1, userId); 

List resultList = nativeQuery.getResultList(); 
...

```

### 第二种 使用 createNamedStoredProcedureQuery

```
@Entity  //必须使用entity，使用entity的时候必须有@Id
@NamedStoredProcedureQueries(
        {
                @NamedStoredProcedureQuery(
			name = "sp_1",  //entityManager 使用这个去创建sp
			procedureName = "sp_1", 
                        parameters = {
                                @StoredProcedureParameter(name = "param1", type = String.class, mode = ParameterMode.IN),
                                @StoredProcedureParameter(name = "param2", type = String.class, mode = ParameterMode.IN),
                        },
                        resultClasses = TestPo.class
                ),
        }
)
public class TestPo {


	@Id //必须有
	@Column(name = "Id") //对应SP的返回值
	private int Id

	// 其他返回类型

	// Get Set 方法	

}

// 调用方法

public void testSp(){
        StoredProcedureQuery sp_1 = entityManager.createNamedStoredProcedureQuery("sp_1");
	  sp_1.setParameter(...) //
        List<String> resultList = sp_1.getResultList();
        //....
}

```


