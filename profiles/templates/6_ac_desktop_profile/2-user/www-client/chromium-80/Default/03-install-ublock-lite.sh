# Calculate pkg(www-plugins/chrome-ublock-lite)!= run=/bin/bash

plugin_id="ddkjiahejlhfcafbddmgiahcphecmpfh"
mkdir -p #-ur_home_path-#/.config/chromium/Default/Extensions/$plugin_id
mkdir -p "#-ur_home_path-#/.config/chromium/Default/Local Extension Settings" &>/dev/null
cp -r /usr/share/chrome-ublock-lite/* #-ur_home_path-#/.config/chromium/Default/Extensions/$plugin_id

/usr/share/chrome-ublock-lite/configure.py #-ur_home_path-#/.config/chromium $plugin_id &>/dev/null 

chown #-ur_login-#:#-ur_group-# -R #-ur_home_path-#/.config/chromium/Default/Extensions
chown #-ur_login-#:#-ur_group-# -R "#-ur_home_path-#/.config/chromium/Default/Local Extension Settings"
exit 0
