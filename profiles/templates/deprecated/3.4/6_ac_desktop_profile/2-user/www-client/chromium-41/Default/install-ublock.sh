# Calculate pkg(www-plugins/chrome-ublock)!= exec=/bin/bash

mkdir -p #-ur_home_path-#/.config/chromium/Default/Extensions/cjpalhdlnbpafiamejdnhcphjbkeiagm
cp -r /usr/share/chrome-ublock/* #-ur_home_path-#/.config/chromium/Default/Extensions/cjpalhdlnbpafiamejdnhcphjbkeiagm
chown #-ur_login-#:#-ur_group-# -R #-ur_home_path-#/.config/chromium/Default/Extensions
exit 0
