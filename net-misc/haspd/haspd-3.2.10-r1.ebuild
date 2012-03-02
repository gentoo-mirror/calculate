# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit versionator linux-info linux-mod rpm

MY_R=eter"$(get_version_component_range 3)"gentoo
DESCRIPTION="Hardware Against Software Protection drivers and license managers"
HOMEPAGE=http://www.etersoft.ru

BASE_URI=ftp://updates.etersoft.ru/pub/Etersoft/HASP/3.2/sources/Gentoo/2009/
SRC_URI="${BASE_URI}/${PN}-$(get_version_component_range 1-2)-${MY_R}.src.rpm"

LICENSE=Proprietary
SLOT="0"
KEYWORDS="-* x86 amd64"
IUSE="lpt-hasp sentinel skey +wine demo"

S="${WORKDIR}"/"${PN}"-"$(get_version_component_range 1-2)"

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
	    /opt/lib/sentinel/usbdaemon
	    /opt/lib/sentinel/libusb-0.1.so.4
	    /opt/lib/sentinel/server/SntlKeysSrvrlnx
	    /opt/lib/sentinel/server/PwdGenUtility
	    /opt/lib/sentinel/server/libMD5CHAP.so
	    /opt/lib/sentinel/server/libcrypto.so
	    /opt/lib/sentinel/server/libssl.so
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

src_unpack() {
	rpm_src_unpack "${A}"
	tar -xf "${PN}"-"$(get_version_component_range 1-2)".tar
}

src_compile() {
	if use lpt-hasp; then
		cd "${S}"/aksparlnx
		make kernel26 KERNSRC=/usr/src/linux
	fi
}

src_install() {
	sed -i 's/\/usr\/sbin\/aksusbd/\/opt\/sbin\/aksusbd/g' aksusbd/udev/rules.d/80-hasp.rules
	insinto /etc/udev/rules.d/
	doins "${S}"/aksusbd/udev/rules.d/80-hasp.rules
	for i in aksusbd hasplm hasplmd; do
	    newconfd  "${FILESDIR}"/"${i}".conf.d "${i}"
	done
	insinto /etc/haspd
	doins "${S}"/hasplm/hasplm.conf

	DESTTREE="/opt"
	dosbin "${S}"/aksusbd/aksusbd
	dosbin "${S}"/hasplm/hasplm
	dosbin "${S}"/hasplmd/hasplmd
	doinitd  "${FILESDIR}"/{aksusbd,hasplm,hasplmd}

	docinto aksusbd
	dodoc aksusbd/readme.txt
	docinto hasplm
	dodoc hasplm/hasplm.txt
	docinto hasplmd
	dohtml hasplmd/readme.html
	docinto aksusbd
	dodoc aksusbd/readme.txt

	if use lpt-hasp; then
		insinto /"$(get_libdir)"/modules/"${KV_FULL}"/misc
		doins aksparlnx/aksparlnx.ko
	fi

	if use demo; then
		dosbin hasptest/{,net}haspdemo
	fi

	if use wine; then
		dosbin winehasp/winehasp
		insinto /opt/sbin
		doins winehasp/setwinehaspport.exe
		doinitd "${FILESDIR}"/winehasp
		newconfd "${FILESDIR}"/winehasp.conf.d winehasp
		docinto winehasp
		dodoc winehasp/readme.txt
	fi

	if use sentinel; then
		insopts -m755
		insinto /opt/lib/sentinel
		doins "${S}"/sentinel/libusb* "${S}"/sentinel/usbdaemon
		doins -r "${S}"/sentinel/server*
		doinitd "${FILESDIR}"/sentinel
		insopts -m644
		doins "${S}"/sentinel/sntlconfig.xml
		docinto sentinel
		dodoc sentinel/{"licenseagreement.txt","readme.pdf","ReadMe.pdf","SentinelSP+Addendum.pdf"}
	fi

	if use skey; then
		doinitd "${FILESDIR}"/skeyd
		dosbin "${S}"/smartkey-server-*/{skeyd,skeymon,skeysrv}
		insinto /etc
		doins "${S}"/smartkey-server-*/skeyd.conf
		doman "${S}"/smartkey-server-*/*.{1,5}
		newconfd "${FILESDIR}"/skeyd.conf.d skeyd
		docinto smartkey
		dodoc smartkey-server-*/{LEGGIMI,README.smartkey}
	fi
}

pkg_postinst() {
	if use lpt-hasp; then
		linux-mod_pkg_postinst
		if [[ ! -c "${ROOT}"/dev/Hardlock ]]; then
			ebegin "Creating Hardlock dev file"
			mknod "${ROOT}"/dev/Hardlock c 42 0
			chmod 0666 "${ROOT}"/dev/Hardlock
			eend $?
		fi
	fi
}
