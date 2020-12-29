#!/bin/bash
#speedtest.sh
#Script that runs /usr/local/bin/speedtest --simple and captures the output to speedtest_temp.log, copies output to speedtest.log, 
# calls /home/pi/scripts/load_speedtest_data_record.sh to load data into a database, 
# and finally removes speedtest_temp.log.   

#log current date and time into new speedtest_temp.log file
date > /home/pi/scripts/speedtest_temp.log

#execute speedtest executable 
#/usr/local/bin/speedtest --simple >> /home/pi/scripts/speedtest_temp.log
/usr/local/bin/speedtest-cli --simple >> /home/pi/scripts/speedtest_temp.log

#log current date and time into new speedtest_temp.log file
date >> /home/pi/scripts/speedtest_temp.log

#add trailing spaces to log file
echo " " >> /home/pi/scripts/speedtest_temp.log
echo " " >> /home/pi/scripts/speedtest_temp.log

#copy speedtest_temp.log file into speedtest.log file
cat /home/pi/scripts/speedtest_temp.log >> /home/pi/scripts/speedtest.log 

#load data record into mysql database  
/home/pi/scripts/load_speedtest_data_record.sh /home/pi/scripts/speedtest_temp.log

#clean up temp log file
rm /home/pi/scripts/speedtest_temp.log
