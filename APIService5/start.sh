
#!/bin/bash
VAR=""
DPATH="/u01/eirsapp/APIService5/"
PNAME="mdr-1.5.0.jar"
cd $DPATH 
status=`ps -ef | grep $PNAME | grep java`
if [ "$status" != "$VAR" ]
then
 echo "The process is already running"
 echo $status
else
 echo "The process is not running. Starting the process"

java -Xmx1024m -Xms256m -Dlog4j.configurationFile=./log4j2.xml -Dspring.config.location=file:./application.properties,file:${APP_HOME}/configuration/configuration.properties -jar $PNAME   1>>/u02/eirsdata/APIService5/log.log   2>>/u02/eirsdata/APIService5/error.log &

 echo "Process started"
fi
