#output to png file
set terminal png size 700,700
set output 'memorystats.png'
#set graphics title
set title 'Memory stats during compilation'
set xlabel "Seconds"
set ylabel "Memory in MB"
#plot from different files
plot "freememory.dat" with lines title "Free Memory" lw 3, \
"buffcachememory.dat" with lines title "Buff/Cached Memory" lw 3, \
"availablememory.dat" with lines title "Available Memory" lw 3, \
"usedmemory.dat" with lines title "Used Memory" lw 3

