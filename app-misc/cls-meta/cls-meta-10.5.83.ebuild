# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit calculate

DESCRIPTION="Calculate Linux Scratch (meta package)"
HOMEPAGE="http://www.calculate-linux.org/main/en/cls"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="
	app-misc/css-meta
	app-misc/cl-printer-meta
	app-misc/cl-useful-meta
	app-misc/cl-wireless-meta
"

RDEPEND="${RDEPEND}
	net-misc/dhcp
	media-fonts/dejavu
	media-gfx/cls-themes
	www-client/chromium
	www-plugins/adobe-flash
	sys-apps/pcmciautils
	sys-apps/usb_modeswitch
	x11-base/xorg-x11
	x11-terms/rxvt-unicode
	x11-wm/openbox
"

cxxflags_present_in() {
	grep CXXFLAGS $1 &>/dev/null
	return $?
}

append_cxxflags_to() {
	sed -i '$aCXXFLAGS="\${CFLAGS}"' $1
}


pkg_postinst() {
	cxxflags_present_in /etc/make.conf || append_cxxflags_to /etc/make.conf
	calculate_change_version

	local calculatename=$( get_value calculate < ${CALCULATE_INI} )
	local system=$( get_value system < ${CALCULATE_INI} )

	[[ "$calculatename" == "CLS" ]] &&
	[[ -n "$(eselect profile show |
		grep calculate/${system}/${calculatename}/${ARCH}/developer)" ]] && 
		eselect profile set calculate/${system}/${calculatename}/${ARCH}
}
