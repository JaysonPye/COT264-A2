#output to png file
set terminal png size 700,700
set output 'cpuusage.png'
#set graphics title
set title "CPU Usage stats during compilation"
set xlabel "Seconds"
set ylabel "Cpu usage %"
#plot different pts from the same file
plot "cpuusage.dat" using 1:2 with lines title "User level CPU %" lw 2, \
"cpuusage.dat" using 1:4 with lines title "System level CPU %" lw 2, \
"cpuusage.dat" using 1:7 with lines title "Software Interrupts CPU %" lw 2, \
"cpuusage.dat" using 1:9 with lines title "Virtual Processor CPU %" lw 2, \
"cpuusage.dat" using 1:11 with lines title "Percentage of time CPU are idle" lw 2

