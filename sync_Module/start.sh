#!/bin/bash
source ~/.bash_profile
VAR=""
DPATH="/u01/eirsapp/MDRSyncProcess/"
PNAME="DBUpdateUtility.jar"
#PNAME="MDRProcess-1.1.0.jar"
commonConfigurationFile=$commonConfigurationFilePath
source $commonConfigurationFile
dbDecryptPassword=$(java -jar  ${APP_HOME}/encryption_utility/PasswordDecryptor-0.1.jar spring.datasource.password)
cd $DPATH 
status=`ps -ef | grep $PNAME | grep java`
if [ "$status" != "$VAR" ]
then
 echo "The process is already running"
 echo $status
else
 ProcessStatusCode=$(mysql -h$dbIp -P$dbPort $auddbName -u$dbUsername  -p${dbDecryptPassword} -se "select status_code from modules_audit_trail where created_on LIKE '%$(date +%F)%' and feature_name='GSMA to Mobile Device Repository Sync'  and status_code=200  limit 1")
 echo  "$(date +%F): Mobile Device Repository Database Sync Utility   status code= $ProcessStatusCode"
if [ $ProcessStatusCode -eq 200 ];
		then
			echo "$(date +%F_%H-%M-%S): Mobile Device Repository Database Sync Utility already completed today  going to stop this process."
			exit 0;
fi

   echo "The process is not running. Starting the process"
# java -Xmx1024m -Xms256m -Dlogging.config=./logback.xml -Dspring.config.location=file:./application.properties,file:/u01/eirsapp/configuration/configuration.properties -jar $PNAME 1>/u02/eirsdata/MDRSyncProcess/log.log 2>/u02/eirsdata/MDRSyncProcess/error.log &
 java -Xmx1024m -Xms256m -Dlog4j.configurationFile=./log4j2.xml  -Dspring.config.location=file:./application.properties,file:/u01/eirsapp/configuration/configuration.properties -jar $PNAME 1>/u02/eirsdata/MDRSyncProcess/log.log 2>/u02/eirsdata/MDRSyncProcess/error.log &
 echo "Process started"
fi
