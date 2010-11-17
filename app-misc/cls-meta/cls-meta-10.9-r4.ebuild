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
KEYWORDS="x86 amd64"
IUSE="calculate_nodecoration calculate_nonetwork calculate_noprinter calculate_nowireless"

RDEPEND="
	>=sys-auth/pambase-20101024
	>=sys-apps/shadow-4.1.4.2-r6
	!app-misc/cl-useful-meta
"

RDEPEND="${RDEPEND}
	app-misc/cl-base-meta
	app-misc/cl-tools-meta

	!calculate_nodecoration? (
		app-misc/cl-decoration-meta
	)
	!calculate_nonetwork? (
		app-misc/cl-network-meta
	)
	!calculate_noprinter? (
		app-misc/cl-printer-meta
	)
	!calculate_nowireless? (
		app-misc/cl-wireless-meta
	)
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

	# check version on stable (PV has only 2 digit)
	if ! [[ "$PV" =~ ^[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+ ]]
	then
		[[ "$calculatename" == "CLS" ]] &&
		[[ -n "$(eselect profile show |
			grep calculate/${system}/${calculatename}/${ARCH}/developer)" ]] && 
			eselect profile set calculate/${system}/${calculatename}/${ARCH}
	fi
}
