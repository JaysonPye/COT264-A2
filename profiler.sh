#!/bin/bash


SECONDS=0
#Begin timing loop
#Function to be used in order to finalize data, call GNUplot scripts and exit gracefully.
function plotAndExit()
{
	paste - - <cputemps.txt > cputemps.dat
	paste - - <cpufrequency.txt > cpufrequency.dat
	paste - - <gputemps.txt > gputemps.dat
	paste - - <usedmemory.txt > usedmemory.dat
	paste - - <freememory.txt > freememory.dat
	paste - - <buffcachememory.txt > buffcachememory.dat
	paste - - <availablememory.txt > availablememory.dat
	paste - - <cpuusage.txt > cpuusage.dat
	echo "\n"
	echo "Plotting graphs and exiting."
	exit 1
}
#Trap to be used for both SIGINT and USR1 signal to call exit function.
trap 'plotAndExit' USR1
trap 'plotAndExit' SIGINT

#Remove old txt and dat files if they exist so that data isnt appended
rm cputemps.txt gputemps.txt usedmemory.txt freememory.txt buffcachememory.txt availablememory.txt cpufrequency.txt cpuusage.txt 2> /dev/null
rm cputemps.dat gputemps.dat usedmemory.dat freememory.dat buffcachememory.dat availablememory.dat cpufrequency.dat cpuusage.dat 2>/dev/null

#Begin the loop to obtain data
while true
do
	#Save seconds to txt files
	echo $SECONDS | tee -a cputemps.txt gputemps.txt usedmemory.txt freememory.txt buffcachememory.txt availablememory.txt cpufrequency.txt >> cpuusage.txt
	#Save CPU temperatures to a file
	cpuTemp=$(</sys/class/thermal/thermal_zone0/temp)
	echo $cpuTemp | awk -F= '{printf ("%.2f \n", ($1/1000))}'>> cputemps.txt

	#Edit data and save CPU frequency to a file
	frequency=$(vcgencmd measure_clock arm)
	echo $frequency | awk -F= '{printf ("%.2f \n", ($2/1000000000))}' >> cpufrequency.txt

	#Save GPU temp to a file
	vcgencmd measure_temp | awk -F= '{printf("%.2f \n", ($2))}' >> gputemps.txt
	
	#Obtain memory stats and save to various files

	free | awk 'NR==2 {printf ("%.2f \n", ($3/1000))}' >> usedmemory.txt
	free | awk 'NR==2 {printf ("%.2f \n", ($4/1000))}' >> freememory.txt
	free | awk 'NR==2 {printf ("%.2f \n", ($6/1000))}' >> buffcachememory.txt
	free | awk 'NR==2 {printf ("%.2f \n", ($7/1000))}' >> availablememory.txt

	#save CPU usage
	mpstat | awk 'NR==4 {print $3, $4, $5, $6, $7, $8, $9, $10, $11, $12}' >> cpuusage.txt

	#Free up the CPU for 1 second until writing begins again
	sleep 1
done

