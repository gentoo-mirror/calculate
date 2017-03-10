# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Calculate Linux theme for gensplash"
HOMEPAGE="http://www.calculate-linux.org/packages/media-gfx/calculate-splash-themes"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+verbose"

SRC_URI="ftp://ftp.calculate-linux.org/calculate/themes/calculate/splash-silent-17.jpg -> ${PN}-silent-17.jpg
	http://mirror.yandex.ru/calculate/themes/calculate/splash-silent-17.jpg -> ${PN}-silent-17.jpg
	ftp://ftp.calculate-linux.org/calculate/themes/calculate/splash-verbose-17.jpg -> ${PN}-verbose-17.jpg
	http://mirror.yandex.ru/calculate/themes/calculate/splash-verbose-17.jpg -> ${PN}-verbose-17.jpg
	ftp://ftp.calculate-linux.org/calculate/themes/calculate/splash-shutdown-17.jpg -> ${PN}-shutdown-17.jpg
	http://mirror.yandex.ru/calculate/themes/calculate/splash-shutdown-17.jpg -> ${PN}-shutdown-17.jpg"

DEPEND="media-gfx/splashutils
	media-fonts/droid
	!<sys-apps/calculate-utils-3.5.2.6"

RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install() {
	insinto /usr/share/themes/Calculate/
	newins "${DISTDIR}"/${PN}-silent-${PV}.jpg splash-silent.jpg
	newins "${DISTDIR}"/${PN}-shutdown-${PV}.jpg splash-shutdown.jpg
	if use verbose
	then
		newins "${DISTDIR}"/${PN}-verbose-${PV}.jpg splash-verbose.jpg
	fi
}

