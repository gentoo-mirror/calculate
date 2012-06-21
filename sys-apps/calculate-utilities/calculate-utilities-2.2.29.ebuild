# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="Calculate Utilities meta package"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="
cl_assemble
cl_builder
cl_client
cl_desktop
cl_server
"

RDEPEND="${RDEPEND}
	!sys-apps/calculate-templates
	!<sys-apps/calculate-install-3
	=sys-apps/calculate-lib-2.2.29
	=sys-apps/calculate-i18n-2.2.29

	cl_assemble? ( =sys-apps/calculate-assemble-2.2.29 )
	cl_builder? ( =sys-apps/calculate-builder-2.2.29 )
	cl_client? ( =sys-apps/calculate-client-2.2.29 )
	cl_desktop? ( =sys-apps/calculate-desktop-2.2.29 )

	cl_server? ( =sys-apps/calculate-server-2.1.15-r6 )
"
