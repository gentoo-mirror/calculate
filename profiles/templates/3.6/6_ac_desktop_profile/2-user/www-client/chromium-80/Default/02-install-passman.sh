# Calculate pkg(www-plugins/chrome-passman)!=&&ini(user_credentials.nextcloud_url)!=&&ini(user_credentials.nextcloud_login)!=&&ini(user_credentials.nextcloud_pw)!=&&ini(user_credentials.passman_id)!=&&ini(user_credentials.passman_guid)!=&&ini(user_credentials.passman_name)!=&&ini(user_credentials.passman_pw)!= run=/bin/bash
plugin_id="hlpjhlifkgmoibhollggngbbhbejecph"
mkdir -p #-ur_home_path-#/.config/chromium/Default/Extensions/${plugin_id}
mkdir -p "#-ur_home_path-#/.config/chromium/Default/Local Extension Settings" &>/dev/null
cp -r /usr/share/chrome-passman/* #-ur_home_path-#/.config/chromium/Default/Extensions/$plugin_id

#?ini(user_credentials.passman_master_pw)!=#
MASTER_PW="#-ini(user_credentials.passman_master_pw)-#"
#!ini#
MASTER_PW="calculate"
#ini#

/usr/share/chrome-passman/configure.py #-ur_home_path-#/.config/chromium $plugin_id $MASTER_PW &>/dev/null <<EOF
{
#?ini(user_credentials.passman_pw_remember)==on#
    "master_password": "\"$MASTER_PW\"",
#ini#
    "settings": {
    "accounts":[
        {
		"nextcloud_host": "#-ini(user_credentials.nextcloud_url)-#",
		"nextcloud_username": "#-ini(user_credentials.nextcloud_login)-#",
		"nextcloud_password": "#-ini(user_credentials.nextcloud_pw)-#",
		"vault": {
			    "vault_id": #-ini(user_credentials.passman_id)-#,
			    "guid": "#-ini(user_credentials.passman_guid)-#",
            		    "name": "#-ini(user_credentials.passman_name)-#"
		},
        	"vault_password": "#-ini(user_credentials.passman_pw)-#"}],
        "debug": false,
        "enableAutoFill": true,
        "enableAutoSubmit": false,
        "enablePasswordPickerr": true,
        "generatedPasswordLength": 12,
        "ignorePath": true,
        "ignoreProtocol": true,
        "ignoreSubdomain": false,
        "ignored_sites": [],
#?ini(user_credentials.passman_pw_remember)==on#
        "remember_password": true,
#ini#
        "refreshTime": 60
    },
    "activeTab": "\"search\""
}
EOF

chown #-ur_login-#:#-ur_group-# -R #-ur_home_path-#/.config/chromium/Default/Extensions
chown #-ur_login-#:#-ur_group-# -R "#-ur_home_path-#/.config/chromium/Default/Local Extension Settings"
exit 0
