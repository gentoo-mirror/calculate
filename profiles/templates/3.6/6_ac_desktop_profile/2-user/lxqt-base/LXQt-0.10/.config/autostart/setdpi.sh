# Calculate chmod=0755
#!/bin/bash

DPI="$(sed -nr '/name="dpi"/{n;s/[^0-9]+//gp}' ~/.config/fontconfig/fonts.conf)"

if [[ $DPI =~ ^[0-9]+$ ]]
then
    xrandr --dpi $DPI
    resfile=~/.Xresources
    if grep "Xft.dpi" $resfile &>/dev/null
    then
        sed -i "s/^Xft.dpi:.*/Xft.dpi: $DPI/" $resfile
    else
        echo "Xft.dpi: $DPI" >>$resfile
    fi
    xrdb -load $resfile
fi

exit 0
