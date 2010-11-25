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
IUSE="cdistro_CLD cdistro_CLDG cdistro_CLDX cdistro_CDS cdistro_CLS cdistro_CSS"

RDEPEND="
	cdistro_CLD? ( app-misc/cld-meta )
	cdistro_CLDG? ( app-misc/cldg-meta )
	cdistro_CLDX? ( app-misc/cldx-meta )
	cdistro_CDS? ( app-misc/cds-meta )
	cdistro_CLS? ( app-misc/cls-meta )
	cdistro_CSS? ( app-misc/css-meta )
"

