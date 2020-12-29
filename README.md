# RaspberryPiSpeedtestScripts
Raspberry PI Speedtest 

These scripts are intended to run speedtest or speedtest-cli on a raspberry pi to measure and log the speed of the user's internet.

A simple way to run these scripts on a schedule is to use the Raspberry Pi's Schedule tasks feature or crontab.  
To use the Raspberry Pi's Schedule tasks program, create a new scheduled task that launches recurrently. 
Using the Schedule tasks program, fill in a description and the command to start the speedtest.sh 
The command sudo /home/pi/scripts/speedtest.sh will work if you place speedtest.sh in the scripts directory. 
To schedule script runs every 5 minutes, paste 1,6,11,16,21,26,31,36,41,46,51,56 into the Minute box and leave * in the Hour, Day, Mounth and Weekday fields. 
