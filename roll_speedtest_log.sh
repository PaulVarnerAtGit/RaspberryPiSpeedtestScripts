#!/bin/bash
# Moves daily speedtest log file to the log_history directory.
# Script also logs running of this script in the /home/pi/scripts/roll_speedtest.log file.  
# This script is intended to be run at 11:59 pm each day 

#get current  date and time
today=`date +%m-%d-%Y_%H:%M:%S`

# Create entry in roll_speedtest.log file - starting movement process.
echo 'Started move of speedtest.log to log_history folder at $today' >> /home/pi/scripts/roll_speedtest.log

# move current speedtest.log file to the log_history folder 
mv /home/pi/scripts/speedtest.log /home/pi/log_hitory/speedtest_"$today".log 

#get current  date and time
today=`date +%m-%d-%Y_%H:%M:%S`

# End entry placed in roll_speedtest.log file - ending movement process.
echo 'Move of speedtest.log to log_history folder at $today completed!' >> /home/pi/scripts/roll_speedtest.log
echo '' >> /home/pi/scripts/roll_speedtest.log
