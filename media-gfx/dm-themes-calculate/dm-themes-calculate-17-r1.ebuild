# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Display manager wallpapers for Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/packages/media-gfx/dm-themes-calculate"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

SRC_URI="ftp://ftp.calculate-linux.org/calculate/themes/calculate/dm-login-${PV}.jpg -> ${PN}-login-${PV}.jpg
	http://mirror.yandex.ru/calculate/themes/calculate/dm-login-${PV}.jpg -> ${PN}-login-${PV}.jpg
	ftp://ftp.calculate-linux.org/calculate/themes/calculate/dm-splash-${PV}.jpg -> ${PN}-splash-${PV}.jpg
	http://mirror.yandex.ru/calculate/themes/calculate/dm-splash-${PV}.jpg -> ${PN}-splash-${PV}.jpg"

DEPEND="!<sys-apps/calculate-utils-3.5.2.6"

RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install() {
	insinto /usr/share/themes/Calculate/
	newins "${DISTDIR}"/${PN}-login-${PV}.jpg dm-login.jpg
	newins "${DISTDIR}"/${PN}-splash-${PV}.jpg dm-splash.jpg
}

