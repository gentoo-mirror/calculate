# Calculate run=/bin/bash ac_install_disk==off&&pkg(x11-apps/xinit)<1.4.1-r1&&pkg(gui-libs/display-manager-init)==

rm -f /etc/X11/startDM.sh
rm -f /etc/X11/._cfg000*_startDM.sh

sed -i '/startDM.sh/d' /var/db/pkg/x11-apps/xinit-1.*/CONTENTS
