#output to png file
set terminal png size 700,700
set output 'cpufrequency.png'
#Set titles of the graphic
set title 'CPU Frequency during Compilation'
set xlabel "Seconds"
set ylabel "CPU Frequency"
#plot graphic
plot "cpufrequency.dat" with lines
