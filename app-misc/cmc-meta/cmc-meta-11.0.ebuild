# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Media Center"
HOMEPAGE="http://www.calculate-linux.org/main/en/cmc"
SRC_URI=""

LICENSE="GPL-2"
SLOT="11"
KEYWORDS="x86 amd64"
IUSE="
calculate_nodecoration
calculate_nokernel
calculate_nonetwork
calculate_nonettools
calculate_noopenbox
calculate_noprinter
calculate_nowireless
"

RDEPEND="
	!calculate_nodecoration? ( app-misc/cl-decoration-meta )
	!calculate_nokernel? ( sys-kernel/calculate-sources )
	!calculate_nonetwork? ( app-misc/cl-network-meta )
	!calculate_nonettools? ( app-misc/cl-nettools-meta )
	!calculate_noprinter? ( app-misc/cl-printer-meta )
	!calculate_nowireless? ( app-misc/cl-wireless-meta )
	!calculate_noopenbox? ( app-misc/cl-openbox-meta )
	cdistro_CMC? ( net-dialup/mingetty )
	media-tv/xbmc
"
