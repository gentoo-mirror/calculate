if [[ ${EBUILD_PHASE} == setup ]]
then
	einfo "Fix files containt of previous openrc"
	sed -i '/fbcondecor/d' ${EROOT}/var/db/pkg/sys-apps/openrc-*/CONTENTS	
fi
