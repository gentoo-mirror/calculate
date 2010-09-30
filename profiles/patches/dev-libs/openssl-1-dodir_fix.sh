if [[ ${EBUILD_PHASE} == setup ]]
then
	ln -sf /usr/lib/portage/bin/ebuild-helpers/dodir /bin/dodir
fi

if [[ ${EBUILD_PHASE} == postinst ]]
then	
	rm /bin/dodir
fi
