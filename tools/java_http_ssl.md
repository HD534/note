/home/ituser/jdk1.8.0_192/jre/bin/keytool -import -trustcacerts -alias "issue_ca_apigw" -file ./AIA-GOEQXPWICA010-CA.cer -keystore  /home/ituser/jdk1.8.0_192/jre/lib/security/cacerts -storepass "changeit"

/home/ituser/jdk1.8.0_192/jre/bin/keytool -importcert -trustcacerts -alias "root_ca_apigw" -file ./AIA-GOEQXPWRCA010-CA.cer -keystore /home/ituser/jdk1.8.0_192/jre/lib/security/cacerts -storepass "changeit"


/home/ituser/jdk1.8.0_192/jre/bin/keytool -importcert -trustcacerts -alias "issue_ca_apigw" -file ./AIA-GOEQXPWICA010-CA.cer -keystore /home/ituser/jdk1.8.0_192/jre/lib/security/cacerts 
/home/ituser/jdk1.8.0_192/jre/bin/keytool -importcert -trustcacerts -alias "root_ca_apigw" -file ./AIA-GOEQXPWRCA010-CA.cer -keystore /home/ituser/jdk1.8.0_192/jre/lib/security/cacerts



---------uat
/home/hemcuvd5/cdc_onperm/jdk1.8.0_192/jre/bin/keytool -importcert -trustcacerts -alias "issue_ca_apigw" -file ./AIA-GOEQXPWICA010-CA.cer -keystore /home/hemcuvd5/cdc_onperm/jdk1.8.0_192/jre/lib/security/cacerts

--check cert
https://www.sslshopper.com/article-most-common-java-keytool-keystore-commands.html

/pr1/java/jre-8/bin/keytool -list -v -keystore /pr1/java/jre-8/lib/security/cacerts -alias "root_ca_apigw"


---generate .keystore

openssl pkcs12 -export -inkey prod.aiaazure.biz.key -in prod_sslcert.cer -out ./tomcat.keystore
