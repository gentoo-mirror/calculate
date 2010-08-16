# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit distutils git

EGIT_COMMIT="23dd76bcb4c175565c90e8dcec7354753bd5ddbe"
EGIT_REPO_URI="git://git.calculate.ru/calculate-templates.git"

DESCRIPTION="Templates for calculate utilities 2.2"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="!=sys-apps/calculate-lib-2.2.0.0_rc1"

RDEPEND="${DEPEND}"

src_compile() {
:
}

src_install() {
	dodir /usr/share/calculate/templates
	insinto /usr/share/calculate/templates
	doins -r *
}
