# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit calculate

DESCRIPTION="Calculate Scratch Server (meta package)"
HOMEPAGE="http://www.calculate-linux.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="calculate_nokernel"

RDEPEND="
	app-misc/cl-base-meta
	!calculate_nokernel? ( sys-kernel/calculate-sources )
"

# Network
RDEPEND="${RDEPEND}
	net-misc/dhcp
"
