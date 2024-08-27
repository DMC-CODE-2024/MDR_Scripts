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
${conn1} -e "CREATE DATABASE IF NOT EXISTS app;"
echo " MDR_app database successfully created!"

${conn2} <<EOFMYSQL
 CREATE TABLE if not exists mobile_device_repository (
  id int NOT NULL AUTO_INCREMENT,
  allocation_date timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  announce_date timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  band_detail varchar(50) DEFAULT '',
  battery_capacity int DEFAULT '0',
  battery_charging varchar(100) DEFAULT '',
  battery_type varchar(50) DEFAULT '',
  body_dimension varchar(50) DEFAULT '',
  body_weight varchar(20) DEFAULT '',
  brand_name varchar(50) DEFAULT '',
  color varchar(100) DEFAULT NULL,
  comms_bluetooth varchar(100) DEFAULT '',
  comms_gps  varchar(100) DEFAULT '',
  comms_nfc int DEFAULT '0',
  comms_radio int DEFAULT '0',
  comms_usb varchar(50) DEFAULT '',
  comms_wlan varchar(100) DEFAULT '',
  created_on timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  custom_price_of_device double DEFAULT '0',
  device_id varchar(8) DEFAULT '0',
  device_state int DEFAULT '0',
  device_status varchar(20) DEFAULT '',
  device_type varchar(50) DEFAULT '',
  discontinue_date timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  display_protection varchar(50) DEFAULT '',
  display_resolution varchar(50) DEFAULT '',
  display_size varchar(50) DEFAULT '',
  display_type varchar(50) DEFAULT '',
  esim_support int DEFAULT '0',
  imei_quantity int DEFAULT '0',
  launch_date timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  launch_price_asian_market double DEFAULT '0',
  launch_price_cambodia_market double DEFAULT '0',
  launch_price_europe_market double DEFAULT '0',
  launch_price_international_market double DEFAULT '0',
  launch_price_us_market double DEFAULT '0',
  main_camera_feature varchar(50) DEFAULT '',
  main_camera_spec varchar(50) DEFAULT '',
  main_camera_type int DEFAULT '0',
  main_camera_video varchar(50) DEFAULT '',
  manufacturer varchar(100) DEFAULT '',
  manufacturing_location varchar(100) DEFAULT '',
  marketing_name varchar(150) DEFAULT '',
  memory_card_slot int DEFAULT '0',
  memory_internal int DEFAULT '0',
  model_name varchar(50) DEFAULT '',
  modified_on timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  network_2g_band varchar(100) DEFAULT '',
  network_3g_band varchar(100) DEFAULT '',
  network_4g_band varchar(100) DEFAULT '',
  network_5g_band varchar(100) DEFAULT '',
  network_6g_band varchar(100) DEFAULT '',
  network_7g_band varchar(100) DEFAULT '',
  network_speed varchar(100) DEFAULT '',
  network_technology_5g int DEFAULT '0',
  network_technology_6g int DEFAULT '0',
  network_technology_7g int DEFAULT '0',
  network_technology_cdma int DEFAULT '0',
  network_technology_evdo int DEFAULT '0',
  network_technology_gsm int DEFAULT '0',
  network_technology_lte int DEFAULT '0',
  nonremovable_euicc int DEFAULT '0',
  nonremovable_uicc int DEFAULT '0',
  oem varchar(100) DEFAULT '',
  organization_id varchar(25) DEFAULT '',
  os varchar(50) DEFAULT '',
  os_base_version varchar(50) DEFAULT '',
  platform_cpu varchar(100) DEFAULT '',
  platform_chipset varchar(100) DEFAULT '',
  platform_gpu varchar(50) DEFAULT '', 
  ram varchar(20) DEFAULT '',
  remark varchar(1000) DEFAULT '',
  removable_euicc int DEFAULT '0',
  removable_uicc int DEFAULT '0',
  reported_global_issue varchar(255) DEFAULT '',
  reported_local_issue varchar(255) DEFAULT '',
  selfie_camera_feature varchar(50) DEFAULT '',
  selfie_camera_spec varchar(50) DEFAULT '',
  selfie_camera_type int DEFAULT '0',
  selfie_camera_video varchar(50) DEFAULT '',
  sensor varchar(50) DEFAULT '',
  sim_slot int DEFAULT '0',
  sim_type varchar(15) DEFAULT '',
  softsim_support int DEFAULT '0',
  sound_3_5mm_jack int DEFAULT '0',
  sound_loudspeaker int DEFAULT '0',
  source_of_cambodia_market_price varchar(100) DEFAULT '',
  user_id int DEFAULT '0',
  is_test_imei int DEFAULT '0',
  os_current_version varchar(50) DEFAULT '',
  network_specific_identifier int DEFAULT '0',
  trc_approved_status varchar(50) DEFAULT NULL,
  approvedBy varchar(50) DEFAULT NULL,
  trc_approval_date timestamp NULL DEFAULT NULL,
  is_type_approved int DEFAULT '0',
  manufacturer_country varchar(50) DEFAULT '',
  trc_type_approved_by varchar(50) DEFAULT '',
  PRIMARY KEY (id),
  UNIQUE KEY device_id (device_id),
  KEY mdr_modified_on_index (modified_on),
  KEY mdr_created_on_index (created_on)
);

insert into sys_param(created_on, modified_on, description, tag, feature_name, value, active) values(CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Security by pass url', 'WHITELIST_API', 'API Gateway', '/login', 1);
insert into sys_param(created_on, modified_on, description, tag, feature_name, value, active) values(CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Security by pass url', 'WHITELIST_API', 'API Gateway', '/v2/api-docs', 1);
insert into sys_param(created_on, modified_on, description, tag, feature_name, value, active) values(CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Security by pass url', 'WHITELIST_API', 'API Gateway', '/configuration/ui', 1);
insert into sys_param(created_on, modified_on, description, tag, feature_name, value, active) values(CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Security by pass url', 'WHITELIST_API', 'API Gateway', '/swagger-resources/**', 1);
insert into sys_param(created_on, modified_on, description, tag, feature_name, value, active) values(CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Security by pass url', 'WHITELIST_API', 'API Gateway', '/configuration/security', 1);
insert into sys_param(created_on, modified_on, description, tag, feature_name, value, active) values(CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Security by pass url', 'WHITELIST_API', 'API Gateway', '/swagger-ui.html', 1);
insert into sys_param(created_on, modified_on, description, tag, feature_name, value, active) values(CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Security by pass url', 'WHITELIST_API', 'API Gateway', '/webjars/**', 1);
insert into sys_param(created_on, modified_on, description, tag, feature_name, value, active) values(CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Security by pass url', 'WHITELIST_API', 'API Gateway', '/addDevice', 1);
insert into sys_param(created_on, modified_on, description, tag, feature_name, value, active) values(CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Security by pass url', 'WHITELIST_API', 'API Gateway', '/deleteDevice', 1);
insert into sys_param(created_on, modified_on, description, tag, feature_name, value, active) values(CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Security by pass url', 'WHITELIST_API', 'API Gateway', '/getDeviceHistory', 1);
insert into sys_param(created_on, modified_on, description, tag, feature_name, value, active) values(CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Security by pass url', 'WHITELIST_API', 'API Gateway', '/getMDRDashboardData', 1);
insert into sys_param(created_on, modified_on, description, tag, feature_name, value, active) values(CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Security by pass url', 'WHITELIST_API', 'API Gateway', '/updateDevices', 1);
insert into sys_param(created_on, modified_on, description, tag, feature_name, value, active) values(CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Security by pass url', 'WHITELIST_API', 'API Gateway', '/getDevicesDetails', 1);
insert into sys_param(created_on, modified_on, description, tag, feature_name, value, active) values(CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Security by pass url', 'WHITELIST_API', 'API Gateway', '/exportData', 1);
insert into sys_param(created_on, modified_on, description, tag, feature_name, value, active) values(CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Security by pass url', 'WHITELIST_API', 'API Gateway', '/getDeviceInfo', 1);
insert into sys_param(created_on, modified_on, description, tag, feature_name, value, active) values(CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Security by pass url', 'WHITELIST_API', 'API Gateway', '/getDeviceHistoryInfo', 1);
insert into sys_param(created_on, modified_on, description, tag, feature_name, value, active) values(CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Security by pass url', 'WHITELIST_API', 'API Gateway', '/getDeviceHistoryInfo', 1);
insert into sys_param(created_on, modified_on, description, tag, feature_name, value, active) values(CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Security by pass url', 'WHITELIST_API', 'API Gateway', '/getDistinctUserName', 1);
insert into sys_param(created_on, modified_on, description, tag, feature_name, value, active) values(CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Security by pass url', 'WHITELIST_API', 'API Gateway', '/getDistinctDeviceType', 1);
insert into sys_param(created_on, modified_on, description, tag, feature_name, value, active) values(CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Security by pass url', 'WHITELIST_API', 'API Gateway', '/getManufacturerCountry', 1);

CREATE TABLE mdr_manufacturing_country (
  id int NOT NULL AUTO_INCREMENT,
  country_name varchar(100) DEFAULT '',
  created_on timestamp NULL DEFAULT NULL,
  PRIMARY KEY (id)
);

insert into mdr_manufacturing_country (country_name,created_on) values ('China',now());

insert into mdr_manufacturing_country (country_name,created_on) values ('India',now());

insert into mdr_manufacturing_country (country_name,created_on) values ('Japan',now());

insert into mdr_manufacturing_country (country_name,created_on) values ('Taiwan',now());
 
CREATE TABLE if not exists dev_brand_name (
  id int NOT NULL AUTO_INCREMENT,
  created_on timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  brand_name varchar(50) DEFAULT '',
  PRIMARY KEY (id)
);

CREATE TABLE if not exists dev_model_name (
  id int NOT NULL AUTO_INCREMENT,
  brand_name varchar(50) DEFAULT '',
  brand_name_id int DEFAULT '0',
  created_on timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  model_name varchar(50) DEFAULT '',
  PRIMARY KEY (id)
);

CREATE TABLE if not exists mdr_attached_file_info (
  id int NOT NULL AUTO_INCREMENT,
  doc_type varchar(255) DEFAULT '',
  file_name varchar(255) DEFAULT '',
  mdr_id int DEFAULT NULL,
  PRIMARY KEY (id)
);


LOCK TABLES sys_param_list_value WRITE;
INSERT ignore INTO sys_param_list_value (display_name,interpretation,list_order,tag,value) values ('ESIM Support','Yes', 1, 'ESIM_SUPPORT', 1),('ESIM Support','No', 2, 'ESIM_SUPPORT', 0),('SOFTSIM Support','Yes', 1, 'SOFTSIM_SUPPORT', 1),('SOFTSIM Support','No', 2, 'SOFTSIM_SUPPORT', 0),('Network Technology GSM','Yes', 1, 'NETWORK_TECHNOLOGY_GSM', 1),('Network Technology GSM','No', 2, 'NETWORK_TECHNOLOGY_GSM', 0),('Network Technology CDMA','Yes', 1, 'NETWORK_TECHNOLOGY_CDMA', 1),('Network Technology CDMA','No', 2, 'NETWORK_TECHNOLOGY_CDMA', 0),('Network Technology EVDO','Yes', 1, 'NETWORK_TECHNOLOGY_EVDO', 1),('Network Technology EVDO','No', 2, 'NETWORK_TECHNOLOGY_EVDO', 0),('Network Technology LTE','Yes', 1, 'NETWORK_TECHNOLOGY_LTE', 1),('Network Technology LTE','No', 2, 'NETWORK_TECHNOLOGY_LTE', 0),('Network Technology 5G','Yes', 1, 'NETWORK_TECHNOLOGY_5G', 1),('Network Technology 5G','No', 2, 'NETWORK_TECHNOLOGY_5G', 0),('Network Technology 6G','Yes', 1, 'NETWORK_TECHNOLOGY_6G', 1),('Network Technology 6G','No', 2, 'NETWORK_TECHNOLOGY_6G', 0),('Network Technology 7G','Yes', 1, 'NETWORK_TECHNOLOGY_7G', 1),('Network Technology 7G','No', 2, 'NETWORK_TECHNOLOGY_7G', 0),('Main Camera Type','Single Camera', 1, 'MAIN_CAMERA_TYPE', 1),('Main Camera Type','Dual Camera', 2, 'MAIN_CAMERA_TYPE', 2),('Main Camera Type','Triple Camera', 3, 'MAIN_CAMERA_TYPE', 3),('Selfie Camera Type','Single Camera', 1, 'SELFIE_CAMERA_TYPE', 1),('Selfie Camera Type','Dual Camera', 2, 'SELFIE_CAMERA_TYPE', 2),('Selfie Camera Type','Triple Camera', 3, 'SELFIE_CAMERA_TYPE', 3),('Sound Loudspeaker','Yes', 1, 'SOUND_LOUDSPEAKER', 1),('Sound Loudspeaker','No', 2, 'SOUND_LOUDSPEAKER', 0),('Sound 3.5MM Jack','Yes', 1, 'SOUND_3.5MM_JACK', 1),('Sound 3.5MM Jack','No', 2, 'SOUND_3.5MM_JACK', 0),('COMMS NFC','Yes', 1, 'COMMS_NFC', 1),('COMMS NFC','No', 2, 'COMMS_NFC', 0),('COMMS Radio','Yes', 1, 'COMMS_RADIO', 1),('COMMS Radio','No', 2, 'COMMS_RADIO', 0),('Memory card slot','Yes', 1, 'MEMORY_CARD_SLOT', 1),('Memory card slot','No', 2, 'MEMORY_CARD_SLOT', 0),('Multi SIM Staus','1',1,'MULTI_SIM_STATUS',1),('Multi SIM Staus','2',2,'MULTI_SIM_STATUS',2),('Multi SIM Staus','3',3,'MULTI_SIM_STATUS',3),('Multi SIM Staus','4',4,'MULTI_SIM_STATUS',4),('Available','MDR_DEVICE_STATUS',1,'MDR_DEVICE_STATUS',1),('Unavailable','Unavailable',2,'MDR_DEVICE_STATUS',2);
UNLOCK TABLES;


LOCK TABLES sys_param WRITE;
INSERT ignore INTO sys_param (description,tag,type,value,active) values ('Maximum number of document that can be uploaded at the time of adding a Device','device_supporting_doc_count',1,5,0);
UNLOCK TABLES;
EOFMYSQL

echo "creating MDR_aud database."
${conn1} -e "CREATE DATABASE IF NOT EXISTS aud;"
echo " MDR_aud database successfully created!"

${conn3} <<EOFMYSQL
CREATE TABLE if not exists  modules_audit_trail (
  id int NOT NULL AUTO_INCREMENT,
  created_on timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  modified_on timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  execution_time int DEFAULT '0',
  status_code int DEFAULT '0',
  status varchar(100) DEFAULT NULL,
  error_message varchar(255) DEFAULT '',
  module_name varchar(50) DEFAULT '',
  feature_name varchar(50) DEFAULT '',
  action varchar(20) DEFAULT '',
  count int DEFAULT '0',
  info varchar(255) DEFAULT '',
  server_name varchar(30) DEFAULT '',
  count2 int DEFAULT '0',
  failure_count int DEFAULT '0',
  PRIMARY KEY (id)
);



EOFMYSQL


echo "Thank You DB Process is completed now for Device Repository Module"