# Changing extraversion of kernel

if [[ ${EBUILD_PHASE} == compile ]]; then
	einfo "Changing kernel extraversion"
	sed -ri 's/^(EXTRAVERSION\s+=\s+)-gentoo-r([0-9]+)/\1.\2-calculate/' ${S}/Makefile 
fi
