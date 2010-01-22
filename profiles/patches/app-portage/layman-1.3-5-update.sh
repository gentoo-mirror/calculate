
if [[ ${EBUILD_PHASE} == postinst ]]
then
	if [[ ! -L ${ROOT}/usr/local/portage/layman ]]
	then
		mv ${ROOT}/usr/local/portage/layman/* ${ROOT}/var/lib/layman/
		sed -ri 's|^(storage\s*:\s*)\S+$|\1/var/lib/layman|' ${ROOT}/etc/layman/layman.cfg
		sed -ri 's|^(overlays\s*:\s*)\S+$|\1http://www.gentoo.org/proj/en/overlays/repositories.xml|' ${ROOT}/etc/layman/layman.cfg
		rm -rf ${ROOT}/usr/local/portage/layman
		ln -s /var/lib/layman ${ROOT}/usr/local/portage/layman
	fi
fi
