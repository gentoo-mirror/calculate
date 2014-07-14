# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#
# Original Author: © 2007-2009 Mir Calculate, Ltd. 
# Purpose: Installing linux-desktop, linux-server. 
# Build the kernel from source.

inherit calculate eutils kernel-2
EXPORT_FUNCTIONS pkg_setup src_unpack src_compile src_install pkg_postinst

IUSE="vmlinuz minimal"

REQUIRED_USE="minimal? ( vmlinuz )"

detect_version
detect_arch

if [[ ${KV_MAJOR} -ge 3 ]]
then
	CKV=$(get_version_component_range 1-3)
	CL_PATCH=$(get_version_component_range 1-2)
	local oldifs=${IFS}
	export IFS="."
	local OKV_ARRAY=( $OKV )
	export IFS=${oldifs}
	if [[ ${#OKV_ARRAY[@]} -ge 3 ]]; then
		# handle calculate-sources-3.x.y correctly
		if [[ ${KV_PATCH} -gt 0 ]]; then
			KERNEL_URI="${KERNEL_BASE_URI}/patch-${OKV}.xz"
			UNIPATCH_LIST_DEFAULT="${DISTDIR}/patch-${CKV}.xz"
		fi
		KERNEL_URI="${KERNEL_URI} ${KERNEL_BASE_URI}/linux-${KV_MAJOR}.${KV_MINOR}.tar.xz"
	else
		KERNEL_URI="${KERNEL_BASE_URI}/linux-${OKV}.tar.xz"
	fi
else
	die "Eclass is used only for kernel-3"
fi
SLOT=$(get_version_component_range 1-4)
KV_FULL="${PV}-calculate"
S="${WORKDIR}/linux-${KV_FULL}"

CALC_K_SUBV=.$(get_version_component_range 4)
[[ ${CALC_K_SUBV} == "." ]] && CALC_K_SUBV=

EXTRAVERSION="${CALC_K_SUBV}-calculate"

UNIPATCH_STRICTORDER=1

if [[ -n $LONGTERM ]];then 
	if [[ $KERNEL_URI =~ ^(.*)(kernel/v3.0/patch)(.*)$ ]];then
		KERNEL_URI="${BASH_REMATCH[1]}kernel/v3.0/longterm/v${CKV}/patch${BASH_REMATCH[3]}"
	fi
fi

calculate-kernel-5_pkg_setup() {
	kernel-2_pkg_setup
	eqawarn "!!! WARNING !!!  WARNING !!!  WARNING !!!  WARNING !!!"
	eqawarn "After the kernel assemble perform command to update modules:"
	eqawarn "  emerge @module-rebuild"
}

calculate-kernel-5_src_unpack() {
	kernel-2_src_unpack
}

vmlinuz_src_compile() {
	# disable sandbox
	export SANDBOX_ON=0
	export LDFLAGS=""
	local GENTOOARCH="${ARCH}"
	unset ARCH

	cd ${S}
	DEFAULT_KERNEL_SOURCE="${S}" CMD_KERNEL_DIR="${S}" cl-kernel \
		--ebuild \
		-o \
		${CL_KERNEL_OPTS} \
		--kerneldir=${S} \
		--set cl_kernel_cache_path=${WORKDIR}/cache \
		--set cl_kernel_temp_path=${S}/temp \
		--set cl_kernel_install_path=${WORKDIR} \
		|| die "kernel build failed"
	
	[ -f .config ] && cp .config .config.save
	make distclean &>/dev/null || die "cannot perform distclean"
	mv .config.save .config
	ARCH="${GENTOOARCH}"

	rm ${WORKDIR}/lib/modules/${KV_FULL}/build
	rm ${WORKDIR}/lib/modules/${KV_FULL}/source
}

calculate-kernel-5_src_compile() {
	use vmlinuz && vmlinuz_src_compile
}

vmlinuz_src_install() {
	cd ${WORKDIR}/lib
	insinto /lib
	doins -r modules
	insinto /usr/share/${PN}/${PV}
	doins -r firmware
	cd ${WORKDIR}
	doins -r boot
	
	dosym /usr/src/linux-${KV_FULL} \
		"/lib/modules/${KV_FULL}/source" ||
		die "cannot install source symlink"
	dosym /usr/src/linux-${KV_FULL} \
		"/lib/modules/${KV_FULL}/build" || 
		die "cannot install build symlink"
	insinto /etc/modprobe.d
}

calculate-kernel-5_src_install() {
	if use minimal
	then
		local GENTOOARCH="${ARCH}"
		unset ARCH
		ebegin "kernel: >> Running modules_prepare..."
		make modules_prepare &>/dev/null
		eend $? "Failed modules prepare"
		ARCH="${GENTOOARCH}"

		einfo "Cleaning sources"
		for rmpath in $(ls arch | grep -v x86)
		do
			rm -r arch/$rmpath
		done
		KEEPLIST="scripts/Makefile.lib scripts/module-common.lds \
			scripts/gcc-version.sh scripts/Makefile.help \
			scripts/Makefile.modinst scripts/Makefile.asm-generic \
			scripts/Makefile.modbuiltin scripts/Makefile.fwinst \
			scripts/depmod.sh scripts/Makefile.host \
			scripts/Kbuild.include scripts/Makefile.modpost \
			scripts/gcc-goto.sh scripts/Makefile.headersinst \
			scripts/Makefile.build scripts/basic/fixdep \
			scripts/Makefile.clean scripts/mod/modpost \
			include/config/kernel.release include/config/auto.conf \
			arch/x86/Makefile_32.cpu arch/x86/Makefile \
			System.map Makefile Kbuild"
		find . -type f -a \! -wholename ./.config \
			$(echo $KEEPLIST | sed -r 's/(\S+)(\s|$)/-a \! -wholename .\/\1 /g') \
			-a \! -name "*.h" -delete
		find . -type l -delete
		rm -r drivers
		rm -r Documentation
	fi
	kernel-2_src_install
	dodir /usr/share/${PN}/${PV}/boot
	use vmlinuz && vmlinuz_src_install
	if ! use vmlinuz
	then
		cp .config ${D}/usr/share/${PN}/${PV}/boot/config-${KV_FULL}
	fi
}

vmlinuz_pkg_postinst() {
	cp -p /usr/share/${PN}/${PV}/boot/* ${ROOT}/boot/
	cl-kernel --ebuild \
		-k /usr/src/linux-${KV_FULL} \
		--set cl_kernel_install_path=${ROOT}/

	mkdir -p ${ROOT}/lib/firmware
	cp -a ${ROOT}/usr/share/${PN}/${PV}/firmware/* ${ROOT}/lib/firmware/
	calculate_update_depmod
	calculate_update_modules

	[[ -f $MODULESDBFILE ]] &&
		sed -ri 's/a:1:sys-fs\/aufs2/a:0:sys-fs\/aufs2/' $MODULESDBFILE
}

calculate-kernel-5_pkg_postinst() {
	kernel-2_pkg_postinst

	KV_OUT_DIR=${ROOT}/usr/src/linux-${KV_FULL}
	if ls /usr/share/${PN}/${PV}/boot/ | grep -q System.map
	then
		cp -p /usr/share/${PN}/${PV}/boot/System.map* ${KV_OUT_DIR}/System.map
	fi
	cp -p /usr/share/${PN}/${PV}/boot/config* ${KV_OUT_DIR}/.config
	cd ${KV_OUT_DIR}

	if ! use minimal
	then
		local GENTOOARCH="${ARCH}"
		unset ARCH
		ebegin "kernel: >> Running modules_prepare..."
		(make oldconfig && make modules_prepare) &>/dev/null
		eend $? "Failed modules prepare"
		ARCH="${GENTOOARCH}"
	fi

	use vmlinuz && vmlinuz_pkg_postinst
	use vmlinuz && calculate_fix_lib_modules_contents
}
