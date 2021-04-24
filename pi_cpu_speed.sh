#!/bin/bash
# File: pi_cpu_speed.sh
# Author: Paul Varner 
# Date: 4-24-2021
# Description: Script to log Raspberry Pi cpu speed to pi_cpu_speed.log file.

# Add current date / time to log file
date >>/home/pi/scripts/pi_cpu_speed.log

# Execute the Raspberry Pi cpufreq scaling_cur_freq command.
i=`cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq`

# offset speed by 1000 to convert to MHZ. 
divideby=1000
cpuspeed=$(echo $divideby $i | awk '{printf "%4.0f\n",$2/$1}' )

# log Raspberry Pi CPU Speed to log file. 
echo "PI CPU Speed: $cpuspeed MHz" >>/home/pi/scripts/pi_cpu_speed.log

# add blank line to log file
echo " " >>/home/pi/scripts/pi_cpu_speed.log
