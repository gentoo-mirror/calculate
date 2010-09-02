# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit distutils git

EGIT_COMMIT="2230227154f2cae0ab4795ad9c1fc040714dfa43"
EGIT_REPO_URI="git://git.calculate.ru/calculate-install.git"

DESCRIPTION="The program of installation Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="~sys-apps/calculate-lib-2.2.0.0_p20100902
	app-portage/layman
	sys-boot/grub
	sys-fs/dosfstools
	sys-block/parted"

RDEPEND="${DEPEND}"

pkg_postinst() {
	einfo "For configure calculate-install perform:"
	einfo "  cl-install --install"
}
