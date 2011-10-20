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
IUSE=""

RDEPEND="${RDEPEND}
	=sys-apps/calculate-install-3.0.9999
	=sys-apps/calculate-i18n-3.0.9999
	=sys-apps/calculate-lib-3.0.9999
"

