#output to png file
set terminal png size 700,700
set output 'cputemps.png'
#Set title of the graphic
set title 'Cpu temperatures during compilation'
set xlabel "Seconds"
set ylabel "CPU temperature"
#plot graphic
plot "cputemps.dat" with lines

