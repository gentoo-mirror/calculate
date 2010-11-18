# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit distutils git eutils

EGIT_COMMIT="f7b2f45ee7b588814f18651f06a1b433036337f1"
EGIT_REPO_URI="git://git.calculate.ru/calculate-lib.git"

DESCRIPTION="The library for Calculate 2"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="2.2"
KEYWORDS="~amd64 ~x86"
IUSE="minimal"

DEPEND="~sys-apps/calculate-templates-2.2.1_rc8
	!<sys-apps/calculate-lib-2.1.8-r1
	!=sys-apps/calculate-lib-2.1.9
	!=sys-apps/calculate-lib-2.1.10
	!minimal? ( dev-python/py-smbpasswd )
	>=dev-python/pyxml-0.8
	sys-apps/file[python]"
RDEPEND="${DEPEND}"

pkg_postinst() {
	[[ -e ${ROOT}/etc/calculate/calculate2.env ]] && \
		sed -i '/^cl_pass_action/d' ${ROOT}/etc/calculate/calculate2.env
}
