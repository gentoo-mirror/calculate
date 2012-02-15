# Calculate path=/tmp pkg(www-apps/chromium-adblock)!= exec=/bin/bash name=adblock-fix-#-ur_login-#.sh

if [[ -d #-ur_home_path-#/.config/chromium/Default/Extensions/gighmmpiobklfepjocnamgkkbiglidom ]]
then
    chown #-ur_login-#:#-ur_group-# -R #-ur_home_path-#/.config/chromium/Default/Extensions/gighmmpiobklfepjocnamgkkbiglidom &>/dev/null
fi
exit 0
