# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit calculate

DESCRIPTION="Calculate Linux Desktop GNOME (meta package)"
HOMEPAGE="http://www.calculate-linux.org/main/en/cld"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="calculate_nognome calculate_nodecoration calculate_nographics
calculate_nomultimedia calculate_nonetwork calculate_nonettools
calculate_noprinter calculate_nooffice calculate_nowireless"

RDEPEND="${RDEPEND}
	!app-misc/cls-meta
	!app-misc/cl-dict-meta
	!app-misc/cl-desktop-meta
	!app-misc/cl-useful-meta
"

RDEPEND="
	app-misc/cl-base-meta
	app-misc/cl-tools-meta

	!calculate_nognome? (
		app-misc/cl-gnome-meta
	)
	!calculate_nodecoration? (
		app-misc/cl-decoration-meta
	)
	!calculate_nographics? (
		app-misc/cl-graphics-meta
	)
	!calculate_nomultimedia? (
		app-misc/cl-multimedia-meta
	)
	!calculate_nonetwork? (
		app-misc/cl-network-meta
	)
	!calculate_nonettools? (
		app-misc/cl-nettools-meta
	)
	!calculate_noprinter? (
		app-misc/cl-printer-meta
	)
	!calculate_nooffice? (
		app-misc/cl-office-meta
	)
	!calculate_nowireless? (
		app-misc/cl-wireless-meta
	)
"

pkg_postinst() {
	calculate_change_version

	local calculatename=$( get_value calculate < ${CALCULATE_INI} )
	local system=$( get_value system < ${CALCULATE_INI} )

	[[ "$calculatename" == "CLDG" ]] &&
	[[ -n "$(eselect profile show |
		grep calculate/${system}/${calculatename}/${ARCH}/developer)" ]] && 
		eselect profile set calculate/${system}/${calculatename}/${ARCH}
}
