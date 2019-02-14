# Calculate format=patch
<reg>(inst_hook emergency 50 "\$moddir"/plymouth-emergency.sh
)\s*
(\s*)(inst_multiple readlink)</reg>
<text>\1
\2inst_rules /lib/udev/rules.d/71-udev-seat.rules

\2\3</text>
