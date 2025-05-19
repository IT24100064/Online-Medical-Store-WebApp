@echo off
echo Starting Tomcat with custom configuration...
set CATALINA_HOME=F:\Java\Tomcat 9.0_Tomcat9B
set CATALINA_BASE=.smarttomcat\Online-Medical-Store-WebApp
set JAVA_HOME=C:\Program Files\Java\jdk-22

echo Using custom server.xml with different ports
copy /Y .smarttomcat\Online-Medical-Store-WebApp\conf\server-custom.xml .smarttomcat\Online-Medical-Store-WebApp\conf\server.xml

echo Starting Tomcat...
"%CATALINA_HOME%\bin\catalina.bat" run -config .smarttomcat\Online-Medical-Store-WebApp\conf\server.xml

echo Tomcat started. Access your application at http://localhost:8081/onlineMedicalStore
