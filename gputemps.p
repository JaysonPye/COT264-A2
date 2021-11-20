#output to png file
set terminal png size 700, 700
set output 'gputemps.png'
#Set a graphic title
set title 'Gpu temperatures during compilation'
set xlabel "Seconds"
set ylabel "GPU temperature"
#plot the graphic
plot "gputemps.dat" with lines
