# SVG output
set terminal svg size 1920,1080 dynamic font ",24"

# title
set title "Github issue ages per month in github/curl/curl" font ",48"
# where's the legend
set key top left

# Identify the axes
set xlabel "Time"
set ylabel "Number of days"

set style line 1 \
    linecolor rgb '#0060ad' \
    linetype 1 linewidth 4

set style line 2 \
    linecolor rgb '#40a03d' \
    dt 1 linewidth 4

set style line 3 \
    linecolor rgb '#f0605d' \
    dt 1 linewidth 4

set style line 4 \
    linecolor rgb '#606060' \
    dt 1 linewidth 2

set grid

# time formated using this format
set timefmt "%Y-%m-%d"
set xdata time

# limit the xrange simply because we didn't use github much before 2015
set yrange [0:]
set xrange ["2014-11-30":]

# set the format of the dates on the x axis
set format x "%b %Y"
set datafile separator ";"
plot 'tmp/gh-age.csv' using 1:2 with lines linestyle 1 title "Median age (in days) of closed issues", \
'tmp/gh-age.csv' using 1:3 with lines linestyle 2 title "Average age (in days) of closed issues"
