# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Kdm theme for Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/packages/media-gfx/lxdm-themes-calculate"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/themes/kdm/kdm-calculate-${PV}.tar.bz2"

REQUIRED_USE=""

RDEPEND="!media-gfx/cld-themes
	media-gfx/dm-themes-calculate"

DEPEND="${RDEPEND}"

src_install() {
	insinto /
	doins -r .
}

pkg_postinst() {
	ln -sf /usr/share/wallpapers/dm-background.png \
		/usr/share/apps/ksplash/Themes/CalculateSplash/400x300/background.png
}
