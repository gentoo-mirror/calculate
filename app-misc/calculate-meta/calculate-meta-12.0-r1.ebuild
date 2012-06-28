# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit calculate

DESCRIPTION="Calculate Linux (meta package)"
HOMEPAGE="http://www.calculate-linux.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="
cdistro_CLD
cdistro_CLDG
cdistro_CLDX
cdistro_CMC
cdistro_CLS
cdistro_CDS
cdistro_CSS
"

RDEPEND="${RDEPEND}
	!sys-apps/calculate
"

RDEPEND="${RDEPEND}
	cdistro_CLD? ( app-misc/cld-meta )
	cdistro_CLDG? ( app-misc/cldg-meta )
	cdistro_CLDX? ( app-misc/cldx-meta )
	cdistro_CMC? ( app-misc/cmc-meta )
	cdistro_CLS? ( app-misc/cls-meta )
	cdistro_CDS? ( app-misc/cds-meta )
	cdistro_CSS? ( app-misc/css-meta )
"
