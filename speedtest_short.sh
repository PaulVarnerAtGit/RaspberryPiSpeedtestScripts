#!/bin/bash
# File: speedtest_short.sh
# Author: Paul Varner 
# Date: 4-24-2021
# Description: Short script that calls speedtest-cli and outputs to the console.  

# Start script and display date and time
date

# speedtest command
speedtest-cli --simple

# End script display date and time
date
