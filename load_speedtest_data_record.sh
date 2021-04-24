#!/bin/bash
#load_speedtest_data_record.sh
#Shell script to read speedtest log file, parses the file, and loads them into a database.
# Initially configured for the MY_SPEED_TEST table in MY_DATABASE.
#echo "Shell script to load speedtest data into mysql database"

#input(value passed in on command line as first parameter $1.
# the file speedtestrecord.log passes the following information from the last speedtest script run. 
#  
# Wed Jan  1 22:43:38 EST 2020
# Ping: 22.751 ms
# Download: 0.37 Mbit/s
# Upload: 9.82 Mbit/s
# Wed Jan  1 22:45:06 EST 2020
# 

input=$1 

#defines all initial values for the script variables
DB_USER='user'; # Fill in your db username
DB_PASSWD='password'; # Fill in your db password 
DB_NAME='MY_DATABASE'; # Fill in your db name
TABLE='NEW_SPEED_TEST'; # Fill in your db table name 

first_date=''
second_date=''
ping=''
download=''
upload=''
notes='DB: 10.83.85.115 1st PI Test' # static text added to notes db field.  

while IFS= read line
do		
	#echo "$line"
	VAR_LENGTH=${#line}		
	if [ $VAR_LENGTH -gt "2" ] ; then 					
		prefix_value=$(echo "${line}" | cut -c1-4) #parse off the first 4 characters		
		if [ $prefix_value = "Ping" ] ; then				
			ping=$(echo "${line}" | cut -c7-12) #parse off ping value
			#echo "Found Ping->$ping<-"
			
		elif [ $prefix_value = "Down" ] ; then					
			download=$(echo "${line}" | cut -c11-15) #parse off download value			
			#echo "Found Download->$download<-"
			
		elif [ $prefix_value = "Uplo" ] ; then	
			upload=$(echo "${line}" | cut -c9-13) #parse off upload  value			
			#echo "Found Upload->$upload<-"
			
		elif [ ${#VAR_LENGTH} > 22 ] ; then #Found line with date information		
	
			#remove extra spaces between values
			line=$(echo $line | sed 's/[ ]*$//'  )	
			VAR_LENGTH_MINUS_SPACES=${#line}		
	
			#parse month
			date_month=$(echo "${line}" | cut -c5-7) # find month 			
			if [ $date_month = "Jan" ] ; then
				found_month='01'
			elif [ $date_month = "Feb" ] ; then 			
				found_month='02'
			elif [ $date_month = "Mar" ] ; then  			
				found_month='03'
			elif [ $date_month = "Apr" ] ; then 			
				found_month='04'
			elif [ $date_month = "May" ] ; then  			
				found_month='05'
			elif [ $date_month = "Jun" ] ; then  			
				found_month='06'
			elif [ $date_month = "Jul" ] ; then 			
				found_month='07'
			elif [ $date_month = "Aug" ] ; then  
				found_month='08'
			elif [ $date_month = "Sep" ] ; then 
				found_month='09'
			elif [ $date_month = "Oct" ] ; then 
				found_month='10'
			elif [ $date_month = "Nov" ] ; then 
				found_month='11'
			elif [ $date_month = "Dec" ] ; then  			
				found_month='12'
			else 
				found_month='99'
			fi									
	
			#parse day of month
			if [ $VAR_LENGTH_MINUS_SPACES -eq '27' ] ; then
				#1 digit day					
				date_day=$(echo "${line}" | cut -c9) # find day
				date_day=$(echo "0$date_day") # add leading 0 to single digit date
	
				#parse hour
				date_hour=$(echo "${line}" | cut -c11-12) # find date hour value			
				date_minute=$(echo "${line}" | cut -c14-15) # find date minute value			
				date_second=$(echo "${line}" | cut -c17-18) # find date second value
				date_year=$(echo "${line}" | cut -c24-27) # find date year value											
				
			else
				#2 digit day
				date_day=$(echo "${line}" | cut -c9-10) # find day
				
				#parse hour
				date_hour=$(echo "${line}" | cut -c12-13) # find date hour value			
				date_minute=$(echo "${line}" | cut -c15-16) # find date minute value			
				date_second=$(echo "${line}" | cut -c18-19) # find date second value	
				date_year=$(echo "${line}" | cut -c25-28) # find date year value											
				
			fi  
						
			if [ ${#first_date} -eq 0 ] ; # found first_date is initially set to 0. 
			then
				#YYYY-MM-DD HH:MM:SS				
				first_date=$(echo "$date_year-$found_month-$date_day $date_hour:$date_minute:$date_second")
				found_first_date='1'				
				
			else # found second_date				
				second_date=$(echo "$date_year-$found_month-$date_day $date_hour:$date_minute:$date_second")				

				if [ ${#first_date} -gt 0 -a ${#second_date} -gt 0 -a ${#ping} -gt 0 -a ${#download} -gt 0 -a ${#upload} -gt 0 ] ; 				
				then									
					SQL_INSERT="INSERT INTO $TABLE ( SPEEDTEST_START_DATE, PING, DOWNLOAD_SPEED, UPLOAD_SPEED, SPEEDTEST_END_DATE, NOTES) VALUES ( '$first_date', '$ping', '$download', '$upload', '$second_date' , '$notes');"
					echo $SQL_INSERT | mysql -u$DB_USER -p$DB_PASSWD $DB_NAME;															
				fi 				
				first_date=''
				second_date=''				
				ping=''
				download='' 
				upload=''
				date_year='' 
				#echo ""					
			fi									
		fi		
	fi	
	
done < "$input"
