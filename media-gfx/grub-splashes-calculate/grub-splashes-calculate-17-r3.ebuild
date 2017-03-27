# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Grub splashes for Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/packages/media-gfx/grub-splashes-calculate"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

SRC_URI="ftp://ftp.calculate-linux.org/calculate/themes/calculate/grub-17-r3.png -> ${P}-r3.png
	http://mirror.yandex.ru/calculate/themes/calculate/grub-17-r3.png -> ${P}-r3.png"

DEPEND="!<sys-apps/calculate-utils-3.5.2.6"

# need for templates
RDEPEND="${DEPEND}
	media-gfx/imagemagick"

S="${WORKDIR}"

src_install() {
	insinto /usr/share/themes/Calculate/
	newins "${DISTDIR}"/${P}-r3.png grub.png
}

