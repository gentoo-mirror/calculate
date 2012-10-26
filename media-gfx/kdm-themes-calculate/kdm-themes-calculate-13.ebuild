# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Kdm theme for Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/packages/media-gfx/lxdm-themes-calculate"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/themes/kdm/kdm-calculate-${PV}.tar.bz2"

REQUIRED_USE=""

RDEPEND="!media-gfx/cld-themes
	media-gfx/dm-themes-calculate"

DEPEND="${RDEPEND}"

src_install() {
	insinto /
	doins -r .
	dosym ../CalculateSplashEn/400x300 \
		/usr/share/apps/ksplash/Themes/CalculateSplashPt/400x300
	dosym ../CalculateSplashEn/400x300 \
		/usr/share/apps/ksplash/Themes/CalculateSplashDe/400x300
	dosym ../CalculateSplashEn/400x300 \
		/usr/share/apps/ksplash/Themes/CalculateSplashEs/400x300
	dosym ../CalculateSplashEn/400x300 \
		/usr/share/apps/ksplash/Themes/CalculateSplashFr/400x300
	dosym ../CalculateSplashEn/400x300 \
		/usr/share/apps/ksplash/Themes/CalculateSplashRo/400x300
	dosym ../CalculateSplashEn/400x300 \
		/usr/share/apps/ksplash/Themes/CalculateSplashRu/400x300
	dosym ../CalculateSplashEn/400x300 \
		/usr/share/apps/ksplash/Themes/CalculateSplashUk/400x300
	dosym ../CalculateSplashEn/400x300 \
		/usr/share/apps/ksplash/Themes/CalculateSplashIt/400x300
	dosym ../CalculateSplashEn/400x300 \
		/usr/share/apps/ksplash/Themes/CalculateSplashPl/400x300
	dosym ../CalculateSplashEn/400x300 \
		/usr/share/apps/ksplash/Themes/CalculateSplashBg/400x300
}

pkg_postinst() {
	ln -sf /usr/share/wallpapers/dm-background.png \
		/usr/share/apps/ksplash/Themes/CalculateSplashEn/400x300/background.png
}
