# Calculate append=skip

for fn in *.cfg;
do
    resol=${fn%.cfg}
    width=$( echo $resol | cut -dx -f1 )
    height=$( echo $resol | cut -dx -f2 )
    orig_height=1080
    k="$(( 1000 * $height / $orig_height ))"
    boxtop=$(( $height - 3 * k / 1000 ))

cat >$fn <<EOF
# Calculate comment=#

# background image
silentpic=images/silent-${resol}.jpg

# progress bar for silent mode
box silent inter 0 ${boxtop} ${width} ${height} #cdc481
box silent 0 ${boxtop} ${width} ${height} #5a1d08
EOF
done
