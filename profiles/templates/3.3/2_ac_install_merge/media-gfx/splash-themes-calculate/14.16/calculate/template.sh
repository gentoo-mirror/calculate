# Calculate append=skip

for fn in *.cfg;
do
    resol=${fn%.cfg}
    width=$( echo $resol | cut -dx -f1 )
    height=$( echo $resol | cut -dx -f2 )
    orig_height=1080
    bar_width=5
    boxtop=$(( $height - $bar_width * (1000 - ( 1000 - ${height}000 / ${orig_height} ) / 25 ) / 1000 ))

cat >$fn <<EOF
# Calculate comment=#

# background image
silentpic=images/silent-${resol}.jpg

# progress bar for silent mode
box silent inter 0 ${boxtop} 0 ${height} #FFF596
box silent 0 ${boxtop} ${width} ${height} #FFF596
EOF
done
