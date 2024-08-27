. /home/eirsapp/.bash_profile
#!/bin/bash
conffile=/u01/eirsapp/configuration/configuration.properties
. /home/eirsapp/.bash_profile
typeset -A config # init array

while read line
do
    if echo $line | grep -F = &>/dev/null
    then
        varname=$(echo "$line" | cut -d '=' -f 1)
        config[$varname]=$(echo "$line" | cut -d '=' -f 2-)
    fi
done < $conffile

conn1="mysql -h${config[dbIp]} -P${config[dbPort]} -u${config[dbUsername]} -p${config[dbPassword]}"
conn2="mysql -h${config[dbIp]} -P${config[dbPort]} -u${config[dbUsername]} -p${config[dbPassword]} ${config[appdbName]}"
conn3="mysql -h${config[dbIp]} -P${config[dbPort]} -u${config[dbUsername]} -p${config[dbPassword]} ${config[auddbName]}"
conn4="mysql -h${config[dbIp]} -P${config[dbPort]} -u${config[dbUsername]} -p${config[dbPassword]} ${config[oamdbName]}"

echo "creating MDR_app database."
${conn1} -e "CREATE DATABASE IF NOT EXISTS MDR_app;"
echo " MDR_app database successfully created!"

${conn2} <<EOFMYSQL
 

CREATE TABLE if not exists sys_param_list_value (
  id int NOT NULL AUTO_INCREMENT,
  created_on timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  description varchar(255) DEFAULT '',
  display_name varchar(255) DEFAULT '',
  interpretation varchar(255) DEFAULT '',
  list_order int DEFAULT '0',
   modified_on timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  tag varchar(255) DEFAULT '',
  tag_id varchar (255) DEFAULT '',
  value varchar(255) DEFAULT '',
  modified_by varchar(255) DEFAULT '',
  PRIMARY KEY (id)
);


 CREATE TABLE if not exists sys_param (
  id int NOT NULL AUTO_INCREMENT,
  created_on timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  description varchar(255) DEFAULT '',
  modified_on timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  tag varchar(255) DEFAULT '',
  type int DEFAULT '0',
  value varchar(255) DEFAULT NULL,
  active int DEFAULT '0',
  feature_name varchar(255) DEFAULT '',
  remark varchar(255) DEFAULT '',
  user_type varchar(255) DEFAULT '',
  modified_by varchar(255) DEFAULT '',
  PRIMARY KEY (id)
);



EOFMYSQL





echo "Thank You DB Process is completed now for Device Repository Module"