
if [[ ${EBUILD_PHASE} == preinst ]]
then	
	sed -ri 's/(need net)/\1\n\tafter ldap/' ${D}/etc/init.d/named
fi
