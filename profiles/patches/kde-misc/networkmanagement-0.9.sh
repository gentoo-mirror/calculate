if [[ ${EBUILD_PHASE} == postinst ]]
then
	einfo "Fix files containt of net-misc/networkmanager"
	sed -i '/plasma-applet-networkmanagement.desktop/d' ${EROOT}/var/db/pkg/net-misc/networkmanager-0.9.4.0-r2/CONTENTS	
fi
