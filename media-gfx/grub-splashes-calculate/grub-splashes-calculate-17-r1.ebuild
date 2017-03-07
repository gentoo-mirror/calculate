# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Grub splashes for Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/packages/media-gfx/grub-splashes-calculate"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

SRC_URI="ftp://ftp.calculate-linux.org/calculate/themes/calculate/grub-17.png -> ${P}.png
	http://mirror.yandex.ru/calculate/themes/calculate/grub-17.png -> ${P}.png"

DEPEND=""

RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install() {
	insinto /usr/share/themes/Calculate/
	newins "${DISTDIR}"/${P}.png grub.png
}

