# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux Scratch (meta package)"
HOMEPAGE="http://www.calculate-linux.org/main/en/cls"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="
calculate_nodecoration
calculate_nokernel
calculate_nonetwork
calculate_nonettools
calculate_noopenbox
calculate_noprinter
calculate_noxorg
calculate_nowireless
"

RDEPEND="
	>=sys-auth/pambase-20101024
	>=sys-apps/shadow-4.1.4.2-r6
	!app-misc/cl-useful-meta
"

RDEPEND="${RDEPEND}
	app-misc/cl-base-meta
	app-misc/cl-tools-meta

	!calculate_nodecoration? ( app-misc/cl-decoration-meta )
	!calculate_nokernel? ( sys-kernel/calculate-sources )
	!calculate_nonetwork? ( app-misc/cl-network-meta )
	!calculate_nonettools? ( app-misc/cl-nettools-meta )
	!calculate_noopenbox? ( app-misc/cl-openbox-meta )
	!calculate_noprinter? ( app-misc/cl-printer-meta )
	!calculate_noxorg? ( app-misc/xorg-meta )
	!calculate_nowireless? ( app-misc/cl-wireless-meta )
"
