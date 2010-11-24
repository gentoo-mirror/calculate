# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux (meta package)"
HOMEPAGE="http://www.calculate-linux.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="distro_CLD distro_CLDG distro_CLDX distro_CDS distro_CLS distro_CSS"

RDEPEND="
	distro_CLD? ( app-misc/cld-meta )
	distro_CLDG? ( app-misc/cldg-meta )
	distro_CLDX? ( app-misc/cldx-meta )
	distro_CDS? ( app-misc/cds-meta )
	distro_CLS? ( app-misc/cls-meta )
	distro_CSS? ( app-misc/css-meta )
"

