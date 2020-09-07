# Calculate chmod=0755
#!/bin/bash

DPI="$(sed -nr '/name="dpi"/{n;s/[^0-9]+//gp}' ~/.config/fontconfig/fonts.conf)"

[[ $DPI =~ ^[0-9]+$ ]] && xrandr --dpi $DPI
exit 0
