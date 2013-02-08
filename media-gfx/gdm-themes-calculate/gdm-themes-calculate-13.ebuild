# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Gdm theme for Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/packages/media-gfx/gdm-themes-calculate"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/themes/gdm/gdm-calculate-${PV}.tar.bz2"

REQUIRED_USE=""

RDEPEND="!media-gfx/cldg-themes
	media-gfx/dm-themes-calculate"

DEPEND="${RDEPEND}"

src_install() {
	insinto /
	doins -r .
}
