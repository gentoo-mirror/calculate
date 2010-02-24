
if [[ ${EBUILD_PHASE} == postinst ]]
then	
	if [[ -f ${ROOT}/etc/init.d/slapd ]]
	then
		# find ldap service in depend section, and if it is absend then append 'provide ldap'
		ebegin "Fix /etc/init.d/slapd"
		sed -ri '/depend/ {:b;s/\bldap\b/&/;te;s/[}]/&/;tr;N;bb;:r;s/\}/\tprovide ldap\n\}/;:e}' ${ROOT}/etc/init.d/slapd
		eend 0
	fi
fi
