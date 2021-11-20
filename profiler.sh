#!/bin/bash
SECONDS=0
#Remove info from previously generated files
#Begin timing loop
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
	
	#Obtain memory stats and save to various files

	free | awk 'NR==2 {printf ("%.2f:%.2f:%.2f:%.2f:%.2f:%.2f:%.2f \n", "($2/1000)""($3/1000)""($4/1000)""($5/1000)""($6/1000)""($7/1000)")}'
	
	echo $memory | awk '{printf ("%.2f \n", ($9/1000))}' >> usedmemory.txt
	echo $memory | awk '{printf ("%.2f \n", ($10/1000))}' >> freememory.txt
	echo $memory | awk '{printf ("%.2f \n", ($12/1000))}' >> buffcachememory.txt
	free | awk '{printf ("%.2f \n", ($13/1000))}' >> availablememory.txt

	#save CPU usage
	mpstat | awk 'NR==4 {print $3, $4, $5, $6, $7, $8, $9, $10, $11, $12}' >> cpuusage.txt

	#Free up the CPU for 1 second until writing begins again
	sleep 1
done
