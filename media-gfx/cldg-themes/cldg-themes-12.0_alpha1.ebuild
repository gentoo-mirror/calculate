# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit calculate

DESCRIPTION="The theme for Calculate Linux Desktop CLDG"
HOMEPAGE="http://www.calculate-linux.org/calcualte-cldg-themes"
SRC_URI="ftp://ftp.calculate.ru/pub/calculate/${PN}/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="!media-gfx/calculate-cldx-themes
		!media-gfx/calculate-cld-themes
		!media-gfx/cldx-themes
		!media-gfx/cld-themes
		media-gfx/splashutils"

DEPEND="${RDEPEND}"

src_install() {
		insinto /
		dosym ../icons/Calculate/40x40/apps/1c.png \
			/usr/share/pixmaps/1c.png
		dosym ../icons/Calculate/40x40/apps/autocad.png \
			/usr/share/pixmaps/autocad.png
		dosym ../icons/Calculate/40x40/apps/corel.png \
			/usr/share/pixmaps/corel.png
		dosym ../icons/Calculate/40x40/apps/illustrator.png \
			/usr/share/pixmaps/illustrator.png
		dosym ../icons/Calculate/40x40/apps/photoshop.png \
			/usr/share/pixmaps/photoshop.png
		dosym ../icons/Calculate/40x40/apps/topplan.png \
			/usr/share/pixmaps/topplan.png
		dosym ../icons/Calculate/40x40/apps/windows.png \
			/usr/share/pixmaps/windows.png
		dosym ../icons/Calculate/40x40/apps/yellow.png \
			/usr/share/pixmaps/yellow.png
		dosym start-here-kde.svgz \
			/usr/share/icons/Calculate/scalable/places/kde.svgz
		doins -r .
}
