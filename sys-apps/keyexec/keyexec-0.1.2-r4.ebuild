# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Runs other programs with the user password, kept in the Linux kernel"
HOMEPAGE="http://www.calculate-linux.org/main/en/keyexec"
SRC_URI="ftp://ftp.calculate-linux.org/pub/calculate/${PN}/${P}.tar.bz2
		http://mirror.yandex.ru/calculate/${PN}/${P}.tar.bz2
		ftp://ftp.linux.kiev.ua/pub/Linux/Calculate/${PN}/${P}.tar.bz2"

LICENSE="Apache-2.0"

SLOT="0"

KEYWORDS="~amd64 ~x86"

IUSE="kde"

DEPEND="net-misc/rdesktop
	>=sys-apps/keyutils-1.1
	>=sys-auth/pam_keystore-0.1
	kde? ( >=kde-base/kdelibs-4.1.0 )"

RDEPEND="${DEPEND}"

src_compile() {
	emake CFLAGS="-Wall ${CFLAGS}" || die
}

src_install() {
	emake install DESTDIR="${D}"
}
