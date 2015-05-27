# Calculate append=skip

for fn in *.cfg;
do
    resol=${fn%.cfg}
    width=$( echo $resol | cut -dx -f1 )
    height=$( echo $resol | cut -dx -f2 )
    orig_height=1080
    boxtop=$(( $height - 2 ))

cat >$fn <<EOF
# Calculate comment=#

# background image
silentpic=images/silent-${resol}.jpg

# progress bar for silent mode
box silent inter 0 ${boxtop} 0 ${height} #ffdfa0
box silent 0 ${boxtop} ${width} ${height} #ffdfa0
EOF
done
