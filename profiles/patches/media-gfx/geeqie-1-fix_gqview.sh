if [[ ${EBUILD_PHASE} == postinst ]]
then
	einfo "Fix files containt of media-gfx/gqview"
	sed -i '/calculate-imageview.desktop/d' ${EROOT}/var/db/pkg/media-gfx/gqview/gqview-2.1.5/CONTENTS
fi
