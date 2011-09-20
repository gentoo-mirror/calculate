# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux Desktop KDE (meta package)"
HOMEPAGE="http://www.calculate-linux.org/main/en/cld"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="
calculate_nodecoration
calculate_nographics
calculate_nokde
calculate_nokernel
calculate_nomultimedia
calculate_nonetwork
calculate_nonettools
calculate_noprinter
calculate_nooffice
calculate_noxorg
calculate_nowireless
"

RDEPEND="
	!app-misc/cls-meta
	!app-misc/cl-dict-meta
	!app-misc/cl-desktop-meta
	!app-misc/cl-useful-meta
	!net-p2p/eiskaltdc
"
RDEPEND="${RDEPEND}
	app-misc/cl-base-meta
	app-misc/cl-tools-meta

	!calculate_nokde? ( app-misc/cl-kde-meta )
	!calculate_nodecoration? ( app-misc/cl-decoration-meta )
	!calculate_nographics? ( app-misc/cl-graphics-meta )
	!calculate_nokernel? ( sys-kernel/calculate-sources )
	!calculate_nomultimedia? ( app-misc/cl-multimedia-meta )
	!calculate_nonetwork? ( app-misc/cl-network-meta )
	!calculate_nonettools? ( app-misc/cl-nettools-meta )
	!calculate_noprinter? ( app-misc/cl-printer-meta )
	!calculate_nooffice? ( app-misc/cl-office-meta )
	!calculate_noxorg? ( app-misc/cl-xorg-meta )
	!calculate_nowireless? ( app-misc/cl-wireless-meta )
"
