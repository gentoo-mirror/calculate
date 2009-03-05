# Copyright 2007 Calculate Pack, http://www.calculate-linux.ru
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Keeps a login and the password the user in the kernel"
HOMEPAGE="http://www.calculate-linux.ru/pam_keystore"
SRC_URI="ftp://mirror.yandex.ru/calculate/${PN}/${P}.tar.bz2
         http://mirror.yandex.ru/calculate/${PN}/${P}.tar.bz2
         ftp://ftp.linux.kiev.ua/pub/Linux/Calculate/${PN}/${P}.tar.bz2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
DEPEND=">=sys-apps/keyutils-1.1"
#RDEPEND=""

src_compile() {
	make CFLAGS="-Wall ${CFLAGS}" || die
}

src_install() {
	emake install DESTDIR="${D}"
}
