
if [[ ${EBUILD_PHASE} == postinst ]]
then
	if [[ ! -L ${ROOT}/usr/local/portage/layman ]] &&
	   [[ -e ${ROOT}/usr/local/portage/layman ]]
	then
		ebegin "Move overlays"
		local res=0
		sed -ri 's|/usr/local/portage/layman|/var/lib/layman|' ${ROOT}/usr/local/portage/layman/make.conf || res=1
		mv ${ROOT}/usr/local/portage/layman/* ${ROOT}/var/lib/layman/ || res=1
		sed -ri 's|^(storage\s*:\s*)\S+$|\1/var/lib/layman|' ${ROOT}/etc/layman/layman.cfg || res=1
		sed -ri 's|^(overlays\s*:\s*)\S+$|\1http://www.gentoo.org/proj/en/overlays/repositories.xml|' ${ROOT}/etc/layman/layman.cfg || res=1
		rm -rf ${ROOT}/usr/local/portage/layman || res=1
		ln -s /var/lib/layman ${ROOT}/usr/local/portage/layman || res=1
		eend $res
	fi
	MAKEPROFILELINK=$( readlink ${ROOT}/etc/make.profile )
	if [[ "$MAKEPROFILELINK" =~ usr/local/portage/layman ]] 
	then
		ebegin "Fix make.profile link"
		rm -f /etc/make.profile &&
		ln -sf ${MAKEPROFILELINK/usr\/local\/portage\/layman/var\/lib\/layman} \
			/etc/make.profile
		eend $? "Cann't fix make.profile link"
	fi
fi
