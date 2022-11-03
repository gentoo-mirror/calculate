# Calculate chmod=0755 path=/usr/libexec/calculate
#!/bin/bash

/usr/bin/synclient TapButton2=2 TapButton3=3

/usr/bin/xinput list --name-only | grep -i touchpad | while read line
do
	/usr/bin/xinput set-int-prop "$line" "Synaptics Tap Action" 8 0 0 0 0 1 2 3
done
