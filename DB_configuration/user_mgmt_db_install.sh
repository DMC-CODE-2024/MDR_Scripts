#!/bin/bash
conffile=/u01/eirsapp/configuration/configuration.properties
typeset -A config # init array

while read line
do
    if echo $line | grep -F = &>/dev/null
    then
        varname=$(echo "$line" | cut -d '=' -f 1)
        config[$varname]=$(echo "$line" | cut -d '=' -f 2-)
    fi
done < $conffile

conn1="mysql -h${config[ip]} -P${config[dbPort]} -u${config[dbUsername]} -p${config[dbPassword]}"
conn2="mysql -h${config[ip]} -P${config[dbPort]} -u${config[dbUsername]} -p${config[dbPassword]} ${config[auddbName]}"
conn3="mysql -h${config[ip]} -P${config[dbPort]} -u${config[dbUsername]} -p${config[dbPassword]} ${config[oamdbName]}"
conn="mysql -h${config[ip]} -P${config[dbPort]} -u${config[dbUsername]} -p${config[dbPassword]} ${config[appdbName]}"

echo "creating app database."
${conn1} -e "CREATE DATABASE IF NOT EXISTS app;"
echo " app database successfully created!"

${conn} <<EOFMYSQL

CREATE TABLE if not exists user_password_history (
  id int NOT NULL AUTO_INCREMENT,
  created_on datetime DEFAULT NULL,
  modified_on datetime DEFAULT NULL,
  password varchar(255) DEFAULT NULL,
  user_id int NOT NULL,
  PRIMARY KEY (id),
  KEY FK5p57sn7crshs9l6jyl524ihg7 (user_id),
  CONSTRAINT FK5p57sn7crshs9l6jyl524ihg7 FOREIGN KEY (user_id) REFERENCES user (id)
);

EOFMYSQL

echo "creating aud database."
${conn2} -e "CREATE DATABASE IF NOT EXISTS aud;"
echo " aud database successfully created!"

${conn2} <<EOFMYSQL

CREATE TABLE if not exists user_password_history_aud (
  ID int NOT NULL,
  REV int NOT NULL,
  REVTYPE int DEFAULT NULL,
  created_on timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  MODIFIED_ON timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PASSWORD varchar(255) DEFAULT NULL,
  USER_ID int DEFAULT NULL,
  PRIMARY KEY (ID,REV)
);

EOFMYSQL


echo "tables creation completed."


echo "creating oam database."
${conn3} -e "CREATE DATABASE IF NOT EXISTS oam;"
echo " oam database successfully created!"

${conn3} <<EOFMYSQL

CREATE TABLE portal_access_log (
  id int NOT NULL AUTO_INCREMENT,
  CREATED_ON timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  MODIFIED_ON timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PUBLIC_IP varchar(255) DEFAULT NULL,
  USER_AGENT varchar(255) DEFAULT NULL,
  USER_NAME varchar(255) DEFAULT NULL,
  BROWSER varchar(255) DEFAULT NULL,
  filter_public_ip varchar(255) DEFAULT NULL,
  filter_browser varchar(255) DEFAULT NULL,
  filtered_username varchar(255) DEFAULT NULL,
  PRIMARY KEY (id`)
) 

EOFMYSQL


echo "tables creation completed."

echo "                     *
						  ***
						 *****
						  ***
						   *                           "
echo "********************Thank You DB Process is completed now for the Module*****************"