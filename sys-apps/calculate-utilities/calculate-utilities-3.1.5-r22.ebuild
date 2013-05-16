# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Calculate Utilities meta package"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS="amd64 x86"
IUSE="cl_consolegui cl_client cl_desktop cl_console"

RDEPEND="${RDEPEND}
	=sys-apps/calculate-install-3.1.5-r14
	=sys-apps/calculate-i18n-3.1.5-r1
	=sys-apps/calculate-lib-3.1.5-r2
	=sys-apps/calculate-core-3.1.5-r1
	=sys-apps/calculate-update-3.1.5
	cl_client? ( =sys-apps/calculate-client-3.1.5-r4 )
	cl_desktop? ( =sys-apps/calculate-desktop-3.1.5-r4 )
	cl_consolegui? ( =sys-apps/calculate-console-gui-3.1.5-r2 )
	cl_console? ( =sys-apps/calculate-console-3.1.5 )
"
