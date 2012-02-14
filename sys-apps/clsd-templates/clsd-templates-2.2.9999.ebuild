# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit git-2

EGIT_REPO_URI="git://github.com/RodionD/CLsD-templates.git"

DESCRIPTION="Templates for calculate linux small desktop"
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
	dodir /var/calculate/templates
	insinto /var/calculate/templates
	doins -r *
}
