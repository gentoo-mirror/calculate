# Calculate append=skip

for fn in *.cfg;
do
    resol=${fn%.cfg}
    width=$( echo $resol | cut -dx -f1 )
    height=$( echo $resol | cut -dx -f2 )
    orig_height=1080
    k="$((1000 - ( 1000 - ${height}000 / ${orig_height} ) / 25 )) / 1000"
    text_x=$(( $width / 2 ))
    text_y=$(( $height / 2 - 20 * $k ))
    text_size=$(( 20 * $k ))
    k2="$(( 1000 * $height / $orig_height ))"
    boxtop=$(( $height - 3 * k2 / 1000 ))

cat >$fn <<EOF
# Calculate comment=# exists(/etc/splash/calculate_shutdown/images/silent-${resol}.jpg)!=

# background image
silentpic=images/silent-${resol}.jpg

# Coords of system messages
text_x=${text_x}
text_y=${text_y}
text_align middle middle

# system messages font size
text_size=${text_size}

# System messages color in format [0x|#]rrggbb, or [0x|#]rrggbbaa
text_color=0x#-ini(theme.splash-shutdown-text-color)-#

# Path to TTF font, for system messages. Path may be:
text_font=DroidSans.ttf

#progress bar for silent mode
#?ini(theme.splash-shutdown-progress-type)==fade#
box silent inter 0 ${boxtop} ${width} ${height} ##-ini(theme.splash-shutdown-progress-color-begin)-#
box silent 0 ${boxtop} ${width} ${height} ##-ini(theme.splash-shutdown-progress-color-end)-#
#!ini#
box silent inter 0 ${boxtop} 0 ${height} ##-ini(theme.splash-shutdown-progress-color-begin)-#
box silent 0 ${boxtop} ${width} ${height} ##-ini(theme.splash-shutdown-progress-color-end)-#
#ini#

EOF

cat >${fn}.remove <<EOF
# Calculate append=remove name=${fn} exists(/etc/splash/calculate_shutdown/images/silent-${resol}.jpg)==
EOF
done
