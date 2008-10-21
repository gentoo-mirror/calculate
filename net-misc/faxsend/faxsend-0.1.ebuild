# Copyright 2008 Calculate Pack, http://www.calculate-linux.ru
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Sending fax or voice files using modem ZyXELOmni 56K"
HOMEPAGE="http://www.calculate-linux.ru/faxsend"
SRC_URI="ftp://ftp.local.calculate.ru/pub/${PN}/${P}.tar.bz2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=">=net-dialup/mgetty-1.1
		>=sci-libs/fftw-3.1
		>=dev-python/pyserial-2.2
		>=media-gfx/imagemagick-6.3"
#RDEPEND=""

src_compile() {
	emake || die
}

src_install() {
	emake install DESTDIR="${D}"
}
