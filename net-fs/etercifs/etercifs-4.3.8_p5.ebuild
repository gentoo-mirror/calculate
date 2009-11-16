# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit linux-mod eutils linux-info

CIFSVER=${PV%_p*}
ETER_REV=${PV#*_p}

DESCRIPTION="Advanced Common Internet File System for Linux with Etersoft extension"
HOMEPAGE="http://etersoft.ru/wine"
SRC_URI="ftp://anonymous@updates.etersoft.ru/pub/Etersoft/CIFS%40Etersoft/${CIFSVER}/sources/etercifs-${CIFSVER}-eter${ETER_REV}.tar.bz2
ftp://ftp.cregion.ru/etersoft/cifs@etersoft/sources/etercifs-${CIFSVER}-eter${ETER_REV}.tar.bz2"
LICENSE="GPL-2"
KEYWORDS="-* x86 amd64"
IUSE="kernel_linux"

DEPEND="kernel_linux? ( virtual/linux-sources )"

pkg_setup() {
	kernel_is lt 2 6 23 && die "Current kernel 2.6.x is not supported by this ebuild." 
	kernel_is gt 2 6 30 && die "Current kernel 2.6.x is not supported by this ebuild." 
	if use kernel_linux ; then
		MODULE_NAMES="etercifs(etercifs:${WORKDIR}/cifs)"
		CONFIG_CHECK="CIFS"

		linux-mod_pkg_setup
		kernel_is 2 4 && die "kernel 2.4 is not supported by this ebuild. Get an older version from viewcvs"

		BUILD_PARAMS="-C ${KERNEL_DIR} M=${WORKDIR}/cifs"
		BUILD_TARGETS="modules"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	mkdir cifs
	kern_arch_prefix='kernel-source-etercifs-2.6'
	kernel_is 2 6 23 && kern_suffix='23-1.50'
	kernel_is 2 6 24 && kern_suffix='24-1.52'
	kernel_is 2 6 25 && kern_suffix='25-1.52'
	kernel_is 2 6 26 && kern_suffix='26-1.53'
	kernel_is 2 6 27 && kern_suffix='27-1.54'
	kernel_is 2 6 28 && kern_suffix='28-1.55'
	kernel_is 2 6 29 && kern_suffix='29-1.57'
	kernel_is 2 6 30 && kern_suffix='30-1.58'
	mv "${kern_arch_prefix}.${kern_suffix}"/* cifs/
	S="${WORKDIR}/cifs"
	cd "${WORKDIR}/cifs"
	sed -i 's/#define CIFS_VERSION.*"1.*"/#define CIFS_VERSION "4.3.8"/' cifsfs.h
}

src_compile() {
	if use kernel_linux ; then
		cd "${WORKDIR}/cifs"
		linux-mod_src_compile
	fi
}

src_install() {

	if use kernel_linux ; then
		linux-mod_src_install
	fi

}

pkg_preinst() {
	KERN_MOD="/lib/modules/$(uname -r)"
	find "${KERN_MOD}" -name cifs.ko | gawk '{print $1,$1".orig"}' | xargs mv
}

pkg_postinst() {
	use kernel_linux && linux-mod_pkg_postinst
	
	elog ""
	elog "Don't forget to add module etercifs to /etc/modules.autoload.d/kernel-2.6"
	elog "and switch off the Linux Extensions for cifs by adding:"
	elog ""
}
