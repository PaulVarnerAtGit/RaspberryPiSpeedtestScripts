#!/bin/bash
# File: speedtest.sh
# Author: Paul Varner 
# Date: 4-24-2021
# Description: Script that runs /usr/local/bin/speedtest --simple 
# and captures the output to speedtest_temp.log, copies output to speedtest.log, 
# calls /home/pi/scripts/load_speedtest_data_record.sh to load data into a database, 
# and finally removes speedtest_temp.log.   

# Start script and send date and time into new speedtest_temp.log file
date > /home/pi/scripts/speedtest_temp.log

# Send speedtest command output to speedtest_temp.log
/usr/local/bin/speedtest-cli --simple >> /home/pi/scripts/speedtest_temp.log

# Log end date and time to speedtest_temp.log file
date >> /home/pi/scripts/speedtest_temp.log

# Add trailing spaces to to speedtest_temp.log file
echo " " >> /home/pi/scripts/speedtest_temp.log
echo " " >> /home/pi/scripts/speedtest_temp.log

# Append speedtest_temp.log file contents into speedtest.log file
cat /home/pi/scripts/speedtest_temp.log >> /home/pi/scripts/speedtest.log 

# Load data record into mysql database  
/home/pi/scripts/load_speedtest_data_record.sh /home/pi/scripts/speedtest_temp.log

# Remove speedtest_temp.log 
rm /home/pi/scripts/speedtest_temp.log
