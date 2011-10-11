# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit distutils git-2

EGIT_REPO_URI="git://git.calculate.ru/calculate-3/calculate-lib.git"

DESCRIPTION="The library for Calculate 2"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS="~amd64 ~x86"
IUSE="minimal"

DEPEND="~sys-apps/calculate-templates-2.2.9999
	!<sys-apps/calculate-lib-2.1.8-r1
	!=sys-apps/calculate-lib-2.1.9
	!=sys-apps/calculate-lib-2.1.10
	!minimal? ( dev-python/py-smbpasswd )
	>=dev-python/pyxml-0.8
	sys-apps/file[python]"
RDEPEND="${DEPEND}"
