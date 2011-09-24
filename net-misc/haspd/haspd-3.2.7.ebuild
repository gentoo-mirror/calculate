# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# : $

EAPI="4"

inherit versionator linux-info

MY_R=eter$(get_version_component_range 3)gentoo
DESCRIPTION="HASP drivers and license managers"
HOMEPAGE=http://www.etersoft.ru

BASE_URI=ftp://updates.etersoft.ru/pub/Etersoft/WINE@Etersoft/last/HASP/Gentoo/2009/
SRC_URI="${BASE_URI}/${PN}-$(get_version_component_range 1-2)-${MY_R}.i586.tar.bz2
	lpt-hasp? ( ${BASE_URI}/${PN}-modules-$(get_version_component_range 1-2)-${MY_R}.i586.tar.bz2 )"

LICENSE=Proprietary
SLOT="0"
KEYWORDS="-* x86 amd64"
IUSE="-lpt-hasp -sentinel -skey +wine"
S="${WORKDIR}"

QA_EXECSTACK="usr/src/aksparlnx-3.2/api.o_shipped.x86
	    opt/sbin/nethaspdemo
	    opt/sbin/skeymon
	    opt/sbin/aksusbd
	    opt/sbin/hasplmd
	    opt/sbin/haspdemo
	    opt/sbin/skeyd
"
QA_PRESTRIPPED="/opt/sbin/skeymon
	    /opt/sbin/aksusbd
	    /opt/sbin/hasplmd
	    /opt/sbin/skeyd
	    /opt/sbin/hasplm
	    /opt/sbin/winehasp
	    /opt/lib/sentinel/libMD5CHAP.so
	    /opt/lib/sentinel/libcrypto.so.0.9.7
	    /opt/lib/sentinel/libusb-0.1.so.4
	    /opt/lib/sentinel/SntlKeysSrvrlnx
	    /opt/lib/sentinel/PwdGenUtility
	    /opt/lib/sentinel/libssl.so
	    /opt/lib/sentinel/usbsentinel
"

pkg_pretend() {
	linux-info_pkg_setup

	if ! linux_config_exists || ! linux_chkconfig_present USB_DEVICEFS; then
		echo
		ewarn "You have to use kernle with CONFIG_USB_DEVICEFS enabled"
		ewarn "  Device Drivers --->"
		ewarn "    USB support --->"
		ewarn "      [*]  USB device filesystem"
		die "Kernel configuration error"
	fi
	if [[ ! -f /proc/bus/usb/devices ]]; then
		ewarn "Before use hasp drivers you have to mount usbfs filesystem into /proc/bus/usb"
		ewarn "e.g.:  mount -t usbfs usbfs /proc/bus/usb -o rw,noexec,nosuid,devmode=0664,devgid=85"
	fi
		if ! linux_config_exists || ! linux_chkconfig_present && use lpt-hasp; then
			eerror "You have to use kernel with PARPORT_PC enabled"
			eerror "  Device Drivers --->"
			eerror "     <*> Parallel port support --->"
			eerror "	 <*> PC-style hardware"
			die "Kernel configuration error"
	fi
}

src_install() {
	insopts -m0755
	if use wine; then
		doinitd "${FILESDIR}"/winehasp
	else
		rm -f ${S}/usr/sbin/winehasp
	fi

	if use sentinel; then
		doinitd "${FILESDIR}"/sentinel
		insinto /opt
		doins -r ${S}/usr/lib*
	fi

	if use lpt-hasp; then
		insinto /usr
		doins -r ${S}/usr/src*
	fi

	insinto /etc
	for i in aksusbd hasplm hasplmd; do
	    doinitd  "${FILESDIR}"/${i}
	done

	if use skey; then
		insinto /etc
		insopts -m0664
		doins "${S}"/etc/skeyd.conf
		doman ${S}/usr/share/man/man1/*
		doman ${S}/usr/share/man/man5/*
		newconfd "${FILESDIR}"/skeyd.conf skeyd
		insopts -m755
		doinitd "${FILESDIR}"/skeyd
	else
		rm -rf ${WORKDIR}/sbin/skeyd ||  die "TEST"
	fi
	insinto /opt
	doins -r ${S}/usr/sbin*

	insopts -m664
	newconfd "${FILESDIR}"/aksusbd.conf aksusbd
	newconfd "${FILESDIR}"/hasplmd.conf hasplmd
	newconfd "${FILESDIR}"/hasplm.conf haspml
	newconfd "${FILESDIR}"/winehasp.conf winehasp
	insinto /etc/haspd
	doins "${S}"/etc/haspd/hasplm.conf

#exit 1
}

pkg_postinst() {
	if [[ ! -c "${ROOT}"/dev/Hardlock ]]; then
		ebegin "Creating Hardlock dev file"
		mknod ${ROOT}/dev/Hardlock c 42 0
		chmod 0666 ${ROOT}/dev/Hardlock
		eend $?
	fi
}
