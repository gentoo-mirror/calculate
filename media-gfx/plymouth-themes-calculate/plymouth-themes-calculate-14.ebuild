# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Plymouth themes for Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/packages/media-gfx/plymouth-themes-calculate"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/themes/plymouth/plymouth-calculate-14-r5.tar.bz2
	http://mirror.yandex.ru/calculate/themes/plymouth/plymouth-calculate-14-r5.tar.bz2"

RDEPEND="sys-boot/plymouth
sys-boot/plymouth-openrc-plugin
"

DEPEND="${RDEPEND}"

src_install() {
	dodir /usr/share/plymouth/themes/calculate
	insinto /usr/share/plymouth/themes/calculate
	doins *
	doins .plymouth_shutdown*
}
