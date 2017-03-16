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
# Calculate comment=# exists(/etc/splash/calculate/images/silent-${resol}.jpg)!=||exists(/etc/splash/calculate/images/verbose-${resol}.jpg)!=

# background image
#?exists(#-ini(theme.splash-silent-background)-#)!=#
silentpic=images/silent-${resol}.jpg
#exists#
#?exists(#-ini(theme.splash-verbose-background)-#)!=#
pic=images/verbose-${resol}.jpg
#exists#
#?exists(#-ini(theme.splash-silent-background)-#)!=#
# progress bar for silent mode
#?ini(theme.splash-silent-progress-type)==fade#
box silent inter 0 ${boxtop} ${width} ${height} ##-ini(theme.splash-silent-progress-color-begin)-#
box silent 0 ${boxtop} ${width} ${height} ##-ini(theme.splash-silent-progress-color-end)-#
#!ini#
box silent inter 0 ${boxtop} 0 ${height} ##-ini(theme.splash-silent-progress-color-begin)-#
box silent 0 ${boxtop} ${width} ${height} ##-ini(theme.splash-silent-progress-color-end)-#
#ini#
#exists#
EOF
done
