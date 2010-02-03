
if [[ ${EBUILD_PHASE} == postinst ]]
then	
	NEED_INFO=
	if [[ ! -L ${ROOT}/usr/local/portage/layman ]] &&
	   [[ -e ${ROOT}/usr/local/portage/layman ]]
	then
		ebegin "Move overlays"
		local res=0
		if [[ -f  ${ROOT}/usr/local/portage/layman/make.conf ]] 
		then
			sed -ri 's|/usr/local/portage/layman|/var/lib/layman|' \
				${ROOT}/usr/local/portage/layman/make.conf || res=1
		fi
		mkdir -p ${ROOT}/var/lib/layman  || res=1
		if [[ -n $(ls -A ${ROOT}/usr/local/portage/layman/) ]]
		then
			mv ${ROOT}/usr/local/portage/layman/* ${ROOT}/var/lib/layman/ || res=1
		fi
		if [[ -f ${ROOT}/etc/layman/layman.cfg ]]
		then
			sed -ri 's|^(storage\s*:\s*)\S+$|\1/var/lib/layman|' ${ROOT}/etc/layman/layman.cfg || res=1
		fi
		if [[ -f ${ROOT}/etc/layman/layman.cfg ]]
		then
			sed -ri 's|^(overlays\s*:\s*)\S+$|\1http://www.gentoo.org/proj/en/overlays/repositories.xml|' ${ROOT}/etc/layman/layman.cfg || res=1
		fi
		rm -rf ${ROOT}/usr/local/portage/layman || res=1
		ln -s /var/lib/layman ${ROOT}/usr/local/portage/layman || res=1
		NEED_INFO=1
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
		NEED_INFO=1
	fi
	if [[ -n "${NEED_INFO}" ]]
	then
		ewarn "Please reinstall eselect package:"
		ewarn "  emerge app-admin/eselect"
	fi
fi
