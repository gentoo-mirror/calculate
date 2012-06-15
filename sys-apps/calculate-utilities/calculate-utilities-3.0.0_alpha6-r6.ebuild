# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Calculate Utilities meta package"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS="~amd64 ~x86"
IUSE="cl_consolegui cl_console"

RDEPEND="${RDEPEND}
	=sys-apps/calculate-install-3.0.0_alpha6
	=sys-apps/calculate-i18n-3.0.0_alpha6
	=sys-apps/calculate-lib-3.0.0_alpha6
	=sys-apps/calculate-core-3.0.0_alpha6-r4
	cl_consolegui? ( =sys-apps/calculate-console-gui-3.0.0_alpha6-r3 )
	cl_console? ( =sys-apps/calculate-console-3.0.0_alpha6-r3 )
"

