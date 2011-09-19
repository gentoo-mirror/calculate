# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Media Center (meta package)"
HOMEPAGE="http://www.calculate-linux.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="
calculate_nodecoration
calculate_nokernel
calculate_nowireless
"

RDEPEND="${RDEPEND}
	app-misc/cl-base-meta
	app-misc/cl-tools-meta
	app-misc/cl-xorg-meta

	!calculate_nodecoration? ( app-misc/cl-decoration-meta )
	!calculate_nokernel? ( sys-kernel/calculate-sources )
	!calculate_nowireless? ( app-misc/cl-wireless-meta )

	app-misc/lirc
	app-text/wgetpaste
	media-tv/xbmc
	net-dialup/mingetty
	net-p2p/rtorrent
	net-misc/dhcp
	sys-power/upower
"

