# Calculate run=/bin/bash ac_install_disk==off

rm -f /etc/X11/startDM.sh
rm -f /etc/X11/._cfg000*_startDM.sh

sed -i '/startDM.sh/d' /var/db/pkg/x11-apps/xinit-1.*/CONTENTS
