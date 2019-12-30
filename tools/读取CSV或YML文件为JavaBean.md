读取CSV或YML文件为JavaBean
```
public class CaseInfo {

    private String envId;

    private String caseId;

    private String caseName;

    private String caseDesc;

    public CaseInfo() {
    }

    public CaseInfo(String caseId, String caseName, String caseDesc) {
        this.caseId = caseId;
        this.caseName = caseName;
        this.caseDesc = caseDesc;
    }

    //getter and setter

}

```


读取CSV文件，将里面的信息转化为 java bean
```
import com.opencsv.bean.CsvToBeanBuilder;

public class CaseInfoParser {

    public static Map<String, CaseInfo> getCaseInfoMapFromCSVFile(String fileName) {
        List<CaseInfo> caseInfoList;
        try {
            caseInfoList = new CsvToBeanBuilder<CaseInfo>(new FileReader(CaseInfoParser.class.getClassLoader().getResource(fileName).getFile()))
                    .withType(CaseInfo.class)
                    .build()
                    .parse();
            return caseInfoList.stream().collect(Collectors.toMap(CaseInfo::getCaseId, caseInfo -> caseInfo));
        }catch (FileNotFoundException e){
            throw new RuntimeException("can not find the file", e);
        }
        catch (Exception e) {
            throw new RuntimeException("read case info failed from file: "+fileName, e);
        }
    }

}
```

读取yml文件，将里面的信息转化为 java bean,
但是如果使用springboot，添加下面的dependency 会导致springboot 由于依赖冲突而启动失败。
参考： https://www.baeldung.com/java-snake-yaml
```
public class YamlParser {


// add the dependency to solve with yaml
//        <dependency>
//            <!--<groupId>org.yaml</groupId>-->
//            <!--<artifactId>snakeyaml</artifactId>-->
//            <!--<version>1.21</version>-->
//        </dependency>

    public Map<String, CaseInfo> readCaseInfoFileIntoMap(String fileName) throws FileNotFoundException {
        Map<String, CaseInfo> caseInfoMap = new HashMap<>();
        Yaml yaml = new Yaml(new Constructor(CaseInfo.class));
        Iterable<Object> objects = yaml.loadAll(YamlParser.class.getClassLoader().getResourceAsStream(fileName));
        for (Object object : objects) {
            if (object instanceof CaseInfo) {
                caseInfoMap.put(((CaseInfo) object).getCaseId(), (CaseInfo) object);
            }
        }
        List<CaseInfo> caseInfoList = new CsvToBeanBuilder<CaseInfo>(new FileReader(YamlParser.class.getClassLoader().getResource(fileName).getFile()))
                .withType(CaseInfo.class)
                .build()
                .parse();
        Map<String, CaseInfo> map = caseInfoList.stream().collect(Collectors.toMap(CaseInfo::getCaseId, caseInfo -> caseInfo));
        new CSVReader(new FileReader(YamlParser.class.getClassLoader().getResource(fileName).getFile()));
        return caseInfoMap;
    }

}
```
YML文件的格式可以为：
```
---
caseId:
caseName:
caseDesc:
---
caseId:
caseName:
caseDesc:
```