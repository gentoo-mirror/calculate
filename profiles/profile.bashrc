# vim: set syntax=sh
# Automatic patching. 
# put PATCH_OVERLAY=/path/to/patches into make.conf and then put patches into
# $PATCH_OVERLAY/cate-gory/package/
#
# As I know history: Initial idea from solar, later
# Ed Catmur added support autoreconf calls then pva rewritten everything...
# Added interval check for version and run .sh hooks by Calculate

PATCH_OVERLAY="/usr/local/portage/layman/calculate/patches"

pkg_checkver() {
	PATCH_PV=( `echo $1 | sed 's/[._]/ /g' | sed -r 's/([a-z]+)/ \1 /g'` )
	EBUILD_PV=( `echo $2 | sed 's/[._]/ /g' | sed -r 's/([a-z]+)/ \1 /g'` )
	for i in `seq 0 10`;
	do
		# next part of version of patch
		if [[ -n ${PATCH_PV[$i]} ]]; then
			# if part patch version not equal ebuild version
			if [[ ${PATCH_PV[$i]} != ${EBUILD_PV[$i]} ]];
			then
				# is pv in patch interval
				if [[ ${PATCH_PV[$i]} =~ ^([0-9]+)-([0-9]+)$ ]];
				then
					# check version of ebuild not in interval
					if [[ ${EBUILD_PV[$i]} -lt ${BASH_REMATCH[1]} ||
					      ${EBUILD_PV[$i]} -gt ${BASH_REMATCH[2]} ]];
					then
						return 1;
					fi
				# pv not interval
				else
					return 1;
				fi
			fi
		else
			return 0;
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
				#apecho " X  PV does not match. Skipping..."
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
		pushd `pwd` >/dev/null
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

post_pkg_postinst() {
	if [ -e "${PORTAGE_BUILDDIR}/.patched" ];then
		rm -f "${PORTAGE_BUILDDIR}/.patched"
	fi
}
