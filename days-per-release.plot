# SVG output
set terminal svg size 1920,1080 dynamic font ",24"

# title
set title "Days between releases" font ",48"
# where's the legend
set key top right

# Identify the axes
set xlabel "Time"
set ylabel "Number of days"

set style line 1 \
    linecolor rgb '#c0c0ff' \
    linetype 1 linewidth 2

set style line 2 \
    linecolor rgb '#ff60ad' \
    dt 1 linewidth 4

set grid

# time formated using this format
set timefmt "%Y-%m-%d"
set xdata time

# set the format of the dates on the x axis
set format x "%Y"
set datafile separator ";"
plot 'tmp/days-per-release.csv' using 1:2 with lines linestyle 1 title "Number of days since previous release", \
 'tmp/days-per-release.csv' using 1:3 with lines linestyle 2 title "7-release Median"
