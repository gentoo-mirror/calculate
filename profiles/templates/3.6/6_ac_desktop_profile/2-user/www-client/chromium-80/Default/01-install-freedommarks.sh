# Calculate pkg(www-plugins/chrome-freedommarks)!=&&ini(user_credentials.nextcloud_url)!=&&ini(user_credentials.nextcloud_login)!=&&ini(user_credentials.nextcloud_pw)!= run=/bin/bash

plugin_id="gmmpjoepfelkmeedfkfkadgkhholibko"
mkdir -p #-ur_home_path-#/.config/chromium/Default/Extensions/${plugin_id}
mkdir -p "#-ur_home_path-#/.config/chromium/Default/Local Extension Settings" &>/dev/null
cp -r /usr/share/chrome-freedommarks/* #-ur_home_path-#/.config/chromium/Default/Extensions/$plugin_id

/usr/share/chrome-freedommarks/configure.py #-ur_home_path-#/.config/chromium $plugin_id &>/dev/null <<EOF
{
    "freedommarks_settings": "{\"bookmark_main_tab\":false,\"password\":\"#-ini(user_credentials.nextcloud_pw)-#\",\"search_main_tab\":true,\"server_url\":\"#-ini(user_credentials.nextcloud_url)-#\",\"username\":\"#-ini(user_credentials.nextcloud_login)-#\"}"
}
EOF

chown #-ur_login-#:#-ur_group-# -R #-ur_home_path-#/.config/chromium/Default/Extensions
chown #-ur_login-#:#-ur_group-# -R "#-ur_home_path-#/.config/chromium/Default/Local Extension Settings"
exit 0
