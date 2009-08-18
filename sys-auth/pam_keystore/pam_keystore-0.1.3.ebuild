# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# Copyright 2007-2009 Calculate Pack, http://www.calculate-linux.ru

DESCRIPTION="Keeps a login and the password the user in the kernel"
HOMEPAGE="http://www.calculate-linux.ru/pam_keystore"
SRC_URI="ftp://ftp.calculate.ru/pub/calculate/${PN}/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=">=sys-apps/keyutils-1.1"
RDEPEND="${DEPEND}"

src_compile() {
	make CFLAGS="-Wall ${CFLAGS}" || die
}

src_install() {
	emake install DESTDIR="${D}"
}
