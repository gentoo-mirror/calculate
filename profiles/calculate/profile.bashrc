# vim: set syntax=sh
# Automatic patching. 
# put PATCH_OVERLAY=/path/to/patches into make.conf and then put patches into
# $PATCH_OVERLAY/cate-gory/package/
#
# As I know history: Initial idea from solar, later
# Ed Catmur added support autoreconf calls then pva rewritten everything...
# Added interval check for version and run .sh hooks by Calculate

pkg_checkver() {
	PATCH_PV=( `echo $1 | sed 's/[._]/ /g' | sed -r 's/([a-z]+)/ \1 /g'` )
	EBUILD_PV=( `echo $2 | sed 's/[._]/ /g' | sed -r 's/([a-z]+)/ \1 /g'` )
	for i in $(seq 0 10);
	do
		# next part of version of patch
		if [[ -n ${PATCH_PV[$i]} ]]
			then
			# if part patch version not equal ebuild version
			if [[ ${PATCH_PV[$i]} != ${EBUILD_PV[$i]} ]]
			then
				# is pv in patch interval
				if [[ ${PATCH_PV[$i]} =~ ^([0-9]+)-([0-9]+)$ ]]
				then
					# check version of ebuild not in interval
					if [[ ${EBUILD_PV[$i]} -lt ${BASH_REMATCH[1]} ||
					      ${EBUILD_PV[$i]} -gt ${BASH_REMATCH[2]} ]]
					then
						return 1
					fi
				# pv not interval
				else
					return 1
				fi
			fi
		else
			return 0
		fi
	done
	return 0
}

pkg_try2apply() {
	local patch=${1}
	for l in `seq 0 4`; do
		patch -g0 --dry-run -p${l} >/dev/null < "${patch}"
		if [ $? = 0 ]; then
			echo "auto patching succeeded (-p${l}) ${patch}" > "${S}/.$(basename ${patch})"
			#patch -g0 -p${l} < "${patch}"  && return 0
			patch -g0 -p${l} < "${patch}" > /dev/null && return 0
		fi
	done
	return 1
}

apecho() {
	:
	#echo "AP: ${@}"
}

pkg_pick_patches() {
	apecho " *  entering pick_patches ${1}"
	pushd "${1}" > /dev/null 2>&1
	local VERSION='(-(cvs[.])?[0-9]+([.][0-9]+(-[0-9]+)?)*[a-z]?(_(pre|p|beta|alpha|rc)[0-9]*)*)?'
	for f in *${PN}*; do
		[[ ! -e ${f} ]] && continue
		apecho " >  processing file: ${f}."
		if [[ ${f} =~ ^(..-)?${PN}${VERSION}(-r[0-9]+)?(_[0-9a-zA-Z-]+_)?([0-9a-zA-Z_.-]+[.](${patch_extens}))?$ ]]; then
			local MATCHED_PV=${BASH_REMATCH[2]/-}
			local MATCHED_PR=${BASH_REMATCH[7]/-}
			local MATCHED_ARCH=${BASH_REMATCH[8]//_}
			local MATCHED_EXT=${BASH_REMATCH[10]}
			apecho " |  parsed: PV=$MATCHED_PV, PR=$MATCHED_PR, ARCH=$MATCHED_ARCH, ext=$MATCHED_EXT."
			if [[ -n ${MATCHED_ARCH} && ( ${MATCHED_ARCH} != ${ARCH} && ${MATCHED_ARCH} != all ) ]]; then
				apecho " X  ARCH does not match. Skipping..."
				continue
			fi
			if [[ -n ${MATCHED_PR} && ${MATCHED_PR} != ${PR} ]]; then
				apecho " X  PR does not match. Skipping..."
				continue
			fi
			if [[ -n ${MATCHED_PV} ]] && ! pkg_checkver ${MATCHED_PV} ${PV}; then
				apecho " X  PV=${MATCHED_PV} does not match. Skipping..."
				continue
			fi
			if [[ -d ${f} ]]; then
				apecho " -> $f is a direcrory. Delving..."
				pkg_pick_patches ${f}
				apecho "<-  Back. Continuing..."
				continue

			elif [[ -z ${MATCHED_EXT} ]]; then
				apecho " X  Is $f a file without patch|diff extension. Skipping."
				continue
			fi
			apecho " +  Adding '$(pwd)/${f}' to patches."
			patches=( "${patches[@]}" "$(pwd)/${f}")
		fi
	done
	popd > /dev/null
	apecho " <  ${patches[@]}"
}

pkgpatch() {
	local -a patches=()
	local -i runautomake=0 runautoconf=0
	[[ ! -d "${PATCH_OVERLAY}/${CATEGORY}" ]] && return 0
	# only in precompile phase find patches and hooks
	if [[ ${EBUILD_PHASE} == compile ]]; then
		local patch_extens="diff|patch|sh"
	# in other phases find only hooks
	else
		local patch_extens="sh"
	fi
	pkg_pick_patches "${PATCH_OVERLAY}/${CATEGORY}"
	apecho " !  GRAND RESULT: ${patches[@]}"
	# before unpack phase ${S} yet not present
	if ! pushd "${S}" &>/dev/null;then
		pushd "`pwd`" >/dev/null
	fi
	for patch in "${patches[@]}"; do
		if [[ $patch =~ \.sh$ ]];
		then
			source $patch
		else
			ebegin "Trying to apply $(basename ${patch})"
			if pkg_try2apply "${patch}"; then
				eend 0
			else
				eend 1
				continue
			fi
		fi
		if grep -E '^[+][+][+][[:space:]]+.*Makefile[.]am[[:space:]]+.*$' "${patch}" >/dev/null; then
			einfo "Need to rerun automake"
			(( ++runautomake ))
		fi
		if grep -E '^[+][+][+][[:space:]]+.*configure[.](ac|in)[[:space:]]+.*$' "${patch}">/dev/null; then
			einfo "Need to rerun autoconf"
			(( ++runautoconf ))
		fi
	done
	if [[ ${runautomake} -gt 0 || ${runautoconf} -gt 0 ]]; then
		inherit autotools
	fi
	if [[ ${runautomake} -gt 0 && ${runautoconf} -gt 0 ]]; then
		eautoreconf
	elif [[ ${runautomake} -gt 0 ]]; then
		eautomake
	elif [[ ${runautoconf} -gt 0 ]]; then
		eautoconf		
	fi
	popd > /dev/null
}

[ -d /var/db/pkg/sys-apps/calculate-core-3.1.[1-9]* ] && calcver=3.1.1

post_pkg_preinst() {
	CL_UPDATE_PROG=/usr/lib/calculate-2.2/calculate-lib/bin/cl-update-config
	if [ -e ${CL_UPDATE_PROG} ];then
		[[ -z ${CONFIG_PROTECT} && -e /etc/profile ]] && source /etc/profile
		CONFIG_PROTECT=${CONFIG_PROTECT} ${CL_UPDATE_PROG} --desktop --system --pkg_version ${PVR} --pkg_category ${CATEGORY} --path ${D} $PN
	fi
	CL_UPDATE_PROG=/usr/sbin/cl-core-setup
	if [ -e ${CL_UPDATE_PROG} ] && [[ -z $calcver ]]
	then
		${CL_UPDATE_PROG} --no-progress --pkg-version ${PVR} --pkg-category ${CATEGORY} --pkg-path ${D} --pkg-name ${PN}
	fi
}

post_pkg_postinst() {
	if [ -e "${PORTAGE_BUILDDIR}/.patched" ];then
		rm -f "${PORTAGE_BUILDDIR}/.patched"
	fi
}

pre_pkg_postinst() {
	if [[ -n $calcver ]]
	then
		CL_UPDATE_PROG=/usr/sbin/cl-core-setup
		if [ -e ${CL_UPDATE_PROG} ];then
			${CL_UPDATE_PROG} --no-progress --pkg-version ${PVR} --pkg-slot ${SLOT} --pkg-category ${CATEGORY} --pkg-path "/" --pkg-name ${PN}
		fi
	fi
	rm -f /var/lib/calculate/-merge-$PN-*
	rm -f /var/lib/calculate/-CONTENTS-*
}

CL_CORE_PATCH=/usr/sbin/cl-core-patch
if [[ ${EBUILD_PHASE} == "compile" ]] && [ -e ${CL_CORE_PATCH} ] &&
    [[ -d ${S} ]];then
	${CL_CORE_PATCH} --no-progress --pkg-version ${PVR} --pkg-slot ${SLOT} --pkg-category ${CATEGORY} --pkg-path ${S} --pkg-name ${PN} --verbose
else
	if [[ `readlink -f /etc/portage/bashrc` != "/usr/calculate/install/bashrc" ]] || [[ ! -f /etc/portage/bashrc ]]
	then
		PATCH_OVERLAY="/usr/local/portage/layman/calculate/profiles/patches"
		[[ -d "/var/lib/layman/calculate/profiles/patches" ]] && \
			PATCH_OVERLAY="/var/lib/layman/calculate/profiles/patches"
		PATH=${PATH}:/usr/sbin:/usr/bin:/bin:/sbin
	
		if [[ ${EBUILD_PHASE} == compile ]]; then
			if [[ ! -f ${PORTAGE_BUILDDIR}/.patched || \
				( ${PORTAGE_BUILDDIR}/.unpacked -nt ${PORTAGE_BUILDDIR}/.patched ) ]]; then
				touch "${PORTAGE_BUILDDIR}/.patched"
			elif [[ "${PORTAGE_BUILDDIR}/.unpacked" -nt "${PORTAGE_BUILDDIR}/.patched" ]]; then
				einfo ">>> WORKDIR is up-to-date and patched, keeping..."
			fi
		fi

		pkgpatch
	fi
fi

# Update configuration files for package installation
if [[ ${EBUILD_PHASE} == setup ]]; then
    userBashrc="/etc/portage/bashrc"
    if [[ -f /etc/portage/bashrc ]] &&
       grep -q -e "function\s+post_pkg_preinst" -e "post_pkg_preinst\(\)" $userBashrc &&
       ! grep -q "calculate_post_pkg_preinst" $userBashrc;
    then 
        ewarn ""
        ewarn "!!! WARNING !!!  WARNING !!!  WARNING !!!  WARNING !!!"
        ewarn "Redeclaration post_pkg_reinst was detected in ${useBashrc}."
        ewarn "Remove it for correct package configuration."
        inherit eutils
        ebeep 5
    fi
fi

# added for calculate2.2
# FUNC: change_permissions
# DESC: change permissions for all files and directories into specified
change_permissions() {
	local directory=$1
	[[ -d $1 ]] || return
	
	# get owner from parent directory
	addwrite ${directory}
	local dirowner=$(stat -c"%u:%g" ${directory})
	local dirmode=0$(stat -c%a ${directory})
	# get permissions from parent directory
	local dirmode=0$(stat -c%a ${directory})
	
	# turnoff execute for all (permission for files in parent directory)
	if which bc &>/dev/null;
	then
		local filemode=0$(echo "obase=8;$(( $dirmode & 0666 ))" | bc)
	elif which printf &>/dev/null;
	then
		local filemode=$(printf "0%o" $(( $dirmode & 0666 )) )
	else
		local filemode=
	fi
	# set for all files and directories dirowner
	chown -R ${dirowner} ${directory}
	# set permissions for all directories in parent directory
	find ${directory} \! -perm ${dirmode} -type d -exec chmod ${dirmode} {} \;
	if [[ -n $filemode ]]
	then
		# set permissions for all files in parent directory
		find ${directory} \! -perm ${filemode} -type f -exec chmod ${filemode} {} \;
	fi
}

# system has "remote" share
if grep "\[remote\]" /etc/samba/smb.conf &>/dev/null
then
    post_src_unpack() {
        einfo "Performing permissions change for distdir directory"
        change_permissions ${PORTAGE_ACTUAL_DISTDIR}
    }
else
    post_src_unpack() {
        :
    }
fi

if grep "\[remote\]" /etc/samba/smb.conf &>/dev/null
then
    pre_pkg_preinst() {
        einfo "Performing permissions change for packages directory"
        change_permissions ${PKGDIR}
    }
else
    pre_pkg_preinst() {
        :
    }
fi

# prerm functions
if [[ $EBUILD_PHASE == "preinst" ]]
then
	[[ ! -d /var/lib/calculate ]] && mkdir /var/lib/calculate
	touch /var/lib/calculate/-merge-$PN-$SLOT-$PPID
fi


if [[ $EBUILD_PHASE == "postrm" ]]
then
	if [[ ! -f /var/lib/calculate/-merge-$PN-$SLOT-$PPID ]]
	then
		if [[ -n $calcver ]]
		then
			CL_UPDATE_PROG=/usr/sbin/cl-core-setup
			if [ -e ${CL_UPDATE_PROG} ];then
				${CL_UPDATE_PROG} --no-progress --pkg-version ${PVR} --pkg-slot ${SLOT} --pkg-category ${CATEGORY} --pkg-path / --pkg-name ${PN}
			fi
		fi
	else
		cp /var/db/pkg/${CATEGORY}/${PF}/CONTENTS /var/lib/calculate/-CONTENTS-$PN
	fi
	rm -f /var/lib/calculate/-merge-$PN-*
fi
