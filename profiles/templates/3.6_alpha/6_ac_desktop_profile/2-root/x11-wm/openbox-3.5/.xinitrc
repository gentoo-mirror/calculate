# Calculate chmod=0755
xrdb -merge ~/.Xresources
#?pkg(x11-terms/rxvt-unicode)!=#
urxvt -geometry 80x24+30+30 &
#?pkg(x11-apps/xsetroot)!=#
xsetroot -solid rgb:60/99/BB
#pkg#
openbox
