# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

DISTUTILS_USE_SETUPTOOLS=manual
inherit distutils2

MY_P="${PN#py-}-${PV}"

DESCRIPTION="Module capable of generating both LANMAN and NT password hashes, for e.g. Samba"
HOMEPAGE="https://barryp.org/software/py-smbpasswd/"
SRC_URI="https://barryp.org/static/media/software/download/${PN}/${PV}/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ppc sparc x86"

DEPEND="
	dev-python/setuptools-python2[${PYTHON_USEDEP}]
"

S="${WORKDIR}/${MY_P}"
