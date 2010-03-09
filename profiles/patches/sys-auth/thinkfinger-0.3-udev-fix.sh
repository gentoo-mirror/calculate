
if [[ ${EBUILD_PHASE} == postinst ]]
then	
	sed -ri 's/SYSFS/ATTRS/gi' ${ROOT}/etc/udev/rules.d/60-thinkfinger.rules
fi
