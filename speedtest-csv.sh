#!/bin/bash
# File: speedtest-csv.sh
# Author: Paul Varner 
# Date: 4-24-2021
# Description: Script to send speedtest-cli csv formatted output to speedtest-csv.log file

# Start script and send date and time to speedtest-csv.log
date >> /home/pi/scripts/speedtest-csv.log

# Send speedtest command output to speedtest-csv.log
speedtest-cli --csv >> /home/pi/scripts/speedtest-csv.log

# Output an extra empty line to the speedtest-csv.log
echo " " >> /home/pi/scripts/speedtest-csv.log
