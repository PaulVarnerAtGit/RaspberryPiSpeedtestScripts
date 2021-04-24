#!/bin/bash
# File: roll_speedtest_log.sh
# Author: Paul Varner 
# Date: 4-24-2021
# Description: Moves daily speedtest log file to the log_history directory.
# Script also logs running of this script in the /home/pi/scripts/roll_speedtest.log file.  
# This script is intended to be run at Midnight (11:59 pm each day) 

# Load current  date and time into today variable
today=`date +%m-%d-%Y_%H:%M:%S`

# Create entry in roll_speedtest.log file - starting movement process.
echo 'Started move of speedtest.log to log_history folder at $today' >> /home/pi/scripts/roll_speedtest.log

# Move current speedtest.log file to the log_history folder 
mv /home/pi/scripts/speedtest.log /home/pi/log_hitory/speedtest_"$today".log 

#get current end date and time
today=`date +%m-%d-%Y_%H:%M:%S`

# End date and time entry placed in roll_speedtest.log file - Ends file movement process.
echo 'Move of speedtest.log to log_history folder at $today completed!' >> /home/pi/scripts/roll_speedtest.log
echo '' >> /home/pi/scripts/roll_speedtest.log
