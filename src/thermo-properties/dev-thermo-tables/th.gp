reset
set terminal x11 noraise
#set terminal postscript eps color enhanced
#set output 'cucu.eps'

set title 'Sample Separate Y-Axis Plot' font 'Default,16'
set xlabel 'Solution Time, t [s]' font 'Default,14'
set ylabel 'Lift, L [N]' font 'Default,14'
set y2label 'Drag, D [N]' font 'Default,14'
set ytics nomirror # don't mirror primary ytics to opposite
set y2tics         # activates secondary ytics
set key reverse Left samplen 2 # prints key entries line first, then title
                               # samplen adjust length the lines for each entry

set format x '%.4f' # sets the format of the tic marks for given axis (x here), f for floating
set format y '%.2f'
set format y2 '%.2f'
plot \
     'th.dat' u 1:2 axes x1y1 w lines lw 1.5 lc 3 t 'Lift' #, \
#     'th.dat' u 1:2 axes x1y2 w linesp lw 1.5 ps 1.5 pt 5 pi 10 t 'Drag'

# w stands for "with".  Valid options include: "lines", "points", "linesp" (short for "linespoints")
# lw adjusts the line width (default is 1)
# lc adjusts the line color (see .png for list)
# ps adusts the size of the symbols (default is 1)
# pt sets the point type (see .png for list)
# pi sets the interval at which symbols will be printed
#
# If you want to make an eps replace the set terminal line with the following:
# set terminal postscript eps color enhanced
# set output 'cucu.eps'
#
# When making an eps it is important to note that the linetypes will be different from when using
# X11 -- X11 does not show the various dashed line types found in the .png.  If you wish to specify
# a given linetype, it can be set by including lt followed by the linetype number (as indicated in
# the .png) when plotting a file
#

