#!/bin/bash
#speedtest.sh
# script to send speedtest csv formatted output to a log file
date >> /home/pi/scripts/speedtest-csv.log

# speedtest command
speedtest-cli --csv >> /home/pi/scripts/speedtest-csv.log

# output an extra empty line into the log file
echo " " >> /home/pi/scripts/speedtest-csv.log
