# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 )

DISTUTILS_USE_SETUPTOOLS=manual
inherit distutils2

DESCRIPTION="Library to access Czech eGov system \"Datove schranky\""
HOMEPAGE="http://labs.nic.cz/page/969/datovka/"
SRC_URI="http://www.nic.cz/public_media/datove_schranky/releases//src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	dev-python/pyasn1-python2[${PYTHON_USEDEP}]
	dev-python/pyopenssl-python2[${PYTHON_USEDEP}]
	>=dev-python/sudsds-1.0.1[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	dev-python/setuptools-python2[${PYTHON_USEDEP}]
"
