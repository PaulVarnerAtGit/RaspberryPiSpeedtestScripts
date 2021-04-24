#!/bin/bash
# File: pi_cpu_speed_short.sh
# Author: Paul Varner 
# Date: 4-24-2021
# Description: Script displays Raspberry Pi cpu speed.

# Display date / time to log file
date 

# Execute the Raspberry Pi cpufreq scaling_cur_freq command to capture CPU Speed
i=`cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq`

# Offset speed by 1000 for display in MHZ.
divideby=1000
cpuspeed=$(echo $divideby $i | awk '{printf "%4.0f\n",$2/$1}' )

# Display Raspberry Pi CPU Speed.
echo "PI CPU Speed: $cpuspeed MHz" 
