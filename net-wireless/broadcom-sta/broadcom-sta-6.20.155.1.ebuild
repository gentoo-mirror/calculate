# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/broadcom-sta/broadcom-sta-5.100.82.112-r2.ebuild,v 1.4 2012/05/22 02:55:18 zmedico Exp $

EAPI="4"
inherit eutils linux-mod

DESCRIPTION="Broadcom's IEEE 802.11a/b/g/n hybrid Linux device driver."
HOMEPAGE="https://launchpad.net/ubuntu/+source/bcmwl http://www.broadcom.com/support/802.11/linux_sta.php"
SRC_BASE="https://launchpad.net/ubuntu/+archive/primary/+files/bcmwl-kernel-source_"
SRC_URI="x86? ( ${SRC_BASE}${PV}%2Bbdcom-0ubuntu6_i386.deb )
	amd64? ( ${SRC_BASE}${PV}%2Bbdcom-0ubuntu6_amd64.deb )"

LICENSE="Broadcom"
KEYWORDS="amd64 x86"
IUSE=""

RESTRICT="mirror"

DEPEND="virtual/linux-sources"
RDEPEND=""

S="${WORKDIR}"

MODULE_NAMES="wl(net/wireless)"
MODULESD_WL_ALIASES=("wlan0 wl")

pkg_setup() {
	# bug #300570
	# NOTE<lxnay>: module builds correctly anyway with b43 and SSB enabled
	# make checks non-fatal. The correct fix is blackisting ssb and, perhaps
	# b43 via udev rules. Moreover, previous fix broke binpkgs support.
	CONFIG_CHECK="~!B43 ~!SSB"
	if kernel_is ge 2 6 32; then
		CONFIG_CHECK="${CONFIG_CHECK} CFG80211 LIB80211 ~!MAC80211"
	elif kernel_is ge 2 6 31; then
		CONFIG_CHECK="${CONFIG_CHECK} LIB80211 WIRELESS_EXT ~!MAC80211"
	elif kernel_is ge 2 6 29; then
		CONFIG_CHECK="${CONFIG_CHECK} LIB80211 WIRELESS_EXT ~!MAC80211 COMPAT_NET_DEV_OPS"
	else
		CONFIG_CHECK="${CONFIG_CHECK} IEEE80211 IEEE80211_CRYPT_TKIP"
	fi
	linux-mod_pkg_setup

	BUILD_PARAMS="-C ${KV_DIR} M=${S}"
	BUILD_TARGETS="wl.ko"
	KBASE="/lib/modules/${KV_FULL}"
	export KBASE
}

src_unpack() {
	if use x86
		then ar x "${DISTDIR}/bcmwl-kernel-source_${PV}%2Bbdcom-0ubuntu6_i386.deb" || \
			die "first extract failed"
	elif use amd64
		then ar x "${DISTDIR}/bcmwl-kernel-source_${PV}%2Bbdcom-0ubuntu6_amd64.deb" || \
			die "first extract failed"
	else die "don't know what to extract?"
	fi
	tar xzf "${WORKDIR}/data.tar.gz" || die "second extract failed"
}

src_prepare() {
	cd "${WORKDIR}/usr/src/bcmwl-${PV}+bdcom"
	for i in `ls patches/*.patch`
		do epatch ${i}
	done
	sed -e "s/dpkg --print-architecture),amd64/uname -m),x86_64/" \
		-e "s#\(\$(MDEST_DIR)\)#"${WORKDIR}"/image/\1#" \
		-i Makefile \
		|| die "sed in Makefile failed"
}

src_compile() {
	cd "${WORKDIR}/usr/src/bcmwl-${PV}+bdcom"
	if use x86
		then emake ARCH="i386"
	elif use amd64
		then emake ARCH="x86_64"
	fi
}

src_install() {
	cd "${WORKDIR}/usr/src/bcmwl-${PV}+bdcom"
	dodir /lib/modules/${KV_FULL}/kernel/drivers/net/wireless
	insinto /lib/modules/${KV_FULL}/kernel/drivers/net/wireless
	doins wl.ko
}
