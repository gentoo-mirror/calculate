# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit rpm linux-mod eutils linux-info

DESCRIPTION="Advanced Common Internet File System for Linux with Etersoft extension"
HOMEPAGE="http://etersoft.ru/wine"
SRC_URI="ftp://anonymous@updates.etersoft.ru/pub/Etersoft/CIFS%40Etersoft/${PV}/sources/etercifs-${PV}-alt1.src.rpm"
LICENSE="GPL-2"
KEYWORDS="-* x86 ~amd64"
IUSE="kernel_linux"

DEPEND="kernel_linux? ( virtual/linux-sources )"

pkg_setup() {
	kernel_is lt 2 6 23 && die "Current kernel 2.6.x is not supported by this ebuild." 
	kernel_is gt 2 6 29 && die "Current kernel 2.6.x is not supported by this ebuild." 
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
	rpm_unpack "${DISTDIR}/${A}"
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
	tar -xjf "${kern_arch_prefix}.${kern_suffix}.tar.bz2"
	mv "${kern_arch_prefix}.${kern_suffix}"/* cifs/
	S="${WORKDIR}/cifs"
}

src_compile() {
ln -s /lib/modules/`uname -r`/build/arch/x86 /lib/modules/`uname -r`/build/arch/amd64
	if use kernel_linux ; then
		cd "${WORKDIR}/cifs"
		linux-mod_src_compile
	fi
}

src_install() {
    mkdir -p ${D}/etc
    echo DATADIR=/usr/share/${PN} > ${D}/etc/${PN}.conf
    echo SRC_DIR=/usr/src/${P} >> ${D}/etc/${PN}.conf
    echo MODULENAME=${PN} >> ${D}/etc/${PN}.conf
    echo MODULEVERSION=${PV} >> ${D}/etc/${PN}.conf

    mkdir -p ${D}/usr/share/${PN}
    install -m755 ${FILE2_URI}buildmodule.sh ${D}/usr/share/${PN}
    install -m755 ${FILE2_URI}functions.sh ${D}/usr/share/${PN}

    mkdir -p ${D}/usr/sbin
    install -m755 ${FILE5_URI}/etermount ${D}/usr/sbin/etermount
    mkdir -p ${D}/etc/init.d
    mkdir -p ${D}/etc/conf.d
    install -m755 ${FILE3_URI}/etercifs ${D}/etc/init.d/etercifs
    install -m755 ${FILE3_URI}/etercifs.outformat ${D}/etc/init.d/etercifs.outformat
    install -m755 ${FILE3_URI}/etercifs ${D}/etc/conf.d/etercifs
    install -m755 ${FILE3_URI}/etercifs.outformat ${D}/etc/conf.d/etercifs.outformat


    ETERCIFS_SRC="usr/share/${PN}/sources"

    mkdir -p ${D}/${ETERCIFS_SRC}

    cp ${FILE_URI}/${SRC_PN}-2.6.16-${SRC_2_6_1623_VER}.tar.bz2 ${D}/${ETERCIFS_SRC}/${SRC_PN}-2.6.16-${SRC_2_6_1623_VER}.tar.bz2
    cp ${FILE_URI}/${SRC_PN}-2.6.23-${SRC_2_6_1623_VER}.tar.bz2 ${D}/${ETERCIFS_SRC}/${SRC_PN}-2.6.23-${SRC_2_6_1623_VER}.tar.bz2
    cp ${FILE_URI}/${SRC_PN}-2.6.24-${SRC_2_6_2425_VER}.tar.bz2 ${D}/${ETERCIFS_SRC}/${SRC_PN}-2.6.24-${SRC_2_6_2425_VER}.tar.bz2
    cp ${FILE_URI}/${SRC_PN}-2.6.25-${SRC_2_6_2425_VER}.tar.bz2 ${D}/${ETERCIFS_SRC}/${SRC_PN}-2.6.25-${SRC_2_6_2425_VER}.tar.bz2
    cp ${FILE_URI}/${SRC_PN}-2.6.26-${SRC_2_6_26_VER}.tar.bz2 ${D}/${ETERCIFS_SRC}/${SRC_PN}-2.6.26-${SRC_2_6_26_VER}.tar.bz2
    cp ${FILE_URI}/${SRC_PN}-2.6.27-${SRC_2_6_27_VER}.tar.bz2 ${D}/${ETERCIFS_SRC}/${SRC_PN}-2.6.27-${SRC_2_6_27_VER}.tar.bz2
    cp ${FILE_URI}/${SRC_PN}-2.6.28-${SRC_2_6_28_VER}.tar.bz2 ${D}/${ETERCIFS_SRC}/${SRC_PN}-2.6.28-${SRC_2_6_28_VER}.tar.bz2
    cp ${FILE_URI}/${SRC_PN}-2.6.29-${SRC_2_6_29_VER}.tar.bz2 ${D}/${ETERCIFS_SRC}/${SRC_PN}-2.6.29-${SRC_2_6_29_VER}.tar.bz2

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
    mkdir -p ${D}/etc
    echo DATADIR=/usr/share/${PN} > ${D}/etc/${PN}.conf
    echo SRC_DIR=/usr/src/${P} >> ${D}/etc/${PN}.conf
    echo MODULENAME=${PN} >> ${D}/etc/${PN}.conf
    echo MODULEVERSION=${PV} >> ${D}/etc/${PN}.conf

    mkdir -p ${D}/usr/share/${PN}
    install -m755 ${FILE2_URI}buildmodule.sh ${D}/usr/share/${PN}
    install -m755 ${FILE2_URI}functions.sh ${D}/usr/share/${PN}

    mkdir -p ${D}/usr/sbin
    install -m755 ${FILE5_URI}/etermount ${D}/usr/sbin/etermount
    mkdir -p ${D}/etc/init.d
    mkdir -p ${D}/etc/conf.d
    install -m755 ${FILE3_URI}/etercifs ${D}/etc/init.d/etercifs
    install -m755 ${FILE3_URI}/etercifs.outformat ${D}/etc/init.d/etercifs.outformat
    install -m755 ${FILE3_URI}/etercifs ${D}/etc/conf.d/etercifs
    install -m755 ${FILE3_URI}/etercifs.outformat ${D}/etc/conf.d/etercifs.outformat


    ETERCIFS_SRC="usr/share/${PN}/sources"

    mkdir -p ${D}/${ETERCIFS_SRC}

    cp ${FILE_URI}/${SRC_PN}-2.6.16-${SRC_2_6_1623_VER}.tar.bz2 ${D}/${ETERCIFS_SRC}/${SRC_PN}-2.6.16-${SRC_2_6_1623_VER}.tar.bz2
    cp ${FILE_URI}/${SRC_PN}-2.6.23-${SRC_2_6_1623_VER}.tar.bz2 ${D}/${ETERCIFS_SRC}/${SRC_PN}-2.6.23-${SRC_2_6_1623_VER}.tar.bz2
    cp ${FILE_URI}/${SRC_PN}-2.6.24-${SRC_2_6_2425_VER}.tar.bz2 ${D}/${ETERCIFS_SRC}/${SRC_PN}-2.6.24-${SRC_2_6_2425_VER}.tar.bz2
    cp ${FILE_URI}/${SRC_PN}-2.6.25-${SRC_2_6_2425_VER}.tar.bz2 ${D}/${ETERCIFS_SRC}/${SRC_PN}-2.6.25-${SRC_2_6_2425_VER}.tar.bz2
    cp ${FILE_URI}/${SRC_PN}-2.6.26-${SRC_2_6_26_VER}.tar.bz2 ${D}/${ETERCIFS_SRC}/${SRC_PN}-2.6.26-${SRC_2_6_26_VER}.tar.bz2
    cp ${FILE_URI}/${SRC_PN}-2.6.27-${SRC_2_6_27_VER}.tar.bz2 ${D}/${ETERCIFS_SRC}/${SRC_PN}-2.6.27-${SRC_2_6_27_VER}.tar.bz2
    cp ${FILE_URI}/${SRC_PN}-2.6.28-${SRC_2_6_28_VER}.tar.bz2 ${D}/${ETERCIFS_SRC}/${SRC_PN}-2.6.28-${SRC_2_6_28_VER}.tar.bz2
    cp ${FILE_URI}/${SRC_PN}-2.6.29-${SRC_2_6_29_VER}.tar.bz2 ${D}/${ETERCIFS_SRC}/${SRC_PN}-2.6.29-${SRC_2_6_29_VER}.tar.bz2

	
}
