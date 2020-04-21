# Calculate pkg(www-plugins/chrome-passman)!=&&ini(user_credentials.nextcloud_url)!=&&ini(user_credentials.nextcloud_login)!=&&ini(user_credentials.nextcloud_pw)!=&&ini(user_credentials.passman_id)!=&&ini(user_credentials.passman_guid)!=&&ini(user_credentials.passman_name)!=&&ini(user_credentials.passman_pw)!= run=/bin/bash
plugin_id="hlpjhlifkgmoibhollggngbbhbejecph"
mkdir -p #-ur_home_path-#/.config/chromium/Default/Extensions/${plugin_id}
mkdir -p "#-ur_home_path-#/.config/chromium/Default/Local Extension Settings" &>/dev/null
cp -r /usr/share/chrome-passman/* #-ur_home_path-#/.config/chromium/Default/Extensions/$plugin_id

/usr/share/chrome-passman/configure.py #-ur_home_path-#/.config/chromium $plugin_id calculate <<EOF
{
    "master_password": "\"calculate\"",
    "settings": {
    "accounts":[
        {"nextcloud_host": "#-ini(user_credentials.nextcloud_url)-#", "nextcloud_username": "#-ini(user_credentials.nextcloud_login)-#", "nextcloud_password": "#-ini(user_credentials.nextcloud_pw)-#",
        "vault": {
            "vault_id": #-ini(user_credentials.passman_id)-#, "guid": "#-ini(user_credentials.passman_guid)-#",
            "name": "#-ini(user_credentials.passman_name)-#", "created": 1565763829,
            "last_access": 1571036310, "delete_request_pending": false},
        "vault_password": "#-ini(user_credentials.passman_pw)-#"}],
"debug": false, "enableAutoFill": true, "enableAutoSubmit": false, "enablePasswordPickerr": true, "generatedPasswordLength": 12, "ignorePath": true, "ignoreProtocol": true, "ignoreSubdomain": true, "ignored_sites": [], "refreshTime": 60, "remember_password": true}, "activeTab": "\"search\""
}
EOF

chown #-ur_login-#:#-ur_group-# -R #-ur_home_path-#/.config/chromium/Default/Extensions
chown #-ur_login-#:#-ur_group-# -R "#-ur_home_path-#/.config/chromium/Default/Local Extension Settings"
exit 0
