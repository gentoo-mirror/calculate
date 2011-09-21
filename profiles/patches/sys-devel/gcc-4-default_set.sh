# autoswitch to new gcc
if [[ ${EBUILD_PHASE} == postinst ]]
then
	einfo "The current gcc config will be automatically switch to the newly"
	einfo "installed gcc version ${GCC_CONFIG_VER}"
	gcc-config ${CTARGET}-${GCC_CONFIG_VER} &>/dev/null
fi

