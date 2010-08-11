# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit distutils git

EGIT_COMMIT="47b302ca71e9c8d09a9078566067b48e358250dd"
EGIT_REPO_URI="git://git.calculate.ru/calculate-install.git"

DESCRIPTION="The program of installation Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="~sys-apps/calculate-lib-2.2.0.0_p20100811"

RDEPEND="${DEPEND}"

pkg_preinst() {
	local initd="calculate"
	local runlevel="boot"
	elog "Auto-adding '${initd}' service to your ${runlevel} runlevel"
	ln -snf /etc/init.d/${initd} "${ROOT}"/etc/runlevels/${runlevel}/${initd}
}
