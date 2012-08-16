
if [[ ${EBUILD_PHASE} == preinst ]]
then	
	sed -ri 's/(use dns)/\1\n\tafter ldap/' ${D}/etc/init.d/ejabberd
fi
