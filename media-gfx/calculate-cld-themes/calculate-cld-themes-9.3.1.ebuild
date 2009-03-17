# Copyright 2008 Calculate Pack, http://www.calculate-linux.ru
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Themes for CLD"
HOMEPAGE="http://www.calculate-linux.ru/calcualte-cld-themes"
SRC_URI="ftp://mirror.yandex.ru/calculate/${PN}/${P}.tar.bz2
         http://mirror.yandex.ru/calculate/${PN}/${P}.tar.bz2
         ftp://ftp.linux.kiev.ua/pub/Linux/Calculate/${PN}/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
		insinto /
		dosym ../CalculateSplash/400x300 /usr/share/apps/ksplash/Themes/CalculateSplashRu/400x300
		dosym /usr/share/icons/Calculate/40x40/apps/1c.png /usr/share/pixmap/1c.png
		dosym /usr/share/icons/Calculate/40x40/apps/autocad.png /usr/share/pixmap/autocad.png
		dosym /usr/share/icons/Calculate/40x40/apps/corel.png /usr/share/pixmap/corel.png
		dosym /usr/share/icons/Calculate/40x40/apps/illustrator.png /usr/share/pixmap/illustrator.png
		dosym /usr/share/icons/Calculate/40x40/apps/photoshop.png /usr/share/pixmap/photoshop.png
		dosym /usr/share/icons/Calculate/40x40/apps/topplan.png /usr/share/pixmap/topplan.png
		dosym /usr/share/icons/Calculate/40x40/apps/windows.png /usr/share/pixmap/windows.png
		dosym /usr/share/icons/Calculate/40x40/apps/yellow.png /usr/share/pixmap/yellow.png
		doins -r .
}
